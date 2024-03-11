    .text
    .align 2
    .global main

main:
    @prologue
    stmfd sp!, {r0, r1, r2, r3, r4, fp, lr}
    ldr r3, [r1, #4]  @ r1 : Store "ARGUMENT" => r3.
    mov r4, #0  @ r4 : For counting the number of "characters".

    @code body
LOOP:
    ldrb r0, [r3], #1  @ LOAD "characters" into r0.
    add r4, r4, #1  @ counter ++
    cmp r0, #0  @ if "end of argument", exit LOOP.
    bne LOOP
    add r4, r4, #1
LASTtoFIRST:
    ldrb r0, [r3], #-1
    cmp r0, #65  @ ASCII code of 'A'.
    blt OUTPUT  @ if the character's "less than 'A'", just output.
    cmp r0, #90  @ ASCII code of 'Z'.
    bgt OUTPUT  @ if the character's "greater than 'Z'", "ADD #32" to change it into lower case.
    add r0, r0, #32
OUTPUT:
    bl putchar
    sub r4, r4, #1  @ counter--
    cmp r4, #0  @ if counter(r4) = 0, means no characters, END.
    bne LASTtoFIRST
    b END

    @epilogue
END:
    ldmfd sp!, {r0, r1, r2, r3, r4, fp, lr}
    bx lr
