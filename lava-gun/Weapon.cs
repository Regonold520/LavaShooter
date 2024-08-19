using Godot;
using System;
using System.Security.AccessControl;

public partial class Weapon : Node2D
{
	private AnimationPlayer animation;
	private CpuParticles2D particles;
	private Marker2D firepoint;
	
	private PackedScene BulletScene = GD.Load<PackedScene>("res://bullet.tscn");
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		animation = (AnimationPlayer) FindChild("AnimationPlayer");
		particles = (CpuParticles2D) FindChild("ShootParticles");
		firepoint = (Marker2D) FindChild("FirePoint");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (Input.IsActionJustPressed("Click"))
		{
			animation.Play("Shoot");
			particles.Emitting = true;

			var bullet = BulletScene.Instantiate();
			GetTree().CurrentScene.AddChild(bullet);
			bullet.Set("global_position" , firepoint.GlobalPosition);
			bullet.Set("rotation_degrees", GlobalRotationDegrees - 180);
			bullet.Set("expiration", 20);
			bullet.Set("speed", 2000f);
		}
	}
}
