using Godot;
using System;
using System.Threading.Tasks;

public partial class WaterSentryEnemy : EnemyAI
{

	protected override void Move(double delta)
	{
		
	}

	
	private void SpawnDrop()
	{
		var DropScene = GD.Load<PackedScene>("res://drop_enemy.tscn");

		var drop = (Node2D) DropScene.Instantiate();
			
		GetTree().CurrentScene.AddChild(drop);

		drop.GlobalPosition = GlobalPosition;
	}
	
}

