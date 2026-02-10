# testing on qemu-riscv32-virt
.section .text
.global _start

_start:
    la a0, msg

print_loop:
    lbu a1, 0(a0)
    beqz a1, hang
    call uart_putc
    addi a0, a0, 1
    j print_loop

hang:
    j hang

uart_putc:
    li t0, 0x10000000
wait_tx:
    lbu t1, 5(t0)
    andi t1, t1, 0x20
    beqz t1, wait_tx
    sb a1, 0(t0)
    ret

msg:
    .asciz "Hello, World!\r\n"