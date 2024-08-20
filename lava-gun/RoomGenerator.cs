using Godot;
using System;

public partial class RoomGenerator : Node2D
{

	private int maxChain = 20;
	
	private PackedScene testRoom = GD.Load<PackedScene>("res://Rooms/East/east_room.tscn");
	private Node2D room;

	public override void _Ready()
	{
		room = (Node2D) testRoom.Instantiate();
		
		room.Set("maxChain", maxChain);
		room.Set("currentChain", maxChain);
		
		GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);

	}
}
