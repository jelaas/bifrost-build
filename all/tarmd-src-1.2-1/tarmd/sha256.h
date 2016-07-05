#ifndef _SHA256_H
#define _SHA256_H

#include <inttypes.h>

#define SHA256_DIGEST_LENGTH 32

/* Structure to save state of computation between the single steps.  */
struct sha256_ctx
{
  uint32_t H[8];

  uint32_t total[2];
  uint32_t buflen;
  char buffer[128];	/* NB: always correctly aligned for uint32_t.  */
};

void sha256_init_ctx (struct sha256_ctx *ctx);
void sha256_process_bytes (const void *buffer, size_t len, struct sha256_ctx *ctx);
void *sha256_finish_ctx (struct sha256_ctx *ctx, void *resbuf);

#endif
