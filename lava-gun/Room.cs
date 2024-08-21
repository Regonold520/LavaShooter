using Godot;

public partial class Room : Area2D
{
	public int maxChain;
	public int currentChain;

	public Node2D lastExit;
	public Area2D lastRoom;
	private Node2D room;
	
	[Export]
	private string roomDir = "";
	
	public override void _Ready()
	{
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

				var roomScene = GD.Load<PackedScene>("res://Rooms/West/west_end.tscn");
				room = (Node2D)roomScene.Instantiate();
				
				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}
			if (exitDir == "West")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/North/north_end.tscn");
				room = (Node2D)roomScene.Instantiate();
				
				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}
			if (exitDir == "East")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/South/south_end.tscn");
				room = (Node2D)roomScene.Instantiate();
				
				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}
			if (exitDir == "North")
			{

				var roomScene = GD.Load<PackedScene>("res://Rooms/East/east_end.tscn");
				room = (Node2D)roomScene.Instantiate();
				
				currentExit.AddChild(room);

				room.GlobalPosition = currentExit.GlobalPosition;
			}
		}
		
	}
	
	private void CheckSpecificChain(Node2D currentExit)
	{

		var exitDir = (string)currentExit.GetMeta("dir");
		
		if (exitDir == "South")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/West/west_end.tscn");
			room = (Node2D)roomScene.Instantiate();
			
			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}
		if (exitDir == "West")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/North/north_end.tscn");
			room = (Node2D)roomScene.Instantiate();
			
			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}
		if (exitDir == "East")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/South/south_end.tscn");
			room = (Node2D)roomScene.Instantiate();
			
			currentExit.AddChild(room);

			room.GlobalPosition = currentExit.GlobalPosition;
		}
		if (exitDir == "North")
		{

			var roomScene = GD.Load<PackedScene>("res://Rooms/East/east_end.tscn");
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

				var roomScene = GD.Load<PackedScene>("res://Rooms/South/south_room.tscn");
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
				
			var roomScene = GD.Load<PackedScene>("res://Rooms/West/west_room.tscn");
			room = (Node2D) roomScene.Instantiate();
			
			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);
			
			room.Set("lastExit", exit);
			room.Set("lastRoom", this);
			
			room.GlobalPosition = exit.GlobalPosition;
			
			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
		else if (exitDir == "West")
		{
				
			var roomScene = GD.Load<PackedScene>("res://Rooms/North/north_room.tscn");
			room = (Node2D) roomScene.Instantiate();
			
			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);
			
			room.Set("lastExit", exit);
			room.Set("lastRoom", this);
			
			room.GlobalPosition = exit.GlobalPosition;
			
			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
		else if (exitDir == "North")
		{
				
			var roomScene = GD.Load<PackedScene>("res://Rooms/East/east_room.tscn");
			room = (Node2D) roomScene.Instantiate();
			
			room.Set("maxChain", maxChain);
			room.Set("currentChain", currentChain - 1);
			
			room.Set("lastExit", exit);
			room.Set("lastRoom", this);
			
			room.GlobalPosition = exit.GlobalPosition;
			
			GetTree().CurrentScene.FindChild("RoomGenerator").AddChild(room);
		}
	}
}
