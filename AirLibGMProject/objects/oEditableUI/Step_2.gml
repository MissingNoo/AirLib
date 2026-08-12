if (keyboard_check(vk_shift) && keyboard_check_pressed(vk_enter)) {
	file_copy(AirUISavePath, $"{AirUISavePath}.bkp");
	oEditableUI.save(AirUISavePath);
}