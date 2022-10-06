#include <stdlib.h>
#include <stdio.h>

int* runningSum(int* nums, int numsSize){
    int* result = (int*)malloc(sizeof(int)*numsSize);
    
    
    for(int i=0; i<numsSize; i++){
        if(i==0) result[0] = nums[0];
        else result[i] = result[i-1] + nums[i];
    }
    
    return result;
}

int main(int argc, char *argv[]){
    int nums1[5] = {1,2,3,4,5};
    int nums2[6] = {1,3,5,7,9,11};
    int nums3[7] = {0,2,4,6,8,10,12};

    int* result1 = runningSum(nums1, 5);
    int* result2 = runningSum(nums2, 6);
    int* result3 = runningSum(nums3, 7);
    
    for(int j=0; j<5; j++){
        printf("%d ", result1[j]);
    }
    printf("\n");
    for(int j=0; j<6; j++){
        printf("%d ", result2[j]);
    }
    printf("\n");
    for(int j=0; j<7; j++){
        printf("%d ", result3[j]);
    }
    printf("\n");
}
