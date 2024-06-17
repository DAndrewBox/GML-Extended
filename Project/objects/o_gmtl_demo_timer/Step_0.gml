/// @description 
timer++;

if (keyboard_check_pressed(vk_space) || keyboard_check(vk_space)) {
	timer_key_hold += 1;
} else if (keyboard_check_released(vk_space)) {
	time_key_hold = 0;
}