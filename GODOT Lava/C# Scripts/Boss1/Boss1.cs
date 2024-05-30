using Godot;
using System;

public partial class Boss1 : CharacterBody2D
{
	public float speed = 150f;

	public int health = 100;

	private StateMachine _stateMachine;

	public bool Flippable = true;

	public bool IsFrozen = false;
	
	private PlayerVariables _playerVariables;

	public override void _Ready()
	{
		_stateMachine = (StateMachine)FindChild("StateMachine");
		_playerVariables = GetNode<PlayerVariables>("/root/PlayerVariables");

		_playerVariables.BossActive = true;
		_playerVariables.CurrentBoss = "Slip";
		_playerVariables.BossHP = health;
	}

	public void MoveToPlayer()
	{
		if (!IsFrozen)
		{
			
			var player = (Node2D)GetTree().CurrentScene.FindChild("Player");

			var pDirectionTo = GlobalPosition.DirectionTo(player.GlobalPosition);

			Velocity = pDirectionTo * speed;
			MoveAndSlide();

			if (Flippable) { 
				FlipAnim(player);
			}
			
		}

	}

	public void FlipAnim(Node2D player)
	{
		if (player.GlobalPosition > GlobalPosition)
		{
			var Sprite = GetNode<AnimatedSprite2D>("Animation");
			Sprite.Scale = new Vector2(0.184f, 0.184f);
		}
		else if (player.GlobalPosition < GlobalPosition)
		{
			var Sprite = GetNode<AnimatedSprite2D>("Animation");
			Sprite.Scale = new Vector2(-0.184f, 0.184f);
		}
	}

	private void BossCollided(Node2D body)
	{
		Flippable = false;

		if (_stateMachine.ActiveStateStr == "Pursue")
		{
			;
			_stateMachine.SwitchState("Sink");
		}

	}
	
	private void BossNotCollided(Node2D body)
	{
		Flippable = true;
	}

	public void OnHit()
	{
		health--;

		_playerVariables.BossHP = health;
		
		if(health == 0) OnDeath(); PlayHitSfx();
	}
	
	private void PlayHitSfx()
	{
		var player = (Node2D) GetTree().CurrentScene.FindChild("Player");
		player.GetNode<AudioStreamPlayer2D>("EnemyDeath").Play();
	}
	
	private void OnDeath()
	{
		PlayHitSfx();
		QueueFree();
	}
}
