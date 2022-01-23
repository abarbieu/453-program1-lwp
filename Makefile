liblwp: lwp.c lwp.h
	gcc -Wall -Werror -m32 -g -c -o $@.a $<

numbersmain: numbersmain.c lwp.h liblwp.a
	gcc -Wall -Werror -m32 -g -o $@.o $^

ex: liblwp numbersmain

clean :
	rm *.a *.o *.s