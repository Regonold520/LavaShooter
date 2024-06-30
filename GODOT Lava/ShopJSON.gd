extends Node

var pool = {}

func _ready():
	pool = _parse_json("res://Pools/JSON/ShopPool.json")

func _parse_json(path):
	var file_path : String = path
	
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(data_file.get_as_text())
		
		if parsed_result is Dictionary:
			return parsed_result
