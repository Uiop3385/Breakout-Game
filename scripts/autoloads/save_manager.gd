extends Node

var data_category = "GameData"

func save_game(save_name):
	var save = ConfigFile.new()
	var data = {
		"control_scheme": Globals.control_scheme,
		"click_to_move": Globals.click_to_move,
		"ball_speed": Globals.ball_speed,
	}
	for item in data:
		save.set_value(data_category, item, data[item])
		print("saved ", item, " with value ", data[item], " to disk.")
	save.save("user://" + save_name)

func load_game(save_name):
	var save = ConfigFile.new()
	if save.load("user://" + save_name) == OK:
		for item in save.get_section_keys(data_category):
			set("Globals." + item, save.get_value(data_category, item))
	else:
		print("something went wrong while loading data!")

func load_item(save_name, item):
	var save = ConfigFile.new()
	if save.load("user://" + save_name) == OK:
		return save.get_value(data_category, item)
	else:
		print("something went wrong while loading data!")
		return get("Globals." + item)
