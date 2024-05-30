using Godot;
using System;

public partial class State : Node
{
	protected StateMachine _stateMachine;
	protected Boss1 _boss1;
	
	[Export] public bool StateActive = false;

	public string StateStr;
	
	[Export] public AnimatedSprite2D BossAnim;

	public virtual void EnterState()
	{
		_stateMachine = (StateMachine) GetTree().CurrentScene.FindChild("Boss1").FindChild("StateMachine");
		_boss1 = (Boss1)GetTree().CurrentScene.FindChild("Boss1");
		BossAnim = (AnimatedSprite2D) GetTree().CurrentScene.FindChild("Boss1").FindChild("Animation");
	}
	protected virtual void ExitState() {}

	public override void _Process(double delta)
	{
		
	}
	
}
