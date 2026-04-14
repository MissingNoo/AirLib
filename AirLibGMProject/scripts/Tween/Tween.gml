///Based on @Dininho tween system
enum tween_animation {
	back,
	normal,
	elastic,
	bounce,
	ease
}
/// Feather disable once GM1024
function tween(_object, _variable_name, _value, _time = game_get_speed(gamespeed_fps)) constructor {
	object = _object;
	variable_name = _variable_name;
	value = _value;
	animation = "back";
	time = _time;
	callback = -1;
	
	static set_animation = function (_animation) {
		var r = ["back", "default", "elastic", "bounce", "ease"];
		animation = r[_animation];
		return self;
	}
	
	static set_callback = function (c) {
		callback = c;
		return self;
	}
	
	static run = function () { 
		instance_create_depth(0, 0, 0, oTween, {
			object,
			variable_name,
			value,
			animation,
			time,
			anim_curve: animcurve_get_channel(tween_curves, animation),
			callback
		});
	}
}