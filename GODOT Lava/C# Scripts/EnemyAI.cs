using Godot;
using Godot.Collections;

public partial class EnemyAi : CharacterBody2D
{
	private PlayerVariables _playerVariables;
	private bool _startFinished = false;

	private float _speed;

	[ExportGroup("Reward Stuff")] 
	[Export] private int _essenceCount = 1;
	
	[ExportGroup("Movement Stuff")]
	[Export] private float _minSpeed = 4600f;
	[Export] private float _maxSpeed = 9700f;
	
	[ExportGroup("Damage Stuff")]
	[Export] private int _damage = 5;

	[Export] private int _health = 1;

	public override void _Ready()
	{
		_playerVariables = GetNode<PlayerVariables>("/root/PlayerVariables");
		
		_speed = (float) GD.RandRange(_minSpeed, _maxSpeed);
		
		GD.Print($"Spawned in with a speed of {_speed} ({_minSpeed} to {_maxSpeed})!");
		
		var randPosX = GD.RandRange(0, GetWindow().Size.X);
		var randPosY = GD.RandRange(0, GetWindow().Size.Y);

		GlobalPosition = new Vector2(randPosX, randPosY);
		
		StartAnim();
	}

	public override void _Process(double delta)
	{
		if(_startFinished) Move(delta);
		
		var collider = GetNode<Area2D>("Area2D").GetOverlappingBodies();
		var singleBody = collider[0].Name;

		if (singleBody != "Player"); OnBodyEntered();


	}

	protected virtual void Move(double delta)
	{
		var player = (Node2D) GetTree().CurrentScene.FindChild("Player");

		var pDirectionTo = GlobalPosition.DirectionTo(player.GlobalPosition) * (float) delta;
		
		Velocity = pDirectionTo * _speed;
		MoveAndSlide();
		
		FlipSprite(player);
	}

	protected virtual void OnDeath()
	{
		PlayHitSfx();
		
		var essenceScene = GD.Load<PackedScene>("res://essence.tscn");

		for (int i = 0; i < _essenceCount; i++)
		{
			var essence = (Node2D) essenceScene.Instantiate();
			GetTree().CurrentScene.AddChild(essence);
			essence.GlobalPosition = GlobalPosition;
			
		}
		
		QueueFree();
	}
	

	protected virtual void OnHit()
	{
		_health--;
		
		if(_health == 0) OnDeath(); PlayHitSfx();

	}

	private void PlayHitSfx()
	{
		var player = (Node2D) GetTree().CurrentScene.FindChild("Player");
		player.GetNode<AudioStreamPlayer2D>("EnemyDeath").Play();
	}

	private void FlipSprite(Node2D player)
	{
		if (player.GlobalPosition > GlobalPosition)
		{
			var sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
			sprite.Scale = new Vector2(-0.184f, 0.184f);
		}
		else if (player.GlobalPosition < GlobalPosition)
		{
			var sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
			sprite.Scale = new Vector2(0.184f, 0.184f);
		}
	}
	
	private async void StartAnim()
	{
		var c = new Color
		{
			A8 = 0,
			R = 1
		};
		
		var c2 = new Color
		{
			A8 = 255,
			R = 1,
			G = 1,
			B = 1
		};

		var tween = CreateTween();
		var signal = GetNode<Sprite2D>("Signal");
		
		if (_playerVariables.IsPaused == false)
		{
			signal.Modulate = c;
			GetNode<AnimatedSprite2D>("AnimatedSprite2D").Modulate = c;
			GetNode<CollisionShape2D>("CollisionShape2D").Disabled = true;
		}

		tween.TweenProperty(signal, "modulate:a", 1, 1);
		await ToSignal(tween, "finished");

		GetNode<CollisionShape2D>("CollisionShape2D").Disabled = false;
		_startFinished = true;
		
		GetNode<AnimatedSprite2D>("AnimatedSprite2D").Modulate = c2;
		signal.Modulate = c;
	}
	
	private void OnBodyEntered()
	{
		_playerVariables.Health -= _damage;
		
		PlayHitSfx();
		
		QueueFree();
	}
}
