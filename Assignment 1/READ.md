# Lab1: RV32I Simulator
###### tags: `Course` `RISC-V` `Computer Architecture 2022`

## Problem
* Given an array nums. We define a running sum of an array as runningSum[i] = sum(nums[0]…nums[i]).
  Return the running sum of nums
  
  More detail description can be founded at [$here$](https://leetcode.com/problems/running-sum-of-1d-array/)
## Solution
* Pass the first element to result 0 as initial. Then add the A[i-1] element with num[i], then pass the value to the result. Finally return the result arr

## Pipeline stage explain
* **IF : Instruction Fetch**
  * The instructioins is fetched at this stage from $Instr. Memory$, and the pointer counter's value is also given at this stage.
    ![](https://i.imgur.com/GEcUYjp.png)
* **ID : Instruction Decode**
  * The instruction is decoded into OPcode and get the value from registers.
    ![](https://i.imgur.com/TyPdMFL.png)
* **EXE : Execute**
  * Use the OPcode at previous stage to determine which arithmetic operator should be used to the value which is also passed by the previous stage.
    ![](https://i.imgur.com/Z6g5Xbg.png)
* **MEM : Memory access**
  * The result of the calculation will be buffered to the Data Memory.
* **WB : Write Back**
  * The data and the register address will be write back to Register File
    ![](https://i.imgur.com/B3s5hJz.png)

## Result & Memory & Register
### Result
* **The result array should be**
  1
  1 + 2 = 3 
  1 + 2 + 3 = 6 
  1 + 2 + 3 + 4 = 10 
  1 + 2 + 3 + 4 + 5 = 15 
  | 0 | 1 | 2 | 3 | 4 |
  | - | - | - | - | - |
  | 1 | 3 | 6 | 10 | 15 |
  
* **Result $Ripes$ print**
  ![](https://i.imgur.com/s7pmZwD.png)

### Memory & Register
* The $nums$ is store at $0x1000\_0000$; $res$ is store at $0x1000\_0018$; $numsize$ is store at $0x1000\_0014$ with size $5$; 
  ![](https://i.imgur.com/SYchBpM.png)![](https://i.imgur.com/1A9Ue90.png)
* The step that pass nums[0] to res[0]
  ![](https://i.imgur.com/lM1pUx9.png)![](https://i.imgur.com/b0ipqF0.png)
* The reg when load res's address & i's value
  ![](https://i.imgur.com/ukTlnO4.png)![](https://i.imgur.com/HKDCLtg.png)
* The reg when adding result
  ![](https://i.imgur.com/vaBtzKA.png)![](https://i.imgur.com/7W4pbyK.png)
* The reg when print the result out
  ![](https://i.imgur.com/dGlbNqY.png)![](https://i.imgur.com/273eHSM.png)


## Pipeline Feature
### Data Hazard
* **The reasin why it occur：**
  Because we only have 5 stage pipeline. When the current instruction need the result of previous instruction, the CPU need to stall until the result WriteBack. Then CPU will waste lots of time to waiting for the result. Thus, there are two ways to solve this kind of data hazard.
* **solution**
  * Forwarding
    By forwarding, we can take the result from the previous instruction immediately. As the picture below, the next instruction is $add\;x12\;x12\;x13$ while the previous one is $addi\;x12\;x7\;0$. Thus we pass the value from EX/MEM Reg to EXE stage as the yellow line shows. So we can run the pipeline continuosly.
    ![](https://i.imgur.com/XqbiFow.png)
  * Stall (load use)
    However, there are still some cases that we need to stall. Just like the below case, we need to $lw\;x10\;0(x7)$. Immediately, the next one need $sw\;x10\;0(x28)$ to save word, while the data hasn't be readed from the Memory. Therefore, we stall the CPU for one cycle, waiting for the data be prepared.
    ![](https://i.imgur.com/cnXQAet.png)

### Control Hazard
* **The reasin why it occur：**
  Control hazard occur when the branch is taken. Hence, we need to Flush the instructions that we don't want them to be execute. As the result, we will waste 2 cycle because branch is calculated at EXE stage. Like the picture below, $bne\;x30\;x0\;L4$ is taken. Then, the two of the instructions after branch is Flushed.
  ![](https://i.imgur.com/FuTz3bo.png)


* **solution**
  * Put branch unit at ID stage 
    Move the place where branch is judged forward one. That is, Branch decide at ID stage, not at EXE stage. Finally, it will only cost 1 cycle for branch taken.
    ![](https://i.imgur.com/6xmxqSp.png)
  * Use predict scheme
    Usually, we will use branch when we are dealing with loop. Consequently, what we can do is to "guess" the next branch is taken or not taken. We can use "static" or "dynamic" prediction to solve the Control Hazard.
    ![](https://i.imgur.com/7gOrz6W.png)
    ![](https://i.imgur.com/Ysp4KRZ.png)


## Reference
* [Stall and Flush](https://courses.cs.washington.edu/courses/cse378/09wi/lectures/lec13.pdf)
* [What's the role of EX stage for branching in Pipelined MIPS w Forwarding?](https://stackoverflow.com/questions/44866407/whats-the-role-of-ex-stage-for-branching-in-pipelined-mips-w-forwarding)
* [淺談分支預測與 Hazards 議題](https://ithelp.ithome.com.tw/m/articles/10265705)
* [在Hazard尋求解法是否搞錯了什麼](https://ithelp.ithome.com.tw/articles/10268810)
