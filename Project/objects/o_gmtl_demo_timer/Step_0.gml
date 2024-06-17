/// @description 
timer++;

if (keyboard_check_pressed(ord("A")) || keyboard_check(ord("A"))) {
	timer_key_hold += 1;
}

if (keyboard_check_released(ord("A"))) {
	timer_key_hold = 0;
}