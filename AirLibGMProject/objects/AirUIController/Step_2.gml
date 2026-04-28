AirLib.frame++;
array_foreach(AirLib.lerpers, function(e, i) {
	e.tick();
});
array_foreach(AirLib.tweens, function(e, i) {
	//e.tick();
	with (e.object) {
		e.percent += 1 / e.time;
		e.percent = clamp(e.percent, 0, 1);
		e.position = animcurve_channel_evaluate(e.anim_curve, e.percent);
		if (e.percent < 1) {
			self[$ e.variable_name] =
				e.base_value
				+ (e.value - e.base_value) * e.position;
		} else {
			self[$ e.variable_name] =
				e.base_value
				+ (e.value - e.base_value) * e.position;
			if (e.callback != -1) {
				e.callback();
			}
			
			//instance_destroy(other);
		}
	}

});
for (var i = array_length(AirLib.tweens) - 1; i >= 0; i--) {
	var e = AirLib.tweens[i];
	if (e.percent == 1) {
		array_delete(AirLib.tweens, i, 1);
	}
}