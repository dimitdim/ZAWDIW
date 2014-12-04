#initialize the stack pointer
li $sp 0x3ffc

#fib(4)
li $a0, 4
jal fib
move $s0, $v0

#fib(10)
li $a0, 10
jal fib
add $v1, $s0, $v0

#done!
j end

fib:

#if x==0 or x==1 go to appropriate end
beq $a0, 1, end0

#add to stack pointer
add $sp, $sp, -4
sw $ra, 0($sp)

#subtract one from the argument value
add $a0, $a0, -1

#recurse!
jal fib

#start going back through stack
lw $ra, 0($sp)
add $sp, $sp, 4

#actual magic
add $v0, $t1, $t0 # v0 = 2 t1=t0=1
move $t0, $t1
move $t1, $v0
jr $ra

#if x == 0 return 0
end0:
li $t0, 0
li $t1, 1
jr $ra

#jump trap :( so sad
end:
jal end