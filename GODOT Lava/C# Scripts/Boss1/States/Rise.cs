using Godot;
using System;

public partial class Rise : State
{
	
	private bool _animFinished = false;

	public override void EnterState()
	{
		base.EnterState();
		
		Animate();
	}

	private async void Animate()
	{
		BossAnim.Animation = "Rise";
		
		await ToSignal(GetTree().CreateTimer(0.4f), "timeout");

		_boss1.IsFrozen = false;
		
		_stateMachine.SwitchState("Pursue");
	}

	protected override void ExitState()
	{
		base.ExitState();
	}

	public override void _Process(double delta)
	{
		base._Process(delta);

	}

	private void _on_animation_animation_finished()
	{
		GD.Print("EAA");
	}
}
