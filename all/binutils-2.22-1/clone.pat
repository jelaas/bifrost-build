--- gas/config/obj-elf.c.orig	Fri Aug 22 14:23:17 2014
+++ gas/config/obj-elf.c	Fri Aug 22 14:24:09 2014
@@ -741,10 +741,10 @@
 }
 
 static bfd_vma
-obj_elf_parse_section_letters (char *str, size_t len, bfd_boolean *clone)
+obj_elf_parse_section_letters (char *str, size_t len, bfd_boolean *cclone)
 {
   bfd_vma attr = 0;
-  *clone = FALSE;
+  *cclone = FALSE;
 
   while (len > 0)
     {
@@ -775,7 +775,7 @@
 	  attr |= SHF_TLS;
 	  break;
 	case '?':
-	  *clone = TRUE;
+	  *cclone = TRUE;
 	  break;
 	/* Compatibility.  */
 	case 'm':
@@ -978,7 +978,7 @@
 
       if (*input_line_pointer == '"')
 	{
-	  bfd_boolean clone;
+	  bfd_boolean cclone;
 
 	  beg = demand_copy_C_string (&dummy);
 	  if (beg == NULL)
@@ -986,7 +986,7 @@
 	      ignore_rest_of_line ();
 	      return;
 	    }
-	  attr |= obj_elf_parse_section_letters (beg, strlen (beg), &clone);
+	  attr |= obj_elf_parse_section_letters (beg, strlen (beg), &cclone);
 
 	  SKIP_WHITESPACE ();
 	  if (*input_line_pointer == ',')
@@ -1038,10 +1038,10 @@
 	      attr &= ~SHF_MERGE;
 	    }
 
-	  if ((attr & SHF_GROUP) != 0 && clone)
+	  if ((attr & SHF_GROUP) != 0 && cclone)
 	    {
 	      as_warn (_("? section flag ignored with G present"));
-	      clone = FALSE;
+	      cclone = FALSE;
 	    }
 	  if ((attr & SHF_GROUP) != 0 && *input_line_pointer == ',')
 	    {
@@ -1063,7 +1063,7 @@
 	      attr &= ~SHF_GROUP;
 	    }
 
-	  if (clone)
+	  if (cclone)
 	    {
 	      const char *now_group = elf_group_name (now_seg);
 	      if (now_group != NULL)
