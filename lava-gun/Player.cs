using Godot;
using System;

public partial class Player : CharacterBody2D
{
	public float Speed = 500.0f;
	private float sensitivity = 1250.0f;
	
	private Vector2 direction;

	public override void _Ready()
	{
		var timer = (Timer) FindChild("Texture").FindChild("AnimTimer");

		timer.Timeout += AnimTimer;
	}

	public override void _PhysicsProcess(double delta)
	{
		direction = Input.GetVector("Left", "Right", "Up", "Down");
		
		Velocity = direction * Speed;

		MoveAndSlide();
		HandleTexture();
		HandleWeapon();
		HandleController(delta);
	}

	private void HandleController(double delta)
	{
		return;
		
		float rightStickX = Input.GetActionStrength("StickR") - Input.GetActionStrength("StickL");
		float rightStickY = Input.GetActionStrength("StickD") - Input.GetActionStrength("StickU");

		// Calculate the mouse movement
		Vector2 mouseMovement = new Vector2(rightStickX, rightStickY) * sensitivity * new Vector2((float) delta ,(float) delta);

		// Get the current mouse position
		Vector2 currentMousePos = GetViewport().GetMousePosition();

		// Update the mouse position
		Vector2 newMousePos = currentMousePos + mouseMovement;
		Input.WarpMouse(newMousePos);
	}

	private void HandleTexture()
	{
		var texture = (AnimatedSprite2D) FindChild("Texture");
		
		if (direction.X > 0)
		{
			texture.Scale = new Vector2(-1 , 1);
		}
		if (direction.X < 0)
		{
			texture.Scale = new Vector2(1 , 1);
		}
		
	}

	private void AnimTimer()
	{
		var texture = (AnimatedSprite2D) FindChild("Texture");
		
		if (Velocity != new Vector2(0, 0))
		{
			texture.Animation = "Walk";
		}
		else
		{
			texture.Animation = "Idle";
		}
	}


	private void HandleWeapon()
	{
		var texture = (AnimatedSprite2D) FindChild("Texture");
		
		var WeaponPoint = (Node2D)FindChild("WeaponHolder");
		var Weapon = (Node2D) WeaponPoint.GetChild(0);
		
		WeaponPoint.LookAt(GetGlobalMousePosition());
		WeaponPoint.RotationDegrees -= 180;
		var flip_pos = WeaponPoint.GlobalPosition - Weapon.GlobalPosition;
		
		if (Velocity == new Vector2(0, 0))
		{
			if (flip_pos.X > 0)
			{
				texture.Scale = new Vector2(1, 1);
			}
			if (flip_pos.X <= 0)
			{
				texture.Scale = new Vector2(-1, 1);
			}
		}
	
	
		if (flip_pos.X < 0)
		{
			WeaponPoint.Scale = new Vector2(1, -1);
		}

		else if (flip_pos.X > 0)
		{
			WeaponPoint.Scale = new Vector2(1, 1);
		}
	}
}
