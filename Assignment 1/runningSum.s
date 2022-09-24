runningSum(int*, int, int*):                    # @runningSum(int*, int, int*)
        addi    sp, sp, -32
        sw      ra, 28(sp)                      # 4-byte Folded Spill
        sw      s0, 24(sp)                      # 4-byte Folded Spill
        addi    s0, sp, 32
        sw      a0, -12(s0)
        sw      a1, -16(s0)
        sw      a2, -20(s0)
        lw      a0, -16(s0)
        slli    a0, a0, 2
        call    malloc
        sw      a0, -24(s0)
        li      a0, 0
        sw      a0, -28(s0)
        j       .LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
        lw      a0, -28(s0)
        lw      a1, -16(s0)
        bge     a0, a1, .LBB0_7
        j       .LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -28(s0)
        li      a1, 0
        bne     a0, a1, .LBB0_4
        j       .LBB0_3
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -12(s0)
        lw      a1, -28(s0)
        slli    a2, a1, 2
        add     a0, a0, a2
        lw      a0, 0(a0)
        lw      a1, -24(s0)
        add     a1, a1, a2
        sw      a0, 0(a1)
        j       .LBB0_5
.LBB0_4:                                #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -24(s0)
        lw      a1, -28(s0)
        slli    a3, a1, 2
        add     a1, a0, a3
        lw      a0, -4(a1)
        lw      a2, -12(s0)
        add     a2, a2, a3
        lw      a2, 0(a2)
        add     a0, a0, a2
        sw      a0, 0(a1)
        j       .LBB0_5
.LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
        j       .LBB0_6
.LBB0_6:                                #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -28(s0)
        addi    a0, a0, 1
        sw      a0, -28(s0)
        j       .LBB0_1
.LBB0_7:
        lw      a0, -16(s0)
        lw      a1, -20(s0)
        sw      a0, 0(a1)
        lw      a0, -24(s0)
        lw      ra, 28(sp)                      # 4-byte Folded Reload
        lw      s0, 24(sp)                      # 4-byte Folded Reload
        addi    sp, sp, 32
        ret
