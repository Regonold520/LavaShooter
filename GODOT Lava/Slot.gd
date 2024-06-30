extends Area2D

var item_name : String
var decription : String
var price : int
var type
var scene : PackedScene

@onready var info = $"../DescriptionBox"

var mouse_hovering = false

func _process(delta):
	if mouse_hovering:
		info.get_child(1).text = "Name: " + item_name
		info.get_child(2).text = "Description: " + decription
		info.get_child(3).text = "Price: " + str(price) + " Essence"
		
		if Input.is_action_just_pressed("Input"):
			if type == "Weapon":
				var weapon = scene.instantiate()
				get_tree().current_scene.find_child("Player").find_child("GunPoint").get_child(0).queue_free()
				get_tree().current_scene.find_child("Player").find_child("GunPoint").add_child(weapon)
				

func _on_mouse_entered():
	mouse_hovering = true

func _on_mouse_exited():
	mouse_hovering = false
