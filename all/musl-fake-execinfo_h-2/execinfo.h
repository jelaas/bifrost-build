#ifndef EXECINFO_H
#define EXECINFO_H

static int backtrace(void** __array,int __size){ return 0; }
static char** backtrace_symbols(void* const* __array,int __size){return '\0'; }
static void backtrace_symbols_fd(void* const* __array,int __size,int __fd){}

#endif
