//feather ignore all
vis = true;
AirLib.ui_editor_order = [];
display_set_gui_size(1920, 1080);
global.filename = "/home/airgeadlamh/export.ui";
depth = -2000;
up = false;
down = false;
editing = noone;
last_edit = noone;
editingdepth = 999999;
saveui = undefined;


saveas = {
	"nodes": [
		{
			"nodes": [
				{
					"nodes": [
						{
							"flex": 1.0,
							"padding": 0.0,
							"data": {text: "Save as"},
							"name": "window_name_center",
						}
					],
					"flex": 1.0,
					"name": "panel_52056_trn_transparent",
					"padding": 2.0,
					"data": {},
					"height": 60.0,
				},
				{
					"nodes": [{"flex": 1.0, "data": {}, "name": "textbox_filename_char"}],
					"flex": 1.0,
					"name": "panel_transparent",
					"padding": 5.0,
					"data": {},
					"height": 60.0,
				},
				{
					"alignContent": "center",
					"nodes": [
						{
							"flex": 0.0,
							"name": "button_accept",
							"alignItems": "center",
							"width": 80.0,
							"data": {
								text: "Save",
								f: function() {
									oEditableUI.save(game_save_id + 
										oUI.saveasui.get_element_data(
											"textbox_filename_char",
											"text"
										) + ".ui"
									);
									oUI.saveasui.dispose();
								},
							},
							"height": 40.0,
							"alignSelf": "center",
						},
						{
							"flex": 1.0,
							"name": "panel_27108_transparent",
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"height": 60.0,
						},
						{
							"flex": 0.0,
							"name": "button_cancel",
							"width": 80.0,
							"data": {
								text: "Cancel",
								f: function() {
									oUI.saveasui.dispose();
								},
							},
							"height": 40.0,
							"alignSelf": "center",
						}
					],
					"flex": 1.0,
					"name": "bpanel_transparent",
					"alignItems": "center",
					"padding": 10.0,
					"data": {},
					"height": 60.0,
					"alignSelf": "center",
					"flexDirection": "row",
				}
			],
			"name": "panel_base2",
			"left": 760.0,
			"padding": 0.0,
			"top": 455.0,
			"width": 400.0,
			"data": {image: sButton},
			"height": 170.0,
		}
	],
	"width": 1920.0,
	"data": {},
	"height": 1080.0,
	"name": "base",
};

setspr = {
	"nodes": [
		{
			"nodes": [
				{
					"nodes": [
						{
							"flex": 1.0,
							"padding": 0.0,
							"data": {text: "Save as"},
							"name": "window_name_center",
						}
					],
					"flex": 1.0,
					"name": "panel_52056_trn_transparent",
					"padding": 2.0,
					"data": {},
					"height": 60.0,
				},
				{
					"nodes": [{"flex": 1.0, "data": {}, "name": "textbox_filename_char"}],
					"flex": 1.0,
					"name": "panel_transparent",
					"padding": 5.0,
					"data": {},
					"height": 60.0,
				},
				{
					"alignContent": "center",
					"nodes": [
						{
							"flex": 0.0,
							"name": "button_accept",
							"alignItems": "center",
							"width": 80.0,
							"data": {
								text: "Set",
								f: function() {
									oEditableUI
										.ui
										.set_data(
											oUI.last_edit,
											{
												image: oUI.setsprui.get_element_data(
													"textbox_filename_char",
													"text"
												),
											}
										);
									oUI.setsprui.dispose();
								},
							},
							"height": 40.0,
							"alignSelf": "center",
						},
						{
							"flex": 1.0,
							"name": "panel_27108_transparent",
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"height": 60.0,
						},
						{
							"flex": 0.0,
							"name": "button_cancel",
							"width": 80.0,
							"data": {
								text: "Cancel",
								f: function() {
									oUI.setsprui.dispose();
								},
							},
							"height": 40.0,
							"alignSelf": "center",
						}
					],
					"flex": 1.0,
					"name": "bpanel_transparent",
					"alignItems": "center",
					"padding": 10.0,
					"data": {},
					"height": 60.0,
					"alignSelf": "center",
					"flexDirection": "row",
				}
			],
			"name": "panel_base2",
			"left": 760.0,
			"padding": 0.0,
			"top": 455.0,
			"width": 400.0,
			"data": {image: sButton},
			"height": 170.0,
		}
	],
	"width": 1920.0,
	"data": {},
	"height": 1080.0,
	"name": "base",
};

top = {
	"width": 1920.0,
	"data": {
		image: sButton,
	},
	"height": 35.0,
	"name": "base",
	"nodes": [
		{
			"flexDirection": "row",
			"name": "panel_base",
			"left": 0.0,
			"nodes": [
				{
					"width": 60.0,
					"data": {
						text: "Save",
						f: function() {
                            //oEditableUI.ui.edit_mode(false);
                            if (!instance_exists(oSaveUI)) {
                            	instance_create_depth(0, 0, -3000, oSaveUI);
                            }
							//oUI.saveui = new window(oUI.save, true);
						},
					},
					"name": "button_save",
				},
				{
					"width": 60.0,
					"data": {
						text: "Save as",
						f: function() {
                            //oEditableUI.ui.edit_mode(false);
							oUI.saveasui = new window(oUI.saveas, true);
							oUI.saveasui.startingdepth = -1000;
							oUI.saveasui.dispose();
							oUI.saveasui.recalculate();
						},
					},
					"name": "button_save_as",
				},
				{
					"width": 60.0,
					"data": {
						text: "Load",
						f: function() {
							oEditableUI.load();
							oUI.add_to_list();
						},
					},
					"name": "button_load",
				},
				{
					"width": 60.0,
					"data": {
						text: "New",
						f: function() {
							instance_create_depth(0, 0, -5000, oNewUI);
							//oEditableUI.new_window();
						},
					},
					"name": "button_new",
				},
				{
					"width": 32.0,
					"data": {
						text: "",
						sprite: Icon_Bolt,
						f: function() {
							var node = oEditableUI.ui.get_child("base");
							if (node != undefined) {
								var str = {
									"name": $"panel_base_{irandom(99999)}",
									"left": 300,
									"top": 150,
									"padding": 0.0,
									"width": 400.0,
									"height": 300.0,
								};
								flexpanel_node_insert_child(
									node,
									flexpanel_create_node(str),
									0
								);
								oEditableUI.ui.recalculate();
							}
						},
					},
					"name": "button_add_panel",
				},
				{
					"width": 32.0,
					"data": {
						text: "",
						sprite: Icon_Cross,
						f: function() {
							var node = oEditableUI.ui.get_child(oUI.editing);
							if (node != undefined) {
								var parent = flexpanel_node_get_parent(node);
								if (parent != undefined) {
									flexpanel_node_remove_child(
										parent,
										oEditableUI.ui.get_child(oUI.editing)
									);
									oEditableUI.ui.recalculate();
								}
							}
						},
					},
					"name": "button_cross",
				},
				{
					"width": 32.0,
					"data": {
						text: "",
						sprite: Icon_Retry,
						f: function() {
							oUI.add_to_list();
						},
					},
					"name": "button_reload",
				},
				{
					"width": 60.0,
					"data": {
						text: "Sprite",
						f: function() {
							oUI.setsprui = new window(oUI.setspr, true);
							var _data = oUI.setsprui.get_child_data(
								"textbox_filename_char"
							);
							var spr = oEditableUI
								.ui
								.get_child_data(oUI.last_edit, "image");
							if (spr != undefined) {
								_data.text = spr;
							}
							oUI.setsprui.startingdepth = -1000;
							oUI.setsprui.dispose();
							oUI.setsprui.recalculate();
						},
					},
					"name": "button_save_as",
				},
				{
					"width": 60.0,
					"data": {
						text: "Tags",
						f: function() {
							var data = flexpanel_node_get_data(
								oEditableUI.ui.get_child(oUI.last_edit)
							);
							instance_create_depth(0, 0, 6000, oTagManager, {data});
						},
					},
					"name": "button_tag_editor",
				},
				{
					"width": 60.0,
					"data": {
						text: "Text",
						f: function() {
							var data = flexpanel_node_get_data(
								oEditableUI.ui.get_child(oUI.last_edit)
							);
							instance_create_depth(0, 0, 6000, oTextManager, {data});
						},
					},
					"name": "button_text_editor",
				},
				{
					"width": 60.0,
					"data": {
						text: "LoadUI",
						f: function() {
							instance_create_depth(0, 0, -6000, oLoadUI);
						},
					},
					"name": "button_load_ui",
				}
				//{
				//  "width":32.0,
				//  "data":{
				//	  text : "",
				//	  sprite : Icon_ArrowUp,
				//	  f : function() {
				//		oUI.up = true;
				//	}
				//  },
				//  "name":"button_up"
				//},
				//{
				//  "width":32.0,
				//  "data":{
				//	  text : "",
				//	  sprite : Icon_ArrowDown,
				//	  f : function() {
				//		oUI.down = true;
				//	}
				//  },
				//  "name":"button_down"
				//},
			],
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 35.0,
		}
	],
};
str = {
	"name": "editor",
	"flex": 1.0,
	"padding": 0.0,
	"width": 1920.0,
	"top": 35,
	"data": {
		//image : "wall4",
	},
	"height": 1080 - 35,
	flexDirection: "row",
	"nodes": [
		//{
		//  name : "panel_side_ignore",
		//  flex : 0.2,
		//  },
		{flex: 1, flexGrow: 1},
		{
			name: "panel_side",
			maxWidth: 30,
			flex: 0.15,
			data: {
				//image : wall4
			},
			nodes: [
				{
					"padding": 10.0,
					"data": {"inst": "@ref instance(100007)"},
					"height": 5.0,
					"name": "draggable_button",
					maxWidth: 30,
					maxHeight: 30,
					"flex": 1.0,
				},
				{
					"padding": 10.0,
					"data": {"inst": "@ref instance(100006)"},
					"height": 5.0,
					"name": "draggable_textbox",
					maxWidth: 30,
					maxHeight: 30,
					"flex": 1.0,
				},
				{
					"padding": 10.0,
					"data": {"inst": "@ref instance(100005)"},
					"height": 10.0,
					"name": "draggable_panel",
					maxWidth: 30,
					maxHeight: 30,
					"flex": 1.0,
				},
				{
					"padding": 10.0,
					"data": {"inst": "@ref instance(100004)"},
					"height": 10.0,
					"name": "draggable_label_7549",
					maxWidth: 30,
					"flex": 1.0,
				},
				{
					"padding": 10.0,
					"data": {"inst": "@ref instance(100003)"},
					"height": 10.0,
					"name": "draggable_label_61489",
					"flex": 1.0,
				}
			],
		}
	],
};
ui = new window(str, true);
top = new window(top, true);
//show_message(flexpanel_node_get_struct(global.inspector));
load_info = function(n) {
	//show_message(editing);
	var _node = flexpanel_node_get_child(oEditableUI.ui.root, editing); //node to edit
	if (_node == undefined) {
		exit;
	}
	last_edit = editing;
	flexpanel_node_set_data(
		flexpanel_node_get_child(ui.root, "inspector-label-center"),
		{text: $"Inspector - {editing}"}
	);
	with (oUIElement) {
		if (name == "inspector-label-center") {
			instance_destroy();
		}
	}
	//show_debug_message(flexpanel_node_get_data(flexpanel_node_get_child(ui.root, "inspector-label-center")));
	//show_message("");
	for (var i = 0; i < array_length(global.options); ++i) {
		o = global.options[i];
		var editnode = flexpanel_node_get_child(ui.root, o[0]);
		editnode = flexpanel_node_get_child(editnode, 1);
		var editnodestruct = flexpanel_node_get_struct(editnode);
		var onode = flexpanel_node_get_struct(_node);
		editnodestruct.data.selected = onode[$ o[0]];
        editnodestruct.margin = 1;
		var parent = flexpanel_node_get_parent(editnode);
		flexpanel_node_remove_child(parent, editnode);
		flexpanel_node_insert_child(parent, flexpanel_create_node(editnodestruct), 1);
	}
	ui.recalculate();
	//var _children_count = flexpanel_node_get_num_children(flexpanel_node_get_child(ui.root, ));
	//for (var i = 0; i < _children_count; i++)
	//{
	//	var _child = flexpanel_node_get_child(_node, i);

	//}
};
flexpanel_node_insert_child(
	flexpanel_node_get_child(ui.root, "editor"),
	global.inspector,
	0
);

list_base = {
	"flex": 1.0,
	"name": "panel_list_base",
	"padding": 0.0,
	"width": 200.0,
	minWidth: 200,
	maxWidth: 200,
	"nodes": [],
};
flexpanel_node_insert_child(
	flexpanel_node_get_child(ui.root, "editor"),
	flexpanel_create_node(list_base),
	2
);
ui.recalculate();

get_children = function(list, node) {
	//list[$ flexpanel_node_get_name(node)] = {};
	var childs = flexpanel_node_get_num_children(node);
    for (var i = 0; i < childs; i++) {
    	var n = flexpanel_node_get_child(node, i);
        var name = flexpanel_node_get_name(n)
        if (!array_contains(list, name)) {
        	array_push(list, name);
        } 
        get_children(list, n);
    }
	/*if (childs > 0) {
		var l = list[$ flexpanel_node_get_name(node)];
		if (string_contains(flexpanel_node_get_name(node), "panel")) {
			l[$ "childs"] = [];
		}
		for (var j = 0; j < childs; ++j) {
			var c = flexpanel_node_get_child(node, j);
			var n = flexpanel_node_get_name(c);
			if (string_contains(n, "panel")) {
				get_children(l, c);
			} else {
				if (is_array(l[$ "childs"])) {
					array_push(l[$ "childs"], n);
				}
			}
		}
	}*/
	//var _add = {
	//    "margin":5.0,
	//    "name":$"panel_parent_{flexpanel_node_get_name(node)}",
	//    "padding":0.0,
	//    "height":60.0,
	//    "nodes":[
	//    {
	//        "name":"label_center_parent_name",
	//        "padding":0.0,
	//        "height":60.0,
	//        "flex":0.20000000298023224,
	//		data : {text : flexpanel_node_get_name(node)}
	//    }
	//    ],
	//    "flex":1.0
	//}
	//var to_add = flexpanel_create_node(_add);
	//for (var i = 0; i < flexpanel_node_get_num_children(node); ++i) {
	//		var child_name = flexpanel_node_get_name(flexpanel_node_get_child(node, i));
	//	    var child = {
	//          "margin":10.0,
	//          "name":"panel_child_list",
	//          "flexDirection":"row",
	//          "padding":2.0,
	//          "height":60.0,
	//          "nodes":[
	//            {
	//              "name":"spacer",
	//              "padding":0.0,
	//              "maxWidth":20.0,
	//              "width":60.0,
	//              "height":60.0
	//            },
	//            {
	//              "name":"panel_29296_transparent",
	//              "padding":0.0,
	//              "width":60.0,
	//              "height":30.0,
	//              "nodes":[
	//                {
	//                  "name":"label_center_child_name",
	//                  "flex":1.0,
	//				  maxHeight : 20,
	//				  data : {text : child_name}
	//                }
	//              ],
	//              "flex":1.0
	//            }
	//          ],
	//          "flex":1.0
	//        }
	//		var childs = flexpanel_node_get_num_children(node);
	//		try {
	//			flexpanel_node_insert_child(to_add, childs, 0);
	//		}
	//		catch (err) {}
	//		if (childs > 0) {
	//		    for (var j = 0; j < flexpanel_node_get_num_children(node); ++j) {
	//				if (flexpanel_node_get_child(oUI.ui.root, $"panel_parent_{flexpanel_node_get_name(node)}") == undefined) {
	//				    flexpanel_node_insert_child(flexpanel_node_get_child(oUI.ui.root, "panel_list_base"), get_children(flexpanel_node_get_child(node, j)), 0);
	//				}
	//			}
	//		}
	//}
	//return to_add;
};

add_to_list = function() {
	flexpanel_node_remove_all_children(ui.get_child("panel_list_base"));
	with (oUIElement) {
		if (string_contains(name, "elnam")) {
			instance_destroy();
		}
	}
	var node = oEditableUI.ui.root;
	//var _name = flexpanel_node_get_name(node);
	//for (var i = 0; i < flexpanel_node_get_num_children(node); ++i) {
	//    flexpanel_node_insert_child(flexpanel_node_get_child(ui.root, "panel_list_base"), get_children(flexpanel_node_get_child(node, i)), 0);
	//}
	//var list = {};
	var list = [];
	for (var i = 0; i < flexpanel_node_get_num_children(node); ++i) {
		get_children(list, node);
		//flexpanel_node_insert_child(flexpanel_node_get_child(ui.root, "panel_list_base"), get_children(flexpanel_node_get_child(node, i)), 0);
	}
	var s = json_stringify(list);
	//s = string_replace_all(s, "{", "");
	//s = string_replace_all(s, "}", "");
	//s = string_replace_all(s, "[", "");
	//s = string_replace_all(s, "]", ":");
	s = string_replace_all(s, "\"", "");
	//s = string_replace_all(s, ",", ":");
	//s = string_replace_all(s, "childs", "");
	//s = string_replace_all(s, " ", "");
	var a = string_split(s, ",", true);
	var _add = function(e, i) {
        if ((string_contains(e, "grid") or string_contains(e, "spacer") or string_contains(e, "top_panel") or string_contains(e, "middle_panel") or string_contains(e, "bottom_panel")) and !keyboard_check(ord("Z"))) {
        	return;
        }
		flexpanel_node_insert_child(
			oUI.ui.get_child("panel_list_base"),
			flexpanel_create_node({
				flex: 1,
				maxHeight: 30,
				margin: 2,
				name: "button_center_elnam",
				data: {
					text: e,
					f: function(a) {
						oUI.editing = a.text;
						oUI.load_info();
					},
				},
			}),
			0
		);
	};
	array_foreach(a, _add);

	// Call for children (recursive)
	//var _children_count = flexpanel_node_get_num_children(_node);
	//for (var i = 0; i < _children_count; i++)
	//{
	//	var _child = flexpanel_node_get_child(_node, i);
	//	generate_instance(_child, _depth - 1);
	//}
	ui.recalculate();
};

//add_to_list();

depth = -2001;
