esse = ++global.id_atual;
if (!is_undefined(global.dead_enemies[$ room_get_name(room)])) {
	if (array_contains(global.dead_enemies[$ room_get_name(room)], esse)) {
		instance_destroy();
	}
}