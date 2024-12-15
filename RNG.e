//random number generator based on clock time

//0x80000005 - clock time 32 bit

// cpdata	rng_mod		(num > 2)
// result is between 0, num-1 inclusive

//returns to random_num



rng		cp	d_divisor	rng_mod
		cp	d_dividend	0x80000005
		add	d_dividend	d_dividend		old_div
		
		call	div_rem	div_rem_ret
		cp	rng_temp	d_remainder
		cp	old_div	d_res
		add	rng_temp	rng_temp		rng_one
		
		cp	d_dividend	0x80000005
		cp	d_divisor	rng_temp
		call	div_rem	div_rem_ret
		cp	random_num	d_remainder

		//we only want numbers from 0-5 inclusive, but it is possible to get 6 from mod 7.
		//however using mod6 makes the result less random, so just change to a different
		//number if result is 6.
		bne	rng_end		random_num		rng_six
		cp	random_num	rng_four

rng_end		ret	rng_ret

random_num	0
rng_one		1
rng_two		2
rng_four	4
old_div		0
rng_temp	0
rng_mod		7
rng_six		6


rng_ret	0

#include div_rem.e

