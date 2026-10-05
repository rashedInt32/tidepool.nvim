/* Tidepool demo: C */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STATIONS 8
#define CLAMP(x, lo, hi) ((x) < (lo) ? (lo) : (x) > (hi) ? (hi) : (x))

typedef enum { PHASE_RISING, PHASE_FALLING } phase_t;

typedef struct {
    char name[32];
    double height;
    phase_t phase;
} reading_t;

static const double max_height = 4.2;

static phase_t classify(double height) {
    return height >= 0.0 ? PHASE_RISING : PHASE_FALLING;
}

static bool add_reading(reading_t *out, size_t *count, const char *name, double h) {
    if (*count >= MAX_STATIONS || name == NULL) {
        return false;
    }
    reading_t *r = &out[(*count)++];
    strncpy(r->name, name, sizeof r->name - 1);
    r->name[sizeof r->name - 1] = '\0';
    r->height = CLAMP(h, -max_height, max_height);
    r->phase = classify(r->height);
    return true;
}

int main(int argc, char **argv) {
    reading_t readings[MAX_STATIONS] = {0};
    size_t count = 0;

    add_reading(readings, &count, "north", 1.5);
    add_reading(readings, &count, "south", -9.0);

    for (size_t i = 0; i < count; i++) {
        const reading_t *r = &readings[i];
        printf("%-6s %+.2fm %s\n", r->name, r->height,
               r->phase == PHASE_RISING ? "rising" : "falling");
    }

    /* FIXME: argv parsing is a stub */
    if (argc > 1) {
        fprintf(stderr, "ignoring %s\n", argv[1]);
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}
