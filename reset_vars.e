reset_vars	cp	start_idx	reset_zero
		cp	end_idx		reset_zero
		cp 	arr		reset_arr
		cp	0x80000004	reset_zero
		cp	0x80000003	reset_zero
		ret	reset_vars_ret







reset_zero	0
reset_one	1

reset_arr 	0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0

reset_vars_ret	0
