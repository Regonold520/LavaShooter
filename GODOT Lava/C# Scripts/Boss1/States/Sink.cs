using Godot;
using System;
using System.Security.Cryptography.X509Certificates;

public partial class Sink : State
{

	private bool _animFinished = false;

	public override void EnterState()
	{
		base.EnterState();
		
		Animate();
	}

	private async void Animate()
	{
		BossAnim.Animation = "Sink";
		
		await ToSignal(GetTree().CreateTimer(0.4f), "timeout");
		
		_stateMachine.SwitchState("Puddle");
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
