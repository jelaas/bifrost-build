/*
 * jelopt version 2.0 2003-05-07
 * Functions for parsing command options.
 *
 *  Copyright: Jens Låås, SLU 2003
 *  Copyright license: According to GPL, see file COPYING in this directory.
 */

#ifndef JELOPT_H
#define JELOPT_H

/*
 * Definition of error flags optionally returned in 'err'.
 */
#define ERR_JELOPT_COUNT 1
#define ERR_JELOPT_MISSING_VALUE 2
#define ERR_JELOPT_VALUE_COLLISION 4
#define ERR_JELOPT_UNKNOWN 8

/*
 * Should be called in a while() to retrieve multiple opts of same name.
 * Any returned strings are malloc()'d and should be returned after use with free().
 * jelopt_multi return value array 'values' must be allocated before call with atleast
 * 'count'+1 elements. The last element is used for NULL-termination of the array.
 * If 'err' is not NULL, errorflags are ORd into *err. (err is a bitmask).
 * err container should initally be set to 0.
 * One of 'opt_short' or 'opt_long' may be NULL.
 * If 'value' is NULL, no value is expected.
 *
 * Returns: true if option found, false if not found.
 */
int jelopt(char **argv, int opt_short, char *opt_long,
	   char **value, int *err);
int jelopt_int(char **argv, int opt_short, char *opt_long,
	       int *value, int *err);
int jelopt_multi(char **argv, int opt_short, char *opt_long,
		 int count, char **values,
		 int *err);

/*
 * call after all opts parsed (removes '--' and used options)
 * Returns: argc (recomputed)
 */
int jelopt_final(char **argv, int *err);

#endif
