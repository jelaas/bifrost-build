/* usbreset -- send a USB port reset to a USB device */

/* Possibly written by Alan Stern <stern () rowland ! harvard ! edu> */

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#include <linux/usbdevice_fs.h>


int main(int argc, char **argv)
{
	const char *filename;
	int fd;
	int rc;

	if(argc == 2 && !strcmp(argv[1], "-h"))
		goto usage;
	if(argc == 2 && !strcmp(argv[1], "--help"))
		goto usage;
	if (argc != 2) {
usage:
		fprintf(stderr, "Usage: usbreset device-filename\nExample: usbreset /dev/bus/usb/002/003\n");
		return 1;
	}
	filename = argv[1];

	fd = open(filename, O_WRONLY);
	if (fd < 0) {
		perror("Error opening output file");
		return 1;
	}

	printf("Resetting USB device %s\n", filename);
	rc = ioctl(fd, USBDEVFS_RESET, 0);
	if (rc < 0) {
		perror("Error in ioctl");
		return 1;
	}
	printf("Reset successful\n");

	close(fd);
	return 0;
}
