#ifndef EXECINFO_H
#define EXECINFO_H

static int backtrace(void**,int){ return 0; }
static char** backtrace_symbols(void* const*,int){return NULL; }
static void backtrace_symbols_fd(void* const*,int,int){}

#endif
