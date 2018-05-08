#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void setup() {
    srand(time(NULL));
}

int containsAny(char *array, int length) {
    for (int i = 0; i < length; i++) {
        if (array[i]) return 1;
    }
    return 0;
}

int containsAll(char *array, int length) {
    for (int i = 0; i < length; i++) {
        if (!array[i]) return 0;
    }
    return 1;
}

void fillArray(char *array, int length) {
    for (int i = 0; i < length; i++) {
        array[i] = 1;
    }
}

int simulate(int initial, int divisor, int populationSize, double probability) {
    // true/false array whether each person has trait
    char *population = calloc(populationSize, sizeof(char));
    for (int i = 0; i < populationSize; i++) {
        population[i] = ((double)rand() / RAND_MAX) < probability;
    }
    // set each individual's index when they've been correctly ID'd
    char *checked = calloc(populationSize, sizeof(char));

    int tests = 0;

    for (int groupSize = initial; groupSize > 0 && !containsAll(checked, populationSize);
            groupSize = (groupSize / divisor) + (groupSize % divisor)) {

        for (int index = 0; index < populationSize; index += groupSize) {
            if (checked[index]) { // this group was checked before
                // could skip more than current block size but oh well
                continue;
            }
            tests += 1;
            if (containsAny(population + index, groupSize)) { // TODO: cleanup logic
                if (groupSize == 1) {
                    checked[index] = 1;
                }
            } else {
                fillArray(checked + index, groupSize);
            }
        }
    }

    return tests;
}
