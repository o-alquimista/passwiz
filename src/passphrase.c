#include <stdio.h>
#include <string.h>
#include <sodium.h>

void roll_dice(char *combo) {
    uint32_t dice1, dice2, dice3, dice4, dice5;
    uint32_t upper = 6;

    dice1 = randombytes_uniform(upper) + 1;
    dice2 = randombytes_uniform(upper) + 1;
    dice3 = randombytes_uniform(upper) + 1;
    dice4 = randombytes_uniform(upper) + 1;
    dice5 = randombytes_uniform(upper) + 1;

    sprintf(combo, "%d%d%d%d%d", dice1, dice2, dice3, dice4, dice5);
}

int get_word(char *combo, char *word) {
    FILE *stream;
    char line[20];
    char *wordline;

    stream = fopen("/usr/local/etc/passwiz/eff_large_wordlist.txt", "r");

    if (NULL == stream) {
        printf("Failed to open wordlist\n");
        return -1;
    }

    while (fgets(line, sizeof(line), stream)) {
        wordline = strstr(line, combo);

        if (wordline > 0) {
            // Slice the string to get the word alone
            wordline = strtok(wordline, "\t"); // The first token is the numeric index
            wordline = strtok(NULL, "\t"); // The second token is the word
            // Passing NULL means it will continue from the last position

            strcpy(word, wordline);
        }
    }

    fclose(stream);
    return 0;
}

int main(void) {
    if (sodium_init() < 0) {
        return 1;
    }

    char combo[6];
    char word1[20], word2[20], word3[20], word4[20], word5[20], word6[20];
    char passphrase[120];

    roll_dice(combo);

    if (get_word(combo, word1) < 0) {
        return 1;
    }

    roll_dice(combo);

    if (get_word(combo, word2) < 0) {
        return 1;
    }

    roll_dice(combo);

    if (get_word(combo, word3) < 0) {
        return 1;
    }

    roll_dice(combo);

    if (get_word(combo, word4) < 0) {
        return 1;
    }

    roll_dice(combo);

    if (get_word(combo, word5) < 0) {
        return 1;
    }

    roll_dice(combo);

    if (get_word(combo, word6) < 0) {
        return 1;
    }

    strncpy(passphrase, word1, strlen(word1)-1);
    strcat(passphrase, " ");
    strncat(passphrase, word2, strlen(word2)-1);
    strcat(passphrase, " ");
    strncat(passphrase, word3, strlen(word3)-1);
    strcat(passphrase, " ");
    strncat(passphrase, word4, strlen(word4)-1);
    strcat(passphrase, " ");
    strncat(passphrase, word5, strlen(word5)-1);
    strcat(passphrase, " ");
    strncat(passphrase, word6, strlen(word6)-1);

    printf("%s\n", passphrase);
}
