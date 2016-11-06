/* Buffer management for tar.

   Copyright (C) 1988, 1992, 1993, 1994, 1996, 1997, 1999, 2000, 2001,
   2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 Free Software
   Foundation, Inc.

   Written by John Gilmore, on 1985-08-25.

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 3, or (at your option) any later
   version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
   Public License for more details.

   You should have received a copy of the GNU General Public License along
   with this program; if not, write to the Free Software Foundation, Inc.,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */

#include <system.h>
#include <system-ioctl.h>

#include <signal.h>

#include <closeout.h>
#include <fnmatch.h>
#include <human.h>
#include <quotearg.h>

#include "common.h"
#include <rmt.h>

/* Number of retries before giving up on read.  */
#define READ_ERROR_MAX 10

/* Variables.  */

static tarlong prev_written;    /* bytes written on previous volumes */
static tarlong bytes_written;   /* bytes written on this volume */
static void *record_buffer[2];  /* allocated memory */
union block *record_buffer_aligned[2];
static int record_index;

/* FIXME: The following variables should ideally be static to this
   module.  However, this cannot be done yet.  The cleanup continues!  */

union block *record_start;      /* start of record of archive */
union block *record_end;        /* last+1 block of archive record */
union block *current_block;     /* current block of archive */
enum access_mode access_mode;   /* how do we handle the archive */
off_t records_read;             /* number of records read from this archive */
off_t records_written;          /* likewise, for records written */
extern off_t records_skipped;   /* number of records skipped at the start
                                   of the archive, defined in delete.c */   

static off_t record_start_block; /* block ordinal at record_start */

/* Where we write list messages (not errors, not interactions) to.  */
FILE *stdlis;

static void backspace_output (void);

/* PID of child program, if compress_option or remote archive access.  */
static pid_t child_pid;

/* Error recovery stuff  */
static int read_error_count;

/* Have we hit EOF yet?  */
static bool hit_eof;

static bool read_full_records = false;

/* We're reading, but we just read the last block and it's time to update.
   Declared in update.c

   As least EXTERN like this one as possible. (?? --gray)
   FIXME: Either eliminate it or move it to common.h.
*/
extern bool time_to_start_writing;

bool write_archive_to_stdout;

void (*flush_write_ptr) (size_t);
void (*flush_read_ptr) (void);


char *volume_label;
char *continued_file_name;
uintmax_t continued_file_size;
uintmax_t continued_file_offset;


static int volno = 1;           /* which volume of a multi-volume tape we're
                                   on */
static int global_volno = 1;    /* volume number to print in external
                                   messages */

bool write_archive_to_stdout;

/* Used by flush_read and flush_write to store the real info about saved
   names.  */
static char *real_s_name;
static off_t real_s_totsize;
static off_t real_s_sizeleft;


/* Multi-volume tracking support */
static char *save_name;         /* name of the file we are currently writing */
static off_t save_totsize;      /* total size of file we are writing, only
                                   valid if save_name is nonzero */
static off_t save_sizeleft;     /* where we are in the file we are writing,
                                   only valid if save_name is nonzero */


static struct tar_stat_info dummy;

void
buffer_write_global_xheader ()
{
  xheader_write_global (&dummy.xhdr);
}

void
mv_begin (struct tar_stat_info *st)
{
  if (multi_volume_option)
    {
      assign_string (&save_name,  st->orig_file_name);
      save_totsize = save_sizeleft = st->stat.st_size;
    }
}

void
mv_end ()
{
  if (multi_volume_option)
    assign_string (&save_name, 0);
}

void
mv_total_size (off_t size)
{
  save_totsize = size;
}

void
mv_size_left (off_t size)
{
  save_sizeleft = size;
}


/* Functions.  */

void
clear_read_error_count (void)
{
  read_error_count = 0;
}


/* Time-related functions */

double duration;

void
set_start_time ()
{
  gettime (&start_time);
  volume_start_time = start_time;
  last_stat_time = start_time;
}

void
set_volume_start_time ()
{
  gettime (&volume_start_time);
  last_stat_time = volume_start_time;
}

void
compute_duration ()
{
  struct timespec now;
  gettime (&now);
  duration += ((now.tv_sec - last_stat_time.tv_sec)
               + (now.tv_nsec - last_stat_time.tv_nsec) / 1e9);
  gettime (&last_stat_time);
}


/* Compression detection */

enum compress_type {
  ct_tar,              /* Plain tar file */
  ct_none,             /* Unknown compression type */
  ct_compress,
  ct_gzip,
  ct_bzip2,
  ct_lzip,
  ct_lzma,
  ct_lzop,
  ct_xz
};

struct zip_magic
{
  enum compress_type type;
  size_t length;
  char *magic;
  char *program;
  char *option;
};

static struct zip_magic const magic[] = {
  { ct_tar },
  { ct_none, },
  { ct_compress, 2, "\037\235",  COMPRESS_PROGRAM, "-Z" },
  { ct_gzip,     2, "\037\213",  GZIP_PROGRAM,     "-z"  },
  { ct_bzip2,    3, "BZh",       BZIP2_PROGRAM,    "-j" },
  { ct_lzip,     4, "LZIP",      LZIP_PROGRAM,     "--lzip" },
  { ct_lzma,     6, "\xFFLZMA",  LZMA_PROGRAM,     "--lzma" },
  { ct_lzop,     4, "\211LZO",   LZOP_PROGRAM,     "--lzop" },
  { ct_xz,       6, "\0xFD7zXZ", XZ_PROGRAM,       "-J" },
};

#define NMAGIC (sizeof(magic)/sizeof(magic[0]))

#define compress_option(t) magic[t].option
#define compress_program(t) magic[t].program

/* Check if the file ARCHIVE is a compressed archive. */
enum compress_type
check_compressed_archive (bool *pshort)
{
  struct zip_magic const *p;
  bool sfr;
  bool temp;

  if (!pshort)
    pshort = &temp;
  
  /* Prepare global data needed for find_next_block: */
  record_end = record_start; /* set up for 1st record = # 0 */
  sfr = read_full_records;
  read_full_records = true; /* Suppress fatal error on reading a partial
                               record */
  *pshort = find_next_block () == 0;
  
  /* Restore global values */
  read_full_records = sfr;

  if (tar_checksum (record_start, true) == HEADER_SUCCESS)
    /* Probably a valid header */
    return ct_tar;

  for (p = magic + 2; p < magic + NMAGIC; p++)
    if (memcmp (record_start->buffer, p->magic, p->length) == 0)
      return p->type;

  return ct_none;
}

/* Guess if the archive is seekable. */
static void
guess_seekable_archive ()
{
  struct stat st;

  if (subcommand_option == DELETE_SUBCOMMAND)
    {
      /* The current code in delete.c is based on the assumption that
	 skip_member() reads all data from the archive. So, we should
	 make sure it won't use seeks. On the other hand, the same code
	 depends on the ability to backspace a record in the archive,
	 so setting seekable_archive to false is technically incorrect.
         However, it is tested only in skip_member(), so it's not a
	 problem. */
      seekable_archive = false;
    }

  if (seek_option != -1)
    {
      seekable_archive = !!seek_option;
      return;
    }
  
  if (!multi_volume_option && !use_compress_program_option
      && fstat (archive, &st) == 0)
    seekable_archive = S_ISREG (st.st_mode);
  else
    seekable_archive = false;
}

/* Open an archive named archive_name_array[0]. Detect if it is
   a compressed archive of known type and use corresponding decompression
   program if so */
int
open_compressed_archive ()
{
  archive = rmtopen (archive_name_array[0], O_RDONLY | O_BINARY,
                     MODE_RW, rsh_command_option);
  if (archive == -1)
    return archive;

  if (!multi_volume_option)
    {
      if (!use_compress_program_option)
        {
          bool shortfile;
          enum compress_type type = check_compressed_archive (&shortfile);

          switch (type)
            {
            case ct_tar:
              if (shortfile)
                ERROR ((0, 0, _("This does not look like a tar archive")));
              return archive;
      
            case ct_none:
              if (shortfile)
                ERROR ((0, 0, _("This does not look like a tar archive")));
              set_comression_program_by_suffix (archive_name_array[0], NULL);
              if (!use_compress_program_option)
		return archive;
              break;

            default:
              use_compress_program_option = compress_program (type);
              break;
            }
        }
      
      /* FD is not needed any more */
      rmtclose (archive);
      
      hit_eof = false; /* It might have been set by find_next_block in
                          check_compressed_archive */

      /* Open compressed archive */
      child_pid = sys_child_open_for_uncompress ();
      read_full_records = true;
    }

  records_read = 0;
  record_end = record_start; /* set up for 1st record = # 0 */

  return archive;
}


static void
print_stats (FILE *fp, const char *text, tarlong numbytes)
{
  char bytes[sizeof (tarlong) * CHAR_BIT];
  char abbr[LONGEST_HUMAN_READABLE + 1];
  char rate[LONGEST_HUMAN_READABLE + 1];

  int human_opts = human_autoscale | human_base_1024 | human_SI | human_B;

  sprintf (bytes, TARLONG_FORMAT, numbytes);

  fprintf (fp, "%s: %s (%s, %s/s)\n",
           text, bytes,
           human_readable (numbytes, abbr, human_opts, 1, 1),
           (0 < duration && numbytes / duration < (uintmax_t) -1
            ? human_readable (numbytes / duration, rate, human_opts, 1, 1)
            : "?"));
}

void
print_total_stats ()
{
  switch (subcommand_option)
    {
    case CREATE_SUBCOMMAND:
    case CAT_SUBCOMMAND:
    case UPDATE_SUBCOMMAND:
    case APPEND_SUBCOMMAND:
      /* Amanda 2.4.1p1 looks for "Total bytes written: [0-9][0-9]*".  */
      print_stats (stderr, _("Total bytes written"),
                   prev_written + bytes_written);
      break;

    case DELETE_SUBCOMMAND:
      {
        char buf[UINTMAX_STRSIZE_BOUND];
        print_stats (stderr, _("Total bytes read"),
                     records_read * record_size);
        print_stats (stderr, _("Total bytes written"),
                     prev_written + bytes_written);
        fprintf (stderr, _("Total bytes deleted: %s\n"),
                 STRINGIFY_BIGINT ((records_read - records_skipped)
                                    * record_size
                                   - (prev_written + bytes_written), buf));
      }
      break;

    case EXTRACT_SUBCOMMAND:
    case LIST_SUBCOMMAND:
    case DIFF_SUBCOMMAND:
      print_stats (stderr, _("Total bytes read"),
                   records_read * record_size);
      break;

    default:
      abort ();
    }
}

/* Compute and return the block ordinal at current_block.  */
off_t
current_block_ordinal (void)
{
  return record_start_block + (current_block - record_start);
}

/* If the EOF flag is set, reset it, as well as current_block, etc.  */
void
reset_eof (void)
{
  if (hit_eof)
    {
      hit_eof = false;
      current_block = record_start;
      record_end = record_start + blocking_factor;
      access_mode = ACCESS_WRITE;
    }
}

/* Return the location of the next available input or output block.
   Return zero for EOF.  Once we have returned zero, we just keep returning
   it, to avoid accidentally going on to the next file on the tape.  */
union block *
find_next_block (void)
{
  if (current_block == record_end)
    {
      if (hit_eof)
        return 0;
      flush_archive ();
      if (current_block == record_end)
        {
          hit_eof = true;
          return 0;
        }
    }
  return current_block;
}

/* Indicate that we have used all blocks up thru BLOCK. */
void
set_next_block_after (union block *block)
{
  while (block >= current_block)
    current_block++;

  /* Do *not* flush the archive here.  If we do, the same argument to
     set_next_block_after could mean the next block (if the input record
     is exactly one block long), which is not what is intended.  */

  if (current_block > record_end)
    abort ();
}

/* Return the number of bytes comprising the space between POINTER
   through the end of the current buffer of blocks.  This space is
   available for filling with data, or taking data from.  POINTER is
   usually (but not always) the result of previous find_next_block call.  */
size_t
available_space_after (union block *pointer)
{
  return record_end->buffer - pointer->buffer;
}

/* Close file having descriptor FD, and abort if close unsuccessful.  */
void
xclose (int fd)
{
  if (close (fd) != 0)
    close_error (_("(pipe)"));
}

static void
init_buffer ()
{
  if (! record_buffer_aligned[record_index])
    record_buffer_aligned[record_index] =
      page_aligned_alloc (&record_buffer[record_index], record_size);

  record_start = record_buffer_aligned[record_index];
  current_block = record_start;
  record_end = record_start + blocking_factor;
}

/* Open an archive file.  The argument specifies whether we are
   reading or writing, or both.  */
static void
_open_archive (enum access_mode wanted_access)
{
  int backed_up_flag = 0;

  if (record_size == 0)
    FATAL_ERROR ((0, 0, _("Invalid value for record_size")));

  if (archive_names == 0)
    FATAL_ERROR ((0, 0, _("No archive name given")));

  tar_stat_destroy (&current_stat_info);
  save_name = 0;
  real_s_name = 0;

  record_index = 0;
  init_buffer ();

  /* When updating the archive, we start with reading.  */
  access_mode = wanted_access == ACCESS_UPDATE ? ACCESS_READ : wanted_access;

  read_full_records = read_full_records_option;

  records_read = 0;

  if (use_compress_program_option)
    {
      switch (wanted_access)
        {
        case ACCESS_READ:
          child_pid = sys_child_open_for_uncompress ();
          read_full_records = true;
          record_end = record_start; /* set up for 1st record = # 0 */
          break;

        case ACCESS_WRITE:
          child_pid = sys_child_open_for_compress ();
          break;

        case ACCESS_UPDATE:
          abort (); /* Should not happen */
          break;
        }

      if (!index_file_name
          && wanted_access == ACCESS_WRITE
          && strcmp (archive_name_array[0], "-") == 0)
        stdlis = stderr;
    }
  else if (strcmp (archive_name_array[0], "-") == 0)
    {
      read_full_records = true; /* could be a pipe, be safe */
      if (verify_option)
        FATAL_ERROR ((0, 0, _("Cannot verify stdin/stdout archive")));

      switch (wanted_access)
        {
        case ACCESS_READ:
          {
            bool shortfile;
            enum compress_type type;

            archive = STDIN_FILENO;

            type = check_compressed_archive (&shortfile);
            if (type != ct_tar && type != ct_none)
              FATAL_ERROR ((0, 0,
                            _("Archive is compressed. Use %s option"),
                            compress_option (type)));
            if (shortfile)
              ERROR ((0, 0, _("This does not look like a tar archive")));
          }
          break;

        case ACCESS_WRITE:
          archive = STDOUT_FILENO;
          if (!index_file_name)
            stdlis = stderr;
          break;

        case ACCESS_UPDATE:
          archive = STDIN_FILENO;
          write_archive_to_stdout = true;
          record_end = record_start; /* set up for 1st record = # 0 */
          if (!index_file_name)
            stdlis = stderr;
          break;
        }
    }
  else if (verify_option)
    archive = rmtopen (archive_name_array[0], O_RDWR | O_CREAT | O_BINARY,
                       MODE_RW, rsh_command_option);
  else
    switch (wanted_access)
      {
      case ACCESS_READ:
        archive = open_compressed_archive ();
	if (archive >= 0)
	  guess_seekable_archive ();
        break;

      case ACCESS_WRITE:
        if (backup_option)
          {
            maybe_backup_file (archive_name_array[0], 1);
            backed_up_flag = 1;
          }
        archive = rmtcreat (archive_name_array[0], MODE_RW,
                            rsh_command_option);
        break;

      case ACCESS_UPDATE:
        archive = rmtopen (archive_name_array[0],
                           O_RDWR | O_CREAT | O_BINARY,
                           MODE_RW, rsh_command_option);

        switch (check_compressed_archive (NULL))
          {
          case ct_none:
          case ct_tar:
            break;

          default:
            FATAL_ERROR ((0, 0,
                          _("Cannot update compressed archives")));
          }
        break;
      }

  if (archive < 0
      || (! _isrmt (archive) && !sys_get_archive_stat ()))
    {
      int saved_errno = errno;

      if (backed_up_flag)
        undo_last_backup ();
      errno = saved_errno;
      open_fatal (archive_name_array[0]);
    }

  sys_detect_dev_null_output ();
  sys_save_archive_dev_ino ();
  SET_BINARY_MODE (archive);

  switch (wanted_access)
    {
    case ACCESS_READ:
      find_next_block ();       /* read it in, check for EOF */
      break;

    case ACCESS_UPDATE:
    case ACCESS_WRITE:
      records_written = 0;
      break;
    }
}

/* Perform a write to flush the buffer.  */
ssize_t
_flush_write (void)
{
  ssize_t status;

  checkpoint_run (true);
  if (tape_length_option && tape_length_option <= bytes_written)
    {
      errno = ENOSPC;
      status = 0;
    }
  else if (dev_null_output)
    status = record_size;
  else
    status = sys_write_archive_buffer ();
  
  return status;
}

/* Handle write errors on the archive.  Write errors are always fatal.
   Hitting the end of a volume does not cause a write error unless the
   write was the first record of the volume.  */
void
archive_write_error (ssize_t status)
{
  /* It might be useful to know how much was written before the error
     occurred.  */
  if (totals_option)
    {
      int e = errno;
      print_total_stats ();
      errno = e;
    }

  write_fatal_details (*archive_name_cursor, status, record_size);
}

/* Handle read errors on the archive.  If the read should be retried,
   return to the caller.  */
void
archive_read_error (void)
{
  read_error (*archive_name_cursor);

  if (record_start_block == 0)
    FATAL_ERROR ((0, 0, _("At beginning of tape, quitting now")));

  /* Read error in mid archive.  We retry up to READ_ERROR_MAX times and
     then give up on reading the archive.  */

  if (read_error_count++ > READ_ERROR_MAX)
    FATAL_ERROR ((0, 0, _("Too many errors, quitting")));
  return;
}

static bool
archive_is_dev ()
{
  struct stat st;

  if (fstat (archive, &st))
    {
      stat_diag (*archive_name_cursor);
      return false;
    }
  return S_ISBLK (st.st_mode) || S_ISCHR (st.st_mode);
}

static void
short_read (size_t status)
{
  size_t left;                  /* bytes left */
  char *more;                   /* pointer to next byte to read */

  more = record_start->buffer + status;
  left = record_size - status;

  if (left && left % BLOCKSIZE == 0
      && verbose_option
      && record_start_block == 0 && status != 0
      && archive_is_dev ())
    {
      unsigned long rsize = status / BLOCKSIZE;
      WARN ((0, 0,
             ngettext ("Record size = %lu block",
                       "Record size = %lu blocks",
                       rsize),
             rsize));
    }

  while (left % BLOCKSIZE != 0
         || (left && status && read_full_records))
    {
      if (status)
        while ((status = rmtread (archive, more, left)) == SAFE_READ_ERROR)
          archive_read_error ();

      if (status == 0)
        break;

      if (! read_full_records)
        {
          unsigned long rest = record_size - left;

          FATAL_ERROR ((0, 0,
                        ngettext ("Unaligned block (%lu byte) in archive",
                                  "Unaligned block (%lu bytes) in archive",
                                  rest),
                        rest));
        }

      left -= status;
      more += status;
    }

  record_end = record_start + (record_size - left) / BLOCKSIZE;
  records_read++;
}

/*  Flush the current buffer to/from the archive.  */
void
flush_archive (void)
{
  size_t buffer_level = current_block->buffer - record_start->buffer;
  record_start_block += record_end - record_start;
  current_block = record_start;
  record_end = record_start + blocking_factor;

  if (access_mode == ACCESS_READ && time_to_start_writing)
    {
      access_mode = ACCESS_WRITE;
      time_to_start_writing = false;
      backspace_output ();
    }

  switch (access_mode)
    {
    case ACCESS_READ:
      flush_read ();
      break;

    case ACCESS_WRITE:
      flush_write_ptr (buffer_level);
      break;

    case ACCESS_UPDATE:
      abort ();
    }
}

/* Backspace the archive descriptor by one record worth.  If it's a
   tape, MTIOCTOP will work.  If it's something else, try to seek on
   it.  If we can't seek, we lose!  */
static void
backspace_output (void)
{
#ifdef MTIOCTOP
  {
    struct mtop operation;

    operation.mt_op = MTBSR;
    operation.mt_count = 1;
    if (rmtioctl (archive, MTIOCTOP, (char *) &operation) >= 0)
      return;
    if (errno == EIO && rmtioctl (archive, MTIOCTOP, (char *) &operation) >= 0)
      return;
  }
#endif

  {
    off_t position = rmtlseek (archive, (off_t) 0, SEEK_CUR);

    /* Seek back to the beginning of this record and start writing there.  */

    position -= record_size;
    if (position < 0)
      position = 0;
    if (rmtlseek (archive, position, SEEK_SET) != position)
      {
        /* Lseek failed.  Try a different method.  */

        WARN ((0, 0,
               _("Cannot backspace archive file; it may be unreadable without -i")));

        /* Replace the first part of the record with NULs.  */

        if (record_start->buffer != output_start)
          memset (record_start->buffer, 0,
                  output_start - record_start->buffer);
      }
  }
}

off_t
seek_archive (off_t size)
{
  off_t start = current_block_ordinal ();
  off_t offset;
  off_t nrec, nblk;
  off_t skipped = (blocking_factor - (current_block - record_start))
                  * BLOCKSIZE;

  if (size <= skipped)
    return 0;
  
  /* Compute number of records to skip */
  nrec = (size - skipped) / record_size;
  if (nrec == 0)
    return 0;
  offset = rmtlseek (archive, nrec * record_size, SEEK_CUR);
  if (offset < 0)
    return offset;

  if (offset % record_size)
    FATAL_ERROR ((0, 0, _("rmtlseek not stopped at a record boundary")));

  /* Convert to number of records */
  offset /= BLOCKSIZE;
  /* Compute number of skipped blocks */
  nblk = offset - start;

  /* Update buffering info */
  records_read += nblk / blocking_factor;
  record_start_block = offset - blocking_factor;
  current_block = record_end;

  return nblk;
}

/* Close the archive file.  */
void
close_archive (void)
{
  if (time_to_start_writing || access_mode == ACCESS_WRITE)
    {
      flush_archive ();
      if (current_block > record_start)
        flush_archive ();
    }

  compute_duration ();
  if (verify_option)
    verify_volume ();

  if (rmtclose (archive) != 0)
    close_error (*archive_name_cursor);

  sys_wait_for_child (child_pid, hit_eof);

  tar_stat_destroy (&current_stat_info);
  if (save_name)
    free (save_name);
  if (real_s_name)
    free (real_s_name);
  free (record_buffer[0]);
  free (record_buffer[1]);
}

/* Called to initialize the global volume number.  */
void
init_volume_number (void)
{
  FILE *file = fopen (volno_file_option, "r");

  if (file)
    {
      if (fscanf (file, "%d", &global_volno) != 1
          || global_volno < 0)
        FATAL_ERROR ((0, 0, _("%s: contains invalid volume number"),
                      quotearg_colon (volno_file_option)));
      if (ferror (file))
        read_error (volno_file_option);
      if (fclose (file) != 0)
        close_error (volno_file_option);
    }
  else if (errno != ENOENT)
    open_error (volno_file_option);
}

/* Called to write out the closing global volume number.  */
void
closeout_volume_number (void)
{
  FILE *file = fopen (volno_file_option, "w");

  if (file)
    {
      fprintf (file, "%d\n", global_volno);
      if (ferror (file))
        write_error (volno_file_option);
      if (fclose (file) != 0)
        close_error (volno_file_option);
    }
  else
    open_error (volno_file_option);
}


static void
increase_volume_number ()
{
  global_volno++;
  if (global_volno < 0)
    FATAL_ERROR ((0, 0, _("Volume number overflow")));
  volno++;
}

void
change_tape_menu (FILE *read_file)
{
  char *input_buffer = NULL;
  size_t size = 0;
  bool stop = false;
  
  while (!stop)
    {
      fputc ('\007', stderr);
      fprintf (stderr,
               _("Prepare volume #%d for %s and hit return: "),
               global_volno + 1, quote (*archive_name_cursor));
      fflush (stderr);

      if (getline (&input_buffer, &size, read_file) <= 0)
        {
          WARN ((0, 0, _("EOF where user reply was expected")));

          if (subcommand_option != EXTRACT_SUBCOMMAND
              && subcommand_option != LIST_SUBCOMMAND
              && subcommand_option != DIFF_SUBCOMMAND)
            WARN ((0, 0, _("WARNING: Archive is incomplete")));

          fatal_exit ();
        }

      if (input_buffer[0] == '\n'
          || input_buffer[0] == 'y'
          || input_buffer[0] == 'Y')
        break;

      switch (input_buffer[0])
        {
        case '?':
          {
            fprintf (stderr, _("\
 n name        Give a new file name for the next (and subsequent) volume(s)\n\
 q             Abort tar\n\
 y or newline  Continue operation\n"));
            if (!restrict_option)
              fprintf (stderr, _(" !             Spawn a subshell\n"));
            fprintf (stderr, _(" ?             Print this list\n"));
          }
          break;

        case 'q':
          /* Quit.  */

          WARN ((0, 0, _("No new volume; exiting.\n")));

          if (subcommand_option != EXTRACT_SUBCOMMAND
              && subcommand_option != LIST_SUBCOMMAND
              && subcommand_option != DIFF_SUBCOMMAND)
            WARN ((0, 0, _("WARNING: Archive is incomplete")));

          fatal_exit ();

        case 'n':
          /* Get new file name.  */

          {
            char *name;
            char *cursor;

            for (name = input_buffer + 1;
                 *name == ' ' || *name == '\t';
                 name++)
              ;

            for (cursor = name; *cursor && *cursor != '\n'; cursor++)
              ;
            *cursor = '\0';

            if (name[0])
              {
                /* FIXME: the following allocation is never reclaimed.  */
                *archive_name_cursor = xstrdup (name);
                stop = true;
              }
            else
              fprintf (stderr, "%s",
                       _("File name not specified. Try again.\n"));
          }
          break;

        case '!':
          if (!restrict_option)
            {
              sys_spawn_shell ();
              break;
            }
          /* FALL THROUGH */

        default:
          fprintf (stderr, _("Invalid input. Type ? for help.\n"));
        }
    }
  free (input_buffer);
}

/* We've hit the end of the old volume.  Close it and open the next one.
   Return nonzero on success.
*/
static bool
new_volume (enum access_mode mode)
{
  static FILE *read_file;
  static int looped;
  int prompt;

  if (!read_file && !info_script_option)
    /* FIXME: if fopen is used, it will never be closed.  */
    read_file = archive == STDIN_FILENO ? fopen (TTY_NAME, "r") : stdin;

  if (now_verifying)
    return false;
  if (verify_option)
    verify_volume ();

  assign_string (&volume_label, NULL);
  assign_string (&continued_file_name, NULL);
  continued_file_size = continued_file_offset = 0;
  current_block = record_start;
  
  if (rmtclose (archive) != 0)
    close_error (*archive_name_cursor);

  archive_name_cursor++;
  if (archive_name_cursor == archive_name_array + archive_names)
    {
      archive_name_cursor = archive_name_array;
      looped = 1;
    }
  prompt = looped;

 tryagain:
  if (prompt)
    {
      /* We have to prompt from now on.  */

      if (info_script_option)
        {
          if (volno_file_option)
            closeout_volume_number ();
          if (sys_exec_info_script (archive_name_cursor, global_volno+1))
            FATAL_ERROR ((0, 0, _("%s command failed"),
                          quote (info_script_option)));
        }
      else
        change_tape_menu (read_file);
    }

  if (strcmp (archive_name_cursor[0], "-") == 0)
    {
      read_full_records = true;
      archive = STDIN_FILENO;
    }
  else if (verify_option)
    archive = rmtopen (*archive_name_cursor, O_RDWR | O_CREAT, MODE_RW,
                       rsh_command_option);
  else
    switch (mode)
      {
      case ACCESS_READ:
        archive = rmtopen (*archive_name_cursor, O_RDONLY, MODE_RW,
                           rsh_command_option);
	guess_seekable_archive ();
        break;

      case ACCESS_WRITE:
        if (backup_option)
          maybe_backup_file (*archive_name_cursor, 1);
        archive = rmtcreat (*archive_name_cursor, MODE_RW,
                            rsh_command_option);
        break;

      case ACCESS_UPDATE:
        archive = rmtopen (*archive_name_cursor, O_RDWR | O_CREAT, MODE_RW,
                           rsh_command_option);
        break;
      }

  if (archive < 0)
    {
      open_warn (*archive_name_cursor);
      if (!verify_option && mode == ACCESS_WRITE && backup_option)
        undo_last_backup ();
      prompt = 1;
      goto tryagain;
    }

  SET_BINARY_MODE (archive);

  return true;
}

static bool
read_header0 (struct tar_stat_info *info)
{
  enum read_header rc;

  tar_stat_init (info);
  rc = read_header (&current_header, info, read_header_auto);
  if (rc == HEADER_SUCCESS)
    {
      set_next_block_after (current_header);
      return true;
    }
  ERROR ((0, 0, _("This does not look like a tar archive")));
  return false;
}

bool
try_new_volume ()
{
  size_t status;
  union block *header;
  enum access_mode acc;
  
  switch (subcommand_option)
    {
    case APPEND_SUBCOMMAND:
    case CAT_SUBCOMMAND:
    case UPDATE_SUBCOMMAND:
      acc = ACCESS_UPDATE;
      break;

    default:
      acc = ACCESS_READ;
      break;
    }

  if (!new_volume (acc))
    return true;
  
  while ((status = rmtread (archive, record_start->buffer, record_size))
         == SAFE_READ_ERROR)
    archive_read_error ();

  if (status != record_size)
    short_read (status);

  header = find_next_block ();
  if (!header)
    return false;

  switch (header->header.typeflag)
    {
    case XGLTYPE:
      {
	tar_stat_init (&dummy);
	if (read_header (&header, &dummy, read_header_x_global)
	    != HEADER_SUCCESS_EXTENDED)
	  {
	    ERROR ((0, 0, _("This does not look like a tar archive")));
	    return false;
	  }
	
        xheader_decode (&dummy); /* decodes values from the global header */
        tar_stat_destroy (&dummy);
	
	/* The initial global header must be immediately followed by
	   an extended PAX header for the first member in this volume.
	   However, in some cases tar may split volumes in the middle
	   of a PAX header. This is incorrect, and should be fixed
           in the future versions. In the meantime we must be
	   prepared to correctly list and extract such archives.

	   If this happens, the following call to read_header returns
	   HEADER_FAILURE, which is ignored.

	   See also tests/multiv07.at */
	       
	switch (read_header (&header, &dummy, read_header_auto))
	  {
	  case HEADER_SUCCESS:
	    set_next_block_after (header);
	    break;

	  case HEADER_FAILURE:
	    break;

	  default:
	    ERROR ((0, 0, _("This does not look like a tar archive")));
	    return false;
	  }
        break;
      }

    case GNUTYPE_VOLHDR:
      if (!read_header0 (&dummy))
        return false;
      tar_stat_destroy (&dummy);
      assign_string (&volume_label, current_header->header.name);
      set_next_block_after (header);
      header = find_next_block ();
      if (header->header.typeflag != GNUTYPE_MULTIVOL)
        break;
      /* FALL THROUGH */

    case GNUTYPE_MULTIVOL:
      if (!read_header0 (&dummy))
        return false;
      tar_stat_destroy (&dummy);
      assign_string (&continued_file_name, current_header->header.name);
      continued_file_size =
        UINTMAX_FROM_HEADER (current_header->header.size);
      continued_file_offset =
        UINTMAX_FROM_HEADER (current_header->oldgnu_header.offset);
      break;

    default:
      break;
    }

  if (real_s_name)
    {
      uintmax_t s;
      if (!continued_file_name
          || strcmp (continued_file_name, real_s_name))
        {
          if ((archive_format == GNU_FORMAT || archive_format == OLDGNU_FORMAT)
              && strlen (real_s_name) >= NAME_FIELD_SIZE
              && strncmp (continued_file_name, real_s_name,
                          NAME_FIELD_SIZE) == 0)
            WARN ((0, 0,
 _("%s is possibly continued on this volume: header contains truncated name"),
                   quote (real_s_name)));
          else
            {
              WARN ((0, 0, _("%s is not continued on this volume"),
                     quote (real_s_name)));
              return false;
            }
        }

      s = continued_file_size + continued_file_offset;

      if (real_s_totsize != s || s < continued_file_offset)
        {
          char totsizebuf[UINTMAX_STRSIZE_BOUND];
          char s1buf[UINTMAX_STRSIZE_BOUND];
          char s2buf[UINTMAX_STRSIZE_BOUND];

          WARN ((0, 0, _("%s is the wrong size (%s != %s + %s)"),
                 quote (continued_file_name),
                 STRINGIFY_BIGINT (save_totsize, totsizebuf),
                 STRINGIFY_BIGINT (continued_file_size, s1buf),
                 STRINGIFY_BIGINT (continued_file_offset, s2buf)));
          return false;
        }

      if (real_s_totsize - real_s_sizeleft != continued_file_offset)
        {
          char totsizebuf[UINTMAX_STRSIZE_BOUND];
          char s1buf[UINTMAX_STRSIZE_BOUND];
          char s2buf[UINTMAX_STRSIZE_BOUND];

          WARN ((0, 0, _("This volume is out of sequence (%s - %s != %s)"),
                 STRINGIFY_BIGINT (real_s_totsize, totsizebuf),
                 STRINGIFY_BIGINT (real_s_sizeleft, s1buf),
                 STRINGIFY_BIGINT (continued_file_offset, s2buf)));
         
          return false;
        }
    }

  increase_volume_number ();
  return true;
}


#define VOLUME_TEXT " Volume "
#define VOLUME_TEXT_LEN (sizeof VOLUME_TEXT - 1)

char *
drop_volume_label_suffix (const char *label)
{
  const char *p;
  size_t len = strlen (label);

  if (len < 1)
    return NULL;
  
  for (p = label + len - 1; p > label && isdigit ((unsigned char) *p); p--)
    ;
  if (p > label && p - (VOLUME_TEXT_LEN - 1) > label)
    {
      p -= VOLUME_TEXT_LEN - 1;
      if (memcmp (p, VOLUME_TEXT, VOLUME_TEXT_LEN) == 0)
	{
	  char *s = xmalloc ((len = p - label) + 1);
	  memcpy (s, label, len);
	  s[len] = 0;
	  return s;
	}
    }

  return NULL;
}
      
/* Check LABEL against the volume label, seen as a globbing
   pattern.  Return true if the pattern matches.  In case of failure,
   retry matching a volume sequence number before giving up in
   multi-volume mode.  */
static bool
check_label_pattern (const char *label)
{
  char *string;
  bool result;

  if (fnmatch (volume_label_option, label, 0) == 0)
    return true;

  if (!multi_volume_option)
    return false;

  string = drop_volume_label_suffix (label);
  if (string)
    {
      result = fnmatch (string, volume_label_option, 0) == 0;
      free (string);
    }
  return result;
}

/* Check if the next block contains a volume label and if this matches
   the one given in the command line */
static void
match_volume_label (void)
{
  if (!volume_label)
    {
      union block *label = find_next_block ();
  
      if (!label)
	FATAL_ERROR ((0, 0, _("Archive not labeled to match %s"),
		      quote (volume_label_option)));
      if (label->header.typeflag == GNUTYPE_VOLHDR)
	{
	  if (memchr (label->header.name, '\0', sizeof label->header.name))
	    assign_string (&volume_label, label->header.name);
	  else
	    {
	      volume_label = xmalloc (sizeof (label->header.name) + 1);
	      memcpy (volume_label, label->header.name,
		      sizeof (label->header.name));
	      volume_label[sizeof (label->header.name)] = 0;
	    }
	}
      else if (label->header.typeflag == XGLTYPE)
	{
	  struct tar_stat_info st;
	  tar_stat_init (&st);
	  xheader_read (&st.xhdr, label,
			OFF_FROM_HEADER (label->header.size));
	  xheader_decode (&st);
	  tar_stat_destroy (&st);
	}
    }
  
  if (!volume_label)
    FATAL_ERROR ((0, 0, _("Archive not labeled to match %s"),
                  quote (volume_label_option)));
  
  if (!check_label_pattern (volume_label))
    FATAL_ERROR ((0, 0, _("Volume %s does not match %s"),
                  quote_n (0, volume_label),
                  quote_n (1, volume_label_option)));
}

/* Mark the archive with volume label STR. */
static void
_write_volume_label (const char *str)
{
  if (archive_format == POSIX_FORMAT)
    xheader_store ("GNU.volume.label", &dummy, str);
  else
    {
      union block *label = find_next_block ();

      memset (label, 0, BLOCKSIZE);

      strcpy (label->header.name, str);
      assign_string (&current_stat_info.file_name,
                     label->header.name);
      current_stat_info.had_trailing_slash =
        strip_trailing_slashes (current_stat_info.file_name);

      label->header.typeflag = GNUTYPE_VOLHDR;
      TIME_TO_CHARS (start_time.tv_sec, label->header.mtime);
      finish_header (&current_stat_info, label, -1);
      set_next_block_after (label);
    }
}

#define VOL_SUFFIX "Volume"

/* Add a volume label to a part of multi-volume archive */
static void
add_volume_label (void)
{
  char buf[UINTMAX_STRSIZE_BOUND];
  char *p = STRINGIFY_BIGINT (volno, buf);
  char *s = xmalloc (strlen (volume_label_option) + sizeof VOL_SUFFIX
                     + strlen (p) + 2);
  sprintf (s, "%s %s %s", volume_label_option, VOL_SUFFIX, p);
  _write_volume_label (s);
  free (s);
}

static void
add_chunk_header ()
{
  if (archive_format == POSIX_FORMAT)
    {
      off_t block_ordinal;
      union block *blk;
      struct tar_stat_info st;
      static size_t real_s_part_no; /* FIXME */

      real_s_part_no++;
      memset (&st, 0, sizeof st);
      st.orig_file_name = st.file_name = real_s_name;
      st.stat.st_mode = S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH;
      st.stat.st_uid = getuid ();
      st.stat.st_gid = getgid ();
      st.orig_file_name = xheader_format_name (&st,
                                               "%d/GNUFileParts.%p/%f.%n",
                                               real_s_part_no);
      st.file_name = st.orig_file_name;
      st.archive_file_size = st.stat.st_size = real_s_sizeleft;

      block_ordinal = current_block_ordinal ();
      blk = start_header (&st);
      if (!blk)
        abort (); /* FIXME */
      finish_header (&st, blk, block_ordinal);
      free (st.orig_file_name);
    }
}


/* Add a volume label to the current archive */
static void
write_volume_label (void)
{
  if (multi_volume_option)
    add_volume_label ();
  else
    _write_volume_label (volume_label_option);
}

/* Write GNU multi-volume header */
static void
gnu_add_multi_volume_header (void)
{
  int tmp;
  union block *block = find_next_block ();

  if (strlen (real_s_name) > NAME_FIELD_SIZE)
    WARN ((0, 0,
           _("%s: file name too long to be stored in a GNU multivolume header, truncated"),
           quotearg_colon (real_s_name)));

  memset (block, 0, BLOCKSIZE);

  /* FIXME: Michael P Urban writes: [a long name file] is being written
     when a new volume rolls around [...]  Looks like the wrong value is
     being preserved in real_s_name, though.  */

  strncpy (block->header.name, real_s_name, NAME_FIELD_SIZE);
  block->header.typeflag = GNUTYPE_MULTIVOL;

  OFF_TO_CHARS (real_s_sizeleft, block->header.size);
  OFF_TO_CHARS (real_s_totsize - real_s_sizeleft,
                block->oldgnu_header.offset);

  tmp = verbose_option;
  verbose_option = 0;
  finish_header (&current_stat_info, block, -1);
  verbose_option = tmp;
  set_next_block_after (block);
}

/* Add a multi volume header to the current archive. The exact header format
   depends on the archive format. */
static void
add_multi_volume_header (void)
{
  if (archive_format == POSIX_FORMAT)
    {
      off_t d = real_s_totsize - real_s_sizeleft;
      xheader_store ("GNU.volume.filename", &dummy, real_s_name);
      xheader_store ("GNU.volume.size", &dummy, &real_s_sizeleft);
      xheader_store ("GNU.volume.offset", &dummy, &d);
    }
  else
    gnu_add_multi_volume_header ();
}

/* Synchronize multi-volume globals */
static void
multi_volume_sync ()
{
  if (multi_volume_option)
    {
      if (save_name)
        {
          assign_string (&real_s_name,
                         safer_name_suffix (save_name, false,
                                            absolute_names_option));
          real_s_totsize = save_totsize;
          real_s_sizeleft = save_sizeleft;
        }
      else
        {
          assign_string (&real_s_name, 0);
          real_s_totsize = 0;
          real_s_sizeleft = 0;
        }
    }
}


/* Low-level flush functions */

/* Simple flush read (no multi-volume or label extensions) */
static void
simple_flush_read (void)
{
  size_t status;                /* result from system call */

  checkpoint_run (false);
  
  /* Clear the count of errors.  This only applies to a single call to
     flush_read.  */

  read_error_count = 0;         /* clear error count */

  if (write_archive_to_stdout && record_start_block != 0)
    {
      archive = STDOUT_FILENO;
      status = sys_write_archive_buffer ();
      archive = STDIN_FILENO;
      if (status != record_size)
        archive_write_error (status);
    }

  for (;;)
    {
      status = rmtread (archive, record_start->buffer, record_size);
      if (status == record_size)
        {
          records_read++;
          return;
        }
      if (status == SAFE_READ_ERROR)
        {
          archive_read_error ();
          continue;             /* try again */
        }
      break;
    }
  short_read (status);
}

/* Simple flush write (no multi-volume or label extensions) */
static void
simple_flush_write (size_t level __attribute__((unused)))
{
  ssize_t status;

  status = _flush_write ();
  if (status != record_size)
    archive_write_error (status);
  else
    {
      records_written++;
      bytes_written += status;
    }
}


/* GNU flush functions. These support multi-volume and archive labels in
   GNU and PAX archive formats. */

static void
_gnu_flush_read (void)
{
  size_t status;                /* result from system call */

  checkpoint_run (false);
  
  /* Clear the count of errors.  This only applies to a single call to
     flush_read.  */

  read_error_count = 0;         /* clear error count */

  if (write_archive_to_stdout && record_start_block != 0)
    {
      archive = STDOUT_FILENO;
      status = sys_write_archive_buffer ();
      archive = STDIN_FILENO;
      if (status != record_size)
        archive_write_error (status);
    }

  multi_volume_sync ();

  for (;;)
    {
      status = rmtread (archive, record_start->buffer, record_size);
      if (status == record_size)
        {
          records_read++;
          return;
        }

      /* The condition below used to include
              || (status > 0 && !read_full_records)
         This is incorrect since even if new_volume() succeeds, the
         subsequent call to rmtread will overwrite the chunk of data
         already read in the buffer, so the processing will fail */
      if ((status == 0
           || (status == SAFE_READ_ERROR && errno == ENOSPC))
          && multi_volume_option)
        {
          while (!try_new_volume ())
            ;
	  if (current_block == record_end)
	    /* Necessary for blocking_factor == 1 */
	    flush_archive();
          return;
        }
      else if (status == SAFE_READ_ERROR)
        {
          archive_read_error ();
          continue;
        }
      break;
    }
  short_read (status);
}

static void
gnu_flush_read (void)
{
  flush_read_ptr = simple_flush_read; /* Avoid recursion */
  _gnu_flush_read ();
  flush_read_ptr = gnu_flush_read;
}

static void
_gnu_flush_write (size_t buffer_level)
{
  ssize_t status;
  union block *header;
  char *copy_ptr;
  size_t copy_size;
  size_t bufsize;
  tarlong wrt;
  
  status = _flush_write ();
  if (status != record_size && !multi_volume_option)
    archive_write_error (status);
  else
    {
      if (status)
        records_written++; 
      bytes_written += status;
    }

  if (status == record_size)
    {
      multi_volume_sync ();
      return;
    }

  if (status % BLOCKSIZE)
    {
      ERROR ((0, 0, _("write did not end on a block boundary")));
      archive_write_error (status);
    }
  
  /* In multi-volume mode. */
  /* ENXIO is for the UNIX PC.  */
  if (status < 0 && errno != ENOSPC && errno != EIO && errno != ENXIO)
    archive_write_error (status);

  real_s_sizeleft -= status;
  if (!new_volume (ACCESS_WRITE))
    return;

  tar_stat_destroy (&dummy);

  increase_volume_number ();
  prev_written += bytes_written;
  bytes_written = 0;

  copy_ptr = record_start->buffer + status;
  copy_size = buffer_level - status;
                   
  /* Switch to the next buffer */
  record_index = !record_index;
  init_buffer ();

  if (volume_label_option)
    add_volume_label ();

  if (real_s_name)
    add_multi_volume_header ();

  write_extended (true, &dummy, find_next_block ());
  tar_stat_destroy (&dummy);
  
  if (real_s_name)
    add_chunk_header ();
  wrt = bytes_written;
  header = find_next_block ();
  bufsize = available_space_after (header);
  while (bufsize < copy_size)
    {
      memcpy (header->buffer, copy_ptr, bufsize);
      copy_ptr += bufsize;
      copy_size -= bufsize;
      set_next_block_after (header + (bufsize - 1) / BLOCKSIZE);
      header = find_next_block ();
      bufsize = available_space_after (header);
    }
  memcpy (header->buffer, copy_ptr, copy_size);
  memset (header->buffer + copy_size, 0, bufsize - copy_size);
  set_next_block_after (header + (copy_size - 1) / BLOCKSIZE);
  if (multi_volume_option && wrt < bytes_written)
    {
      /* The value of bytes_written has changed while moving data;
         that means that flush_archive was executed at least once in
         between, and, as a consequence, copy_size bytes were not written
         to disk.  We need to update sizeleft variables to compensate for
         that. */
      save_sizeleft += copy_size;
      multi_volume_sync ();
    }
  find_next_block ();
}

static void
gnu_flush_write (size_t buffer_level)
{
  flush_write_ptr = simple_flush_write; /* Avoid recursion */
  _gnu_flush_write (buffer_level);
  flush_write_ptr = gnu_flush_write;
}

void
flush_read ()
{
  flush_read_ptr ();
}

void
flush_write ()
{
  flush_write_ptr (record_size);
}

void
open_archive (enum access_mode wanted_access)
{
  flush_read_ptr = gnu_flush_read;
  flush_write_ptr = gnu_flush_write;

  _open_archive (wanted_access);
  switch (wanted_access)
    {
    case ACCESS_READ:
      if (volume_label_option)
        match_volume_label ();
      break;

    case ACCESS_WRITE:
      records_written = 0;
      if (volume_label_option)
        write_volume_label ();
      break;

    default:
      break;
    }
  set_volume_start_time ();
}
