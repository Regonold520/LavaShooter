using Godot;
using System;

public partial class Puddle : State
{
	public override void EnterState()
	{
		base.EnterState();

		BossAnim.Animation = "Puddle";

		_boss1.speed = 270;
	}

	protected override void ExitState()
	{
		base.ExitState();
	}

	public override void _Process(double delta)
	{
		if (StateActive)
		{
			_boss1 = (Boss1)GetTree().CurrentScene.FindChild("Boss1");

			_boss1.MoveToPlayer();
			
			var player = (Node2D)GetTree().CurrentScene.FindChild("Player");

			// GD.Print(player.GlobalPosition.Round() + " " + _boss1.GlobalPosition.Round());
			
			if (player.GlobalPosition.Round().Y == _boss1.GlobalPosition.Round().Y)
			{
				_boss1.IsFrozen = true;
				_stateMachine.SwitchState("Rise");
			}
		}
	}
}
