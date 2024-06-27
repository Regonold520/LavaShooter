extends Node2D

var room_scenes = ["res://Rooms/Room1.tscn"]
var room_ammount = 5

var rng = RandomNumberGenerator.new()

var last_start_pos
var last_end_pos
var last_room
var room
var room_node_new

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in room_ammount:
			
		var room_choice = rng.randi_range(0, room_scenes.size() - 1)
		var room_processing = load(room_scenes[room_choice])
		var room = room_processing.instantiate()
		var room_node_new = Node2D.new()
		var target = get_child(0)

		
		room.name = "Room" + str(i)
		
		get_tree().current_scene.call_deferred("add_child", room_node_new)
		if i == 0:	
			room_node_new.add_child(room)
			
		elif i != 0:
			if last_room.find_child(str(target)):
				room_node_new.global_position = last_room.find_child(str(target)).global_position
				room_node_new.add_child(room)
				room_node_new.global_position = last_room.find_child(str(target)).global_position
		last_room = room
