#include <string>
#include <cstring>

extern "C" int count_words(char *str) {
    bool isWord = false;
    int countWords = 0;
    for (unsigned int i = 0; i < strlen(str); i++){
        if (str[i] != ' ' && isWord == false) {
            isWord = true;
            countWords++;
        }
        if (str[i] == ' ') isWord = false;
    }
    return countWords;
}