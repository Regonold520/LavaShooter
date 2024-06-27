extends Node2D

var room_pool = ["res://Rooms/Room1.tscn" , "res://Rooms/Room2.tscn" , "res://Rooms/Room3.tscn"]
var rooms = 20
var room
var last_room
var chain 
var is_colliding = false

var rng = RandomNumberGenerator.new()

func _ready():
	chain = rooms
	
	for i in rooms:
		
		if chain != 0:
			
			
			if last_room != null and last_room.is_colliding:
				return 
				
			chain -= 1
			await get_tree().create_timer(2).timeout
			
			if i == 0:
				last_room = self
		
			var room_scene = load(room_pool[rng.randi_range(0,1)])
			

			if last_room.find_child("Exit2") != null:
				room_scene = load(room_pool[rng.randi_range(0,0)])
			room = room_scene.instantiate()
		
			room.global_rotation_degrees += last_room.find_child("Exit").global_rotation_degrees
			
			room.global_position = last_room.find_child("Exit").global_position
			
			room.global_position -= room.find_child("Entrance").global_position - room.global_position
			
			add_child(room)
			
			last_room = room
			
			room._room_ready()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_area_entered(area):
	
	print(area.chain , "   " , chain)
	is_colliding = true

