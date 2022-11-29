#include <stdio.h>
int max(int a, int b) {
  return a > b ? a : b;
}

int lengthOfLongestSubstring(char * s){
    int last_use[128] = {0};
    int ret = 0;
    int last_rep = 0;
    char ch;
    for(int i = 0; (ch = s[i]) != 0; ++i) {
        last_rep = max(last_use[ch], last_rep);
        ret = max(ret, i - last_rep + 1);
        last_use[ch] = i + 1;
    }
    return ret;
}

int main()
{
    char str[8] = "abcabcbb";
    int result;
    result = lengthOfLongestSubstring(str);
    printf("The result is : %d", result);
}
