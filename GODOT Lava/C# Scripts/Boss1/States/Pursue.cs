using Godot;
using System;

public partial class Pursue : State
{
	
	public override void EnterState()
	{
		BossAnim.Animation = "Walk";

		_boss1.speed = 150;
		
		base.EnterState();
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
		}
	}
}
