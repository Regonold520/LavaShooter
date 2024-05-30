using Godot;
using System;

public partial class DropEnemy : EnemyAI
{
	protected override void OnDeath()
	{
		base.OnDeath();
		
		GD.Print("SIGMA SKIBIDI");
	}
}
