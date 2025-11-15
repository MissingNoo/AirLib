//
__AirLibLoadTemplates();
md5_frame = 0;
last_md5 = "";
//
ui = new window(AirLib.templates.clear_template);

login = new button("Login");
login.set_function(function () {
	show_message("botão 1");
});
register = new button("Register");
register.set_function(function () {
	show_message("botão 2");
});

a = new textbox();

