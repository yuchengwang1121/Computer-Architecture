#include<stdio.h>
int* decode(int* encoded, int encodedSize, int first, int* returnSize){
    int* result = (int*)malloc(sizeof(int)*(encodedSize+1));
    result[0]=first;
    for(int i=0;i<encodedSize;i++){
        result[i+1]=result[i] ^ encoded[i];
    }
    *returnSize = encodedSize+1;
    return result;
}
