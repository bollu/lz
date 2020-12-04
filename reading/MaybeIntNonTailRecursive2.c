// this gets optimized to a program that directly returns the nothing.
#include <stdio.h>
typedef struct { enum {Just, Nothing } tag; int val; } MaybeHash;
MaybeHash nothing() { MaybeHash m; m.tag = Nothing; m.val = 42; return m; }
MaybeHash just(int i) { MaybeHash m; m.tag = Just; m.val = i; return m; }

MaybeHash f(MaybeHash mi) {
    if (mi.tag == Just) {
        if (mi.val == 0) { return nothing();  }
        else {
            MaybeHash rec = f(just(mi.val - 1));;
            if (rec.tag == Nothing) { return nothing(); }
            else { return just(rec.val + 7); }
        }
    } else { return nothing(); }
}

// 7 * 5 = 5
int main() {
    MaybeHash mi = f(just(5));
    printf("tag: %d | value: %d\n", mi.tag, mi.val);
    return 0;
}


