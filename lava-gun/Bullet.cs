using Godot;
using System;

public partial class Bullet : Area2D
{

	public float ExpirationTime = 20f;
	public float speed = 350f;
	
	public override void _Ready()
	{
		var expiration = (Timer) FindChild("Expiration");

		expiration.WaitTime = ExpirationTime;

		expiration.Timeout += OnExpiration;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		var move_vec = new Vector2(speed, 0).Rotated(Rotation);
		Position += move_vec * new Vector2((float) delta,(float) delta);
	}

	private void OnExpiration()
	{
		QueueFree();
	}
}
