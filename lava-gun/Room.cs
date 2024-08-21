using System;
using System.Collections.Generic;
using System.Linq;
using Godot;
using Godot.NativeInterop;

public partial class Room : Area2D
{
	public int maxChain;
	public int currentChain;

	public Node2D lastExit;
	public Area2D lastRoom;
	private Node2D room;

	private RandomNumberGenerator rng;

	[Export] private string roomDir = "";

	public override void _Ready()
	{
		rng = new RandomNumberGenerator();
		
		if (lastRoom != null)
		{
			GD.Print(lastRoom.Name);
		}

		AreaEntered += RoomDetected;

		FindChild("ChainDisplay").Set("text", currentChain.ToString());

		if (currentChain != 0)
		{
			for (int i = 0; i < FindChild("Exits").GetChildCount(); i++)
			{
				var currentExit = (Node2D)FindChild("Exits").GetChild(i - 1);

				var exitDir = (string)currentExit.GetMeta("dir");

				CheckRoomDirs(exitDir, currentExit);
			}
		}
		else if (currentChain == 0)
		{
			Check0Chain();
		}
	}

	public override void _Process(double delta)
	{
		if (!IsInstanceValid(lastRoom) && currentChain != maxChain)
		{
			QueueFree();
		}
	}

	private void RoomDetected(Area2D area)
	{
		var areaChain = (int)area.Get("currentChain");

		if (areaChain > currentChain)
		{
			
			lastRoom.Call("CheckSpecificChain", lastExit);

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

				var roomScene = GD.Load<PackedScene>("res://Rooms/West/0_west_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}

			if (exitDir == "West")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/North/0_north_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}

			if (exitDir == "East")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/South/0_south_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}

			if (exitDir == "North")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/East/0_east_end.tscn");
				room = (Node2D)roomScene.Instantiate();

				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}
		}

	}

	private void CheckSpecificChain(Node2D currentExit)
	{

		var exitDir = (string)currentExit.GetMeta("dir");

		GetRoomFromPool(exitDir);

		if (exitDir == "South")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/West/0_west_end.tscn");
			room = (Node2D)roomScene.Instantiate();

			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}

		if (exitDir == "West")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/North/0_north_end.tscn");
			room = (Node2D)roomScene.Instantiate();

			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}

		if (exitDir == "East")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/South/0_south_end.tscn");
			room = (Node2D)roomScene.Instantiate();

			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}

		if (exitDir == "North")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/East/0_east_end.tscn");
			room = (Node2D)roomScene.Instantiate();

			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}


	}

	private void CheckRoomDirs(string exitDir, Node2D exit)
	{

		if (exitDir == "East")
		{
			if (currentChain != 0)
			{

				var roomScene = GD.Load<PackedScene>(GetRoomFromPool("south"));
				room = (Node2D)roomScene.Instantiate();

				room.Set("maxChain", maxChain);
				room.Set("currentChain", currentChain - 1);

				room.Set("lastExit", exit);
				room.Set("lastRoom", this);

				room.GlobalPosition = exit.GlobalPosition;

				GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
			}
		}
		else if (exitDir == "South")
		{

			var roomScene = GD.Load<PackedScene>(GetRoomFromPool("west"));
			room = (Node2D)roomScene.Instantiate();

			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);

			room.Set("lastExit", exit);
			room.Set("lastRoom", this);

			room.GlobalPosition = exit.GlobalPosition;

			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
		else if (exitDir == "West")
		{

			var roomScene = GD.Load<PackedScene>(GetRoomFromPool("north"));
			room = (Node2D)roomScene.Instantiate();

			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);

			room.Set("lastExit", exit);
			room.Set("lastRoom", this);

			room.GlobalPosition = exit.GlobalPosition;

			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
		else if (exitDir == "North")
		{

			var roomScene = GD.Load<PackedScene>(GetRoomFromPool("east"));
			room = (Node2D)roomScene.Instantiate();

			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);

			room.Set("lastExit", exit);
			room.Set("lastRoom", this);

			room.GlobalPosition = exit.GlobalPosition;

			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
	}

	private string GetRoomFromPool(string Pool)
	{
		var poolDir = "res://Rooms/" + Pool.ToPascalCase() + "/";
	
		var dir = DirAccess.Open(poolDir);

		List<string> paths = new List<string>();

		foreach (var file in dir.GetFiles())
		{
			string newPath = poolDir + file;
			paths.Add(newPath);
		}
		rng.Randomize();
		var endPath = paths[rng.RandiRange(1, paths.Count - 1)];
	
		GD.Print(endPath);

		return endPath;
	}

}
