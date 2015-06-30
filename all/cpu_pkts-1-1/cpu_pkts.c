#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

/* GPL licensed by Robert Olsson robert@herjulf.net */

#define MAX 128
#define TMP "/tmp/cpu_pkts.tmp"

int main(int ac, char **av)
{
        FILE *fp;
        int err = 0;
	int i, ncpu;
	int first = 0;
	unsigned int ss [2] [MAX];
	char *file =  "/proc/net/softnet_stat";


	fp = fopen(file, "r");
	if(fp == NULL) {
	  perror("failed to open /proc/net/softnet_stat");
	  exit(-1);
	}

	for(i=0; i<MAX; i++) {
	  err = fscanf(fp, "%x %*[^\n]", &ss[0][i]);
	  
	  if(feof(fp))
	    break;
	}

	ncpu = i;
	fclose(fp);

	fp = fopen( TMP, "r"); 
	if(fp == NULL) 
	  first = 1;
	
	if(!first) {
	  for(i=0;i< ncpu; i++) {
	    err = fscanf(fp, "%x%*[^\n]", &ss[1][i]);
	  }
	  fclose(fp);
	  	  
	  for(i=0;i< ncpu; i++) {
	    fprintf(stdout, "%u %u\n", i, ss[0][i] - ss[1][i]);
	  }
	}

	fp = fopen( TMP,  "w"); 
	for(i=0;i< ncpu; i++){
	  fprintf(fp, "%x\n", ss[0][i]);
	}
	fclose(fp);
	return(1);
}
	
