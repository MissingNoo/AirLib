///UI
if (!file_exists(AirUISavePath)) {
	return;
}
ui = new window(json_parse(json_stringify(json_load(AirUISavePath))));
ui.fit_to_gui();
input = new textbox();
input.backtext = "tests";
ui.add_element("input", input);
check = new checkbox();
check.set_on_change(method(self, function(_bool) {

}));
ui.add_element("check", check);
button_8523 = new button("Load");
button_8523.set_function(method(self, function() {
	show_message("test");
}));
ui.add_element("button_8523", button_8523);
ui.finish();