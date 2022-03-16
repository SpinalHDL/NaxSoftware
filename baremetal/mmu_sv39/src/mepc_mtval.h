
#define test_trap(code) \
    supervisor_setup_trap;\
    li x1, 1 << 36; code;\
    supervisor_handle_trap;\
;\
    supervisor_setup_trap;\
    li x1, 1 << 37; code;\
    supervisor_handle_trap;\
;\
    supervisor_setup_trap;\
    li x1, 1 << 38; code;\
    supervisor_handle_trap;\
    ;\
    supervisor_setup_trap;\
    li x1, ~((1 << 37)-1); code;\
    supervisor_handle_trap;\
;\
    supervisor_setup_trap;\
    li x1, ~((1 << 38)-1); code;\
    supervisor_handle_trap;\
;\
    supervisor_setup_trap;\
    li x1, ~((1 << 39)-1); code;\
    supervisor_handle_trap;\

#define LOAD lw x1, 0(x1)
#define STORE sw x1, 0(x1)
#define FETCH jalr x1

test_trap(LOAD)
test_trap(STORE)
test_trap(FETCH)