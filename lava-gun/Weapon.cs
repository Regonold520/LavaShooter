using Godot;
using System;
using System.Security.AccessControl;

public partial class Weapon : Node2D
{
	private AnimationPlayer animation;
	private Marker2D firepoint;
	private Timer cooldownTimer;
	
	private PackedScene BulletScene = GD.Load<PackedScene>("res://bullet.tscn");
	private PackedScene ParticlesScene = GD.Load<PackedScene>("res://Particles/WeaponParticles/shoot_particles.tscn");
	
	[Export]
	public float cooldown = 2f;

	private bool canShoot = true;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		animation = (AnimationPlayer) FindChild("AnimationPlayer");
		animation.SpeedScale = cooldown / cooldown / cooldown;
		
		firepoint = (Marker2D) FindChild("FirePoint");
		
		cooldownTimer = (Timer)FindChild("Cooldown");
		cooldownTimer.WaitTime = cooldown;
		cooldownTimer.Timeout += CooldownFinshed;
		cooldownTimer.Start();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (Input.IsActionJustPressed("Click") && canShoot)
		{
			canShoot = false;
			
			animation.Play("Shoot");
			var particle = (CpuParticles2D) ParticlesScene.Instantiate();
			firepoint.AddChild(particle);
			particle.Emitting = true;

			var bullet = BulletScene.Instantiate();
			GetTree().CurrentScene.AddChild(bullet);
			bullet.Set("global_position" , firepoint.GlobalPosition);
			bullet.Set("rotation_degrees", GlobalRotationDegrees - 180);
			bullet.Set("expiration", 20);
			bullet.Set("speed", 2000f);
			
			cooldownTimer.Start();
		}
	}

	private void CooldownFinshed()
	{
		canShoot = true;
	}
}
