runningSum:
        addi    sp, sp, -32    # initialize
        sw      ra, 28(sp)                     
        sw      s0, 24(sp)                      
        addi    s0, sp, 32
        sw      a0, -12(s0)
        sw      a1, -16(s0)
        sw      a2, -20(s0)
        lw      a0, -16(s0)    # load the numsize to a0
        slli    a0, a0, 2      # a0 * 4 (int size)
        call    malloc         # call malloc to distribute memory
        sw      a0, -24(s0)    # save the array to result
        li      a0, 0          # turn a0 to 0
        sw      a0, -28(s0)    # give int "i" value 0
        j       .L1            # jump to L1
.L1:
        lw      a0, -28(s0)    # load i's value to a0
        lw      a1, -16(s0)    # load numsSize to a1
        bge     a0, a1, .L6    # if i >= numsSize then branch to L6
        j       .L2            # jump to L2
.L2:
        lw      a0, -28(s0)    # load i's value to a0
        bnez    a0, .L4    # if a0 != 0 then branch to L4
        j       .L3            # jump to L3
.L3:
        lw      a0, -12(s0)    # load nums's address to a0
        lw      a0, 0(a0)      # load (a0 + 0)'s value to a0
        lw      a1, -24(s0)    # load result's address to a0
        sw      a0, 0(a1)      # save num[0] to result[0]
        j       .L5            # jump to L5
.L4:
        lw      a0, -24(s0)    # load result's address to a0
        lw      a1, -28(s0)    # load i to a1
        slli    a3, a1, 2      # i*4 (cause of byte size)
        add     a1, a0, a3     # add result's address with i*4 
                               # to get result[i]'s address
        lw      a0, -4(a1)     # load result[i-1] to a0
        lw      a2, -12(s0)    # load nums's address
        add     a2, a2, a3     # add nums's address with i*4 
                               # to get nums[i]'s address
        lw      a2, 0(a2)      # load nums[i] to a2
        add     a0, a0, a2     # add result[i-1] + nums[i]
        sw      a0, 0(a1)      # save to result[i]
        j       .L5            # jump to L5
.L5:
        lw      a0, -28(s0)    # load i to a0
        addi    a0, a0, 1      # i = i + 1 
        sw      a0, -28(s0)    # save i back
        j       .L1            # jump to L1
.L6:
        lw      a0, -16(s0)    # load numsSize to a0
        lw      a1, -20(s0)    # load *returnSize to a1
        sw      a0, 0(a1)      # store numsize to *returnSize
        lw      a0, -24(s0)    # load result
        lw      ra, 28(sp)     # return
        lw      s0, 24(sp)
        addi    sp, sp, 32
        ret    
