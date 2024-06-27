extends StaticBody2D

@export var end_door_tile : Vector2i
@export var start_door_tile : Vector2i

@export var end_door_rotation : String = "east"
@export var start_door_rotation : String = "west"

var room_completed = true

var start_door_triggered = false
var end_door_triggered = false

func  _ready():
	pass

func _on_door_collider_body_entered(body):
	if room_completed:
		get_parent()._generate_room()


func _process(delta):
	if room_completed and !end_door_triggered:
		_door_open(end_door_tile , "end")
	if !room_completed and !start_door_triggered:
		_door_open(start_door_tile , "start")

func _door_open(tile , string):

	if string == "start":
		start_door_triggered = true
	if string == "end":
		end_door_triggered = true
	
	for i in 4:
		var new
		
		if string == "end":
			new = i + 2
		if string == "start":
			new = 5 - i
		
		var rotation = _calc_rotation(string)
		$NavigationRegion2D/TileMap.set_cell(0 , tile, 1, Vector2(new,1) , rotation)
		
		await get_tree().create_timer(0.1).timeout

func _calc_rotation(string):
	if string == "start":
		if start_door_rotation == "north":
			return TileSetAtlasSource.TRANSFORM_TRANSPOSE - TileSetAtlasSource.TRANSFORM_TRANSPOSE
		if start_door_rotation == "east":
			return TileSetAtlasSource.TRANSFORM_TRANSPOSE + TileSetAtlasSource.TRANSFORM_FLIP_H
		if start_door_rotation == "south":
			return TileSetAtlasSource.TRANSFORM_FLIP_V
		if start_door_rotation == "west":
			return TileSetAtlasSource.TRANSFORM_TRANSPOSE
			
	if string == "end":
		if end_door_rotation == "north":
			return TileSetAtlasSource.TRANSFORM_TRANSPOSE - TileSetAtlasSource.TRANSFORM_TRANSPOSE
		if end_door_rotation == "east":
			return TileSetAtlasSource.TRANSFORM_TRANSPOSE + TileSetAtlasSource.TRANSFORM_FLIP_H
		if end_door_rotation == "south":
			return TileSetAtlasSource.TRANSFORM_FLIP_V
		if end_door_rotation == "west":
			return TileSetAtlasSource.TRANSFORM_TRANSPOSE
	
