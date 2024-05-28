using Godot;

namespace lavagun.C__Scripts;

public partial class TwinsEnemy : EnemyAi
{
	protected override void OnDeath()
	{
		
		var dropScene = GD.Load<PackedScene>("res://drop_enemy.tscn");

		var c = new Color()
		{
			R8 = 0,
			G8 = 140,
			B8 = 255
		};

		var drop1 = (Node2D) dropScene.Instantiate();
		var drop2 = (Node2D) dropScene.Instantiate();
		
		GD.Print("Spawned Drops");

		GetTree().CurrentScene.AddChild(drop1);
		GetTree().CurrentScene.AddChild(drop2);
		
		drop1.GlobalPosition = new Vector2(GlobalPosition.X + 100 , GlobalPosition.Y);
		drop2.GlobalPosition = new Vector2(GlobalPosition.X + -100 , GlobalPosition.Y);

		var signal1 = (Node2D) drop1.FindChild("Signal");
		var signal2 = (Node2D) drop2.FindChild("Signal");

		signal1.Modulate = c;
		signal2.Modulate = c;
		
		base.OnDeath();
	}
}