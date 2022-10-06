.data
nums1:     .word 1,2,3,4,5
nums2:     .word 1,3,5,7,9,11
nums3:     .word 0,2,4,6,8,10,12
res1:      .word 0,0,0,0,0,
res2:      .word 0,0,0,0,0,0
res3:      .word 0,0,0,0,0,0,0
space:     .string " "
nl:        .string "\n"

.text
main:
    # t2: nums head, t3: result head, t4: numsSize
    la      t2, nums1      # load arr base to t2
    la      t3, res1       # load res base to t3
    li      t4, 5          # load the numsize to t4
    jal     ra, runningSum
    la      t2, nums2      # load arr base to t2
    la      t3, res2       # load res base to t3
    li 	    t4, 6          # load the numsize to t4
    jal     ra, runningSum
    la      t2, nums3      # load arr base to t2
    la      t3, res3       # load res base to t3
    li 	    t4, 7          # load the numsize to t4
    jal     ra, runningSum
    j       exit
	
runningSum:
    # t5: i, t6: j         # initialize
    li	    t5, 1          # load i with 1
    lw      a3, 0(t2)      # load nums[0] to a3
    sw      a3, 0(t3)      # save num[0] to result[0]
end.L1:
    slli    a0, t5, 2      # i*4 (cause of byte size)
    add     a1, t3, a0     # add result's address with i*4 to get result[i]'s address
    lw      a3, -4(a1)     # load result[i-1] to a3
    add     a2, t2, a0     # add nums's address with i*4 to get nums[i]'s address
    lw      a2, 0(a2)      # load nums[i] to a5
    add     a3, a3, a2     # add result[i-1] + nums[i]
    sw      a3, 0(a1)      # save to result[i]
    addi    t5, t5, 1      # i = i + 1 
    blt     t5, t4, end.L1 # if i >= numsSize then branch to L3
    li      t5, 0

print:
    slli    a1, t5, 2
    add	    a1, t3, a1
    lw 	    a0, 0(a1)      # load result out
    li      a7, 1          # pint a0
    ecall
    la      a0, space      #load space
    li      a7, 4          #print string
    ecall
    addi    t5, t5, 1      # j++
    blt     t5, t4, print  # loop
    la      a0, nl         #load next line
    li      a7, 4          #print string
    ecall
    jr    ra
exit:
    li a7, 10		    # exit
    ecall
