using Godot;
using System;

public partial class RoomGenerator : Node2D
{

	private int maxChain = 2;
	
	private PackedScene testRoom = GD.Load<PackedScene>("res://Rooms/Start/start_room_1.tscn");
	private Node2D room;

	public override void _Ready()
	{
		room = (Node2D) testRoom.Instantiate();
		
		room.Set("maxChain", maxChain);
		room.Set("currentChain", maxChain);
		
		GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);

	}
}
