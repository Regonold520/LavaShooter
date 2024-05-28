using Godot;
using System;

public partial class TwinsEnemy : EnemyAI
{
	protected override void OnDeath()
	{
		
		var DropScene = GD.Load<PackedScene>("res://drop_enemy.tscn");

		var c = new Color()
		{
			R8 = 0,
			G8 = 140,
			B8 = 255
		};

		var Drop1 = (Node2D) DropScene.Instantiate();
		var Drop2 = (Node2D) DropScene.Instantiate();
		
		GD.Print("Spawned Drops");

		GetTree().CurrentScene.AddChild(Drop1);
		GetTree().CurrentScene.AddChild(Drop2);
		
		Drop1.GlobalPosition = new Vector2(GlobalPosition.X + 100 , GlobalPosition.Y);
		Drop2.GlobalPosition = new Vector2(GlobalPosition.X + -100 , GlobalPosition.Y);

		var signal1 = (Node2D) Drop1.FindChild("Signal");
		var signal2 = (Node2D) Drop2.FindChild("Signal");

		signal1.Modulate = c;
		signal2.Modulate = c;
		
		base.OnDeath();
	}
}
