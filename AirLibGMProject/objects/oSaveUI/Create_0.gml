save = {
	"name": "base",
	"nodes": [
		{
			"name": "panel_base",
			"left": 0.0,
			"nodes": [
				{
					"flex": 0.10000000149011612,
					"data": {
						text: "Save",
					},
					"name": "label_center_62297",
				},
				{
					"margin": 10.0,
					"border": 0.0,
					"name": "transparent_panel_55029",
					"nodes": [
						{
							"name": "panel_82435",
							"nodes": [
								{
									"flex": 1.0,
									"data": {
										text: "Are you sure?",
									},
									"name": "center_label_98113",
								}
							],
							"flex": 1.0,
							"padding": 10.0,
							"data": {
							},
							"height": 60.0,
						},
						{
							"alignSelf": "center",
							"flexDirection": "row",
							"name": "transparent_panel_28819",
							"nodes": [
								{
									"flex": 1.0,
									"width": 60.0,
									"data": {
										text: "Yes",
										f: function() {
											oEditableUI.save(global.filename);
                                            instance_destroy(oSaveUI);
										},
									},
									"height": 30.0,
									"name": "button_save_ok",
								},
								{
									"flex": 1.0,
									"width": 192.0,
									"data": {
										text: "Cancel",
										f: function() {
                                            instance_destroy(oSaveUI);
										},
									},
									"height": 30.0,
									"name": "button_save_cancel",
								}
							],
							"flex": 0.20000000298023224,
							"padding": 10.0,
							"width": 200.0,
							"data": {
							},
							"height": 60.0,
							"alignItems": "center",
						}
					],
					"flex": 1.0,
					"padding": 0.0,
					"data": {
					},
					"height": 304.0,
				}
			],
			"padding": 0.0,
			"top": 500.0,
			"width": 249.0,
			"data": {
                "image":"sAirBG",
			},
			"height": 127.0,
		}
	],
	"width": 1920.0,
	"data": {
	},
	"height": 1080.0,
	"alignItems": "center",
};
ui = new window(save, true);
//accept = new button("Accept");
//ui.add_draw("panel_base", AirUIDefaultDraw);
//ui.add_element("button_save_ok", accept);
//ui.fit_to_gui();
//ui.finish();