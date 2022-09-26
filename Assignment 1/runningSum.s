.data
nums: .word 1,2,3,4,5
numsize: .word 5
res: .word 0,0,0,0,0

.text
main:
    jal ra, runningSum
    j print
	
runningSum:
    # t2: nums head, t3: result head, t4: numsSize, t5: i, t6: j
    # initialize
    la      t2, nums       # load arr base to t2
    la      t3, res        # load arr base to t2
    la 	    t4, numsize
    lw      t4, 0(t4)      # load the numsize to t3
    li	    t5, 0          # load i with 0
    li	    t6, 0          # load j with 0
    j       end.L1         # jump to L1
end.L1:
    bge     t5, t4, end.L6 # if i >= numsSize then branch to L6
    j       end.L2         # jump to L2
end.L2:
    bnez    t5, end.L4     # if i != 0 then branch to L4
    j       end.L3         # jump to L3
end.L3:
    lw      a0, 0(t2)      # load nums[0] to a0
    sw      a0, 0(t3)      # save num[0] to result[0]
    j       end.L5         # jump to L5
end.L4:
    addi    a0, t3, 0      # load result's address to a0
    addi    a1, t5, 0      # load i to a1
    slli    a3, a1, 2      # i*4 (cause of byte size)
    add     a1, a0, a3     # add result's address with i*4 
                           # to get result[i]'s address
    lw      a0, -4(a1)     # load result[i-1] to a0
    addi    a2, t2, 0      # load nums's address
    add     a2, a2, a3     # add nums's address with i*4 
                           # to get nums[i]'s address
    lw      a2, 0(a2)      # load nums[i] to a2
    add     a0, a0, a2     # add result[i-1] + nums[i]
    sw      a0, 0(a1)      # save to result[i]
    j       end.L5         # jump to L5
end.L5:
    addi    t5, t5, 1      # i = i + 1 
    j       end.L1         # jump to L1
end.L6:
    jr      ra             # retuen to main
        
print:
    slli    a1, t6, 2
    add	    a2, t3, a1
    lw 	    a0, 0(a2)      # load result out
    li      a7, 1          # pint a0
    ecall
    addi    t6, t6, 1      # j++
    blt     t6, t5, print  # loop
    j	    exit
    
exit:
    li a7, 10		    # exit
    ecall
