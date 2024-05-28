using Godot;

namespace lavagun.C__Scripts;

public partial class WaterSentryEnemy : EnemyAi
{

	protected override void Move(double delta)
	{
		
	}

	
	private void SpawnDrop()
	{
		
		var c = new Color()
		{
			R8 = 0,
			G8 = 140,
			B8 = 255
		};
		
		var dropScene = GD.Load<PackedScene>("res://drop_enemy.tscn");

		var drop = (Node2D) dropScene.Instantiate();
			
		GetTree().CurrentScene.AddChild(drop);

		drop.GlobalPosition = GlobalPosition;

		var signal = (Node2D) drop.FindChild("Signal");

		signal.Modulate = c;
		signal.Position = new Vector2(0,4);
		signal.Scale = new Vector2(0.202f, 0.162f);
	}
	
}