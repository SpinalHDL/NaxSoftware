#include "type.h"
#include "riscv.h"

#define REPEAT2(that) \
  that; \
  that;

#define REPEAT4(that)    REPEAT2(that);  REPEAT2(that);
#define REPEAT8(that)    REPEAT4 (that); REPEAT4 (that);
#define REPEAT16(that)   REPEAT8 (that); REPEAT8 (that);
#define REPEAT32(that)   REPEAT16(that); REPEAT16(that);




