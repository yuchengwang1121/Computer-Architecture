#include <stdlib.h>

int* runningSum(int* nums, int numsSize, int* returnSize){
    int* result = (int*)malloc(sizeof(int)*numsSize);
    
    
    for(int i=0; i<numsSize; i++){
        if(i==0) result[i] = nums[i];
        else result[i] = result[i-1] + nums[i];
    }
    
    *returnSize = numsSize;
    return result;
}
