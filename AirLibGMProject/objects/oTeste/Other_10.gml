ui.add_draw("title", 
	AirUIFunctionStart
		scribble("[fa_center][fa_middle][c_black]Login").draw(_x + _w / 2, _y + _h / 2);
	AirUIFunctionEnd
);
ui.add_element("login", login);
ui.add_element("register", register);
ui.add_element("text", a);
ui.finish();