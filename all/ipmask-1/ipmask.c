/* ipmask.c
 *
 * Given argv[1] as a decimal netmask and argv[2] as a decimal IP address,
 * print the resulting broadcast and network addresses to stdout.  This is
 * potentially useful in scripts which need the broadcast address and the
 * network address but want to ask the user as few questions as possible.
 *
 * Copyright 1994 by David Niemi.  Written in about 30 minutes on 13 Aug.
 * The author places no restrictions on the use of this program, provided
 * that this copyright is preserved in any derived source code.
 *
 * Typical compilation command for Linux:
 *	cc ipmask.c -Wall -O -m486 -N -o ipmask -s
 */

#define MYNAME "ipmask"

#include <stdio.h>

void Usage(void) {
	fprintf (stderr,
		"USAGE: %s <decimal netmask> <decimal IP address>\n",
		MYNAME);
}

int main(int argc, char *argv[])
{
unsigned long netmask, ipaddr, netaddr, broadcast;
int in[4], j;
unsigned char bc[4],na[4];

	if (3 != argc) {
		Usage();
		exit(1);
	}

	/* Check netmask */
	if (4 != sscanf(argv[1],"%d.%d.%d.%d", &in[0],&in[1],&in[2],&in[3])) {
		fprintf (stderr,"Invalid netmask \"%s\".\n", argv[1]);
		Usage();
		exit(1);
	}
	for (j=0; j<4; ++j) {
		if (in[j]<0 || in[j]>255) {
			fprintf (stderr,
				"Invalid octet %d in netmask \"%s\".\n",
				j+1, argv[1]);
			Usage();
			exit(1);
		}
	}
	netmask = in[3] + 256 * (in[2] + 256 * (in[1] + 256 * in[0]));

	/* Check IP address */
	if (4 != sscanf(argv[2],"%d.%d.%d.%d", &in[0],&in[1],&in[2],&in[3])) {
		fprintf (stderr,"Invalid IP address \"%s\".\n", argv[2]);
		Usage();
		exit(1);
	}
	for (j=0; j<4; ++j) {
		if (in[j]<0 || in[j]>255) {
			fprintf (stderr,
				"Invalid octet %d in IP address \"%s\".\n",
				j+1, argv[1]);
			Usage();
			exit(1);
		}
	}
	ipaddr = in[3] + 256 * (in[2] + 256 * (in[1] + 256 * in[0]));

	broadcast = ipaddr | (~ netmask);
	bc[0] = broadcast / 256 / 256 / 256;
	bc[1] = (broadcast / 256 / 256) % 256;
	bc[2] = (broadcast / 256) % 256;
	bc[3] = broadcast % 256;

	netaddr = ipaddr & netmask;
	na[0] = netaddr / 256 / 256 / 256;
	na[1] = (netaddr / 256 / 256) % 256;
	na[2] = (netaddr / 256) % 256;
	na[3] = netaddr % 256;

	printf ("%d.%d.%d.%d %d.%d.%d.%d\n",
		bc[0], bc[1], bc[2], bc[3], na[0], na[1], na[2], na[3]);

	exit(0);
}
