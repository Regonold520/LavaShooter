using Godot;
using System;

public partial class Room : Area2D
{
	public int maxChain;
	public int currentChain;
	
	[Export]
	private string roomDir = "";

	private Node2D room;
	public override void _Ready()
	{
		AreaEntered += RoomDetected;
		
		FindChild("ChainDisplay").Set("text", currentChain.ToString());
		
		if (currentChain != 0)
		{
			for (int i = 0; i < FindChild("Exits").GetChildCount(); i++)
			{
				var currentExit = (Node2D)FindChild("Exits").GetChild(i - 1);

				var exitDir = (string) currentExit.GetMeta("dir");
				
				CheckRoomDirs(exitDir, currentExit);
			}
		}
		else if (currentChain == 0)
		{

			Check0Chain();
		}
	}

	private void RoomDetected(Area2D area)
	{
		var areaChain = (int) area.Get("currentChain");

		if (areaChain > currentChain)
		{
			QueueFree();
		}
	}

	private void Check0Chain()
	{
		for (int i = 0; i < FindChild("Exits").GetChildCount(); i++)
		{
			var currentExit = (Node2D)FindChild("Exits").GetChild(i - 1);
			var exitDir = (string)currentExit.GetMeta("dir");
			
			if (exitDir == "South")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/West/west_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				room.GlobalPosition = currentExit.GlobalPosition;

				GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
			}
			if (exitDir == "West")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/North/north_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				room.GlobalPosition = currentExit.GlobalPosition;

				GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
			}
			if (exitDir == "East")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/South/south_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				room.GlobalPosition = currentExit.GlobalPosition;

				GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
			}
			if (exitDir == "North")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/East/east_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				room.GlobalPosition = currentExit.GlobalPosition;

				GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
			}
		}
		
	}

	private void CheckRoomDirs(string exitDir, Node2D exit)
	{
		
		if (exitDir == "East")
		{
			if (currentChain != 0)
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/South/south_room.tscn");
				room = (Node2D)roomScene.Instantiate();

				room.Set("maxChain", maxChain);
				room.Set("currentChain", currentChain - 1);

				room.GlobalPosition = exit.GlobalPosition;

				GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
			}
		}
		else if (exitDir == "South")
		{
				
			var roomScene = GD.Load<PackedScene>("res://Rooms/West/west_room.tscn");
			room = (Node2D) roomScene.Instantiate();
			
			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);
			
			room.GlobalPosition = exit.GlobalPosition;
			
			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
		else if (exitDir == "West")
		{
				
			var roomScene = GD.Load<PackedScene>("res://Rooms/North/north_room.tscn");
			room = (Node2D) roomScene.Instantiate();
			
			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);
			
			room.GlobalPosition = exit.GlobalPosition;
			
			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
		else if (exitDir == "North")
		{
				
			var roomScene = GD.Load<PackedScene>("res://Rooms/East/east_room.tscn");
			room = (Node2D) roomScene.Instantiate();
			
			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);
			
			room.GlobalPosition = exit.GlobalPosition;
			
			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
	}
}
