#undef _POSIX_SOURCE
#include <string.h>
#include <sys/capability.h>
#include <stdlib.h>

/* determine if current process has all capabilities enabled */

void put(int fd, const char *s)
{
	write(fd, s, strlen(s));
}

int main(int argc, char **argv)
{
	struct __user_cap_header_struct hdr;
	struct __user_cap_data_struct data[2];
	
	memset(&hdr, 0, sizeof(hdr));
	memset(&data, 0, sizeof(data));
	
	hdr.version = _LINUX_CAPABILITY_VERSION_3;
	hdr.pid = 0;
	
	if(capget(&hdr, &data[0])) {
		put(2, "capget() error\n");
		exit(2);
	}
	
	if(argc > 1) {
		int i, p;
		for(p=1;p>=0;p--) {
			for(i=31;i>=0;i--) {
				if(data[p].permitted & 1<<i)
					put(1, "x");
				else
					put(1, "-");
			}
		}
		put(1, "\n");
	}
	
	/* this cap may be turned off by default depending on kernel config */
	data[0].permitted |= (1 << CAP_SETPCAP);
	
	if(data[0].permitted == 0xffffffff &&
	   data[1].permitted == 0xffffffff) {
		put(1, "yes\n");
		exit(0);
	}
	put(1, "no\n");
	exit(1);
}
