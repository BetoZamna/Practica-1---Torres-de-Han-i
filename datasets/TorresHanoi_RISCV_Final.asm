
.data
A:  .space 12  # Espacio para la torre A (3 discos * 4 bytes cada uno)
B:  .space 12  # Espacio para la torre B
C:  .space 12  # Espacio para la torre C

.text
.globl main

main:
    
    # 1-Paulo Alberto Lopez Rios
    # 2- Carlos Calzada Diaz

    # Inicialización
    li s0, 3      # Establecer el número de discos en s0
    mv a0, s0     # Mover s0 a a0 para usarlo en la función
    la a1, A      # Dirección de la torre A
    la a2, B      # Dirección de la torre B
    la a3, C      # Dirección de la torre C

    # Inicializar la torre A con discos
    li t4, 1
    loop_init:
        beq t4, a0, start_hanoi
        sw t4, 0(a1)
        addi a1, a1, 4
        addi t4, t4, 1
        j loop_init

start_hanoi:
    # Llamada a la función recursiva
    call hanoi

    # Finalizar programa
    ecall

hanoi:
    # Base de la recursión: si n == 1, mover disco de origen a destino
    beqz a0, move_disk

    # Guardar registros en el stack
    addi sp, sp, -20
    sw ra, 16(sp)
    sw a0, 12(sp)
    sw a1, 8(sp)
    sw a2, 4(sp)
    sw a3, 0(sp)

    # Mover n-1 discos de origen a auxiliar usando destino como auxiliar
    addi a0, a0, -1
    mv t5, a3
    mv a3, a2
    mv a2, t5
    call hanoi

    # Restaurar registros del stack para siguiente llamado
    lw a0, 12(sp)
    lw a1, 8(sp)
    lw a2, 4(sp)
    lw a3, 0(sp)

    # Mover el disco restante de origen a destino
    addi a0, a0, 1
    call move_disk

    # Mover n-1 discos de auxiliar a destino usando origen como auxiliar
    addi a0, a0, -1
    mv t5, a1
    mv a1, a2
    mv a2, t5
    call hanoi

    # Restaurar registros y retornar
    lw ra, 16(sp)
    addi sp, sp, 20
    ret

move_disk:
    # Mover el disco de la torre origen a la torre destino
    lw t4, 0(a1)
    sw t4, 0(a3)
    sw zero, 0(a1)
    addi a1, a1, 4
    addi a3, a3, -4
    ret
