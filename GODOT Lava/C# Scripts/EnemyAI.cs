using Godot;
using Godot.Collections;

public partial class EnemyAI : CharacterBody2D
{
	private PlayerVariables _playerVariables;
	private bool start_finished = false;

	private float speed;

	[ExportGroup("Reward Stuff")] 
	[Export] private int EssenceCount = 1;
	
	[ExportGroup("Movement Stuff")]
	[Export] private float MinSpeed = 4600f;
	[Export] private float MaxSpeed = 9700f;
	
	[ExportGroup("Damage Stuff")]
	[Export] private int Damage = 5;

	[Export] private int Health = 1;

	public override void _Ready()
	{
		_playerVariables = GetNode<PlayerVariables>("/root/PlayerVariables");
		
		speed = (float) GD.RandRange(MinSpeed, MaxSpeed);
		
		GD.Print($"Spawned in with a speed of {speed} ({MinSpeed} to {MaxSpeed})!");
		
		var rand_pos_x = GD.RandRange(0, GetWindow().Size.X);
		var rand_pos_y = GD.RandRange(0, GetWindow().Size.Y);

		GlobalPosition = new Vector2(rand_pos_x, rand_pos_y);
		
		StartAnim();
	}

	public override void _Process(double delta)
	{
		if(start_finished) Move(delta);
		
		var Collider = GetNode<Area2D>("Area2D").GetOverlappingBodies();
		var SingleBody = Collider[0].Name;

		if (SingleBody != "Player"); OnBodyEntered();


	}

	protected virtual void Move(double delta)
	{
		var player = (Node2D) GetTree().CurrentScene.FindChild("Player");

		var pDirectionTo = GlobalPosition.DirectionTo(player.GlobalPosition) * (float) delta;
		
		Velocity = pDirectionTo * speed;
		MoveAndSlide();
		
		FlipSprite(player);
	}

	protected virtual void OnDeath()
	{
		PlayHitSfx();
		
		var EssenceScene = GD.Load<PackedScene>("res://essence.tscn");

		for (int i = 0; i < EssenceCount; i++)
		{
			var essence = (Node2D) EssenceScene.Instantiate();
			GetTree().CurrentScene.AddChild(essence);
			essence.GlobalPosition = GlobalPosition;
			
		}
		
		QueueFree();
	}
	

	protected virtual void OnHit()
	{
		Health--;
		
		if(Health == 0) OnDeath(); PlayHitSfx();

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
			var Sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
			Sprite.Scale = new Vector2(-0.184f, 0.184f);
		}
		else if (player.GlobalPosition < GlobalPosition)
		{
			var Sprite = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
			Sprite.Scale = new Vector2(0.184f, 0.184f);
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
		start_finished = true;
		
		GetNode<AnimatedSprite2D>("AnimatedSprite2D").Modulate = c2;
		signal.Modulate = c;
	}
	
	private void OnBodyEntered()
	{
		_playerVariables.Health -= Damage;
		
		PlayHitSfx();
		
		QueueFree();
	}
}
