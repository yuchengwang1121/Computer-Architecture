#include <stdlib.h>
#include <stdio.h>
int* decode(int* encoded, int encodedSize, int first){
    int* result = (int*)malloc(sizeof(int)*(encodedSize+1));
    result[0]=first;
    for(int i=0;i<encodedSize;i++){
        result[i+1]=result[i] ^ encoded[i];
    }
    return result;
}
int main(){
    int nums1[4] = {6,2,7,3};
    int* result1 = decode(nums1, 4, 4);
    printf("THe result is : ");
    for(int j=0; j<5; j++){
        printf("%d ", result1[j]);
    }
}
