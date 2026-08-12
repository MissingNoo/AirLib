if (keyboard_check_pressed(vk_f4)) {
	room_goto(room == rAirLibStart ? rUIEditor : rAirLibStart);
}