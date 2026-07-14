if (is_undefined(global.dead_enemies[$ room_get_name(room)])) {
	global.dead_enemies[$ room_get_name(room)] = array_create(0);
}
array_push(global.dead_enemies[$ room_get_name(room)], esse);
instance_destroy();