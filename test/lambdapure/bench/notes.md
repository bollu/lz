#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>





srand(time(NULL));   // Initialization, should only be called once.
int r = rand();      // Returns a pseudo-random integer between 0 and RAND_MAX.


lean_object * og_list = l_make(lean_box(10));
lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);


struct timeval begin, end;
gettimeofday(&begin, 0);


lean_object* new_list;
lean_object* sum;
// for(int i = 0; i < 10; i++){
  new_list = map_dot__main(closure,og_list);
  sum = l_sum(new_list);
// }
int n = lean_unbox(sum);
gettimeofday(&end, 0);

long microseconds = end.tv_usec - begin.tv_usec;
// printf("%d\n",microseconds);
printf("%d\n",n );
