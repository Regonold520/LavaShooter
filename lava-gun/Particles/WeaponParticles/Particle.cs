using Godot;
using System;

public partial class Particle : CpuParticles2D
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Finished += ParticleFinished;
	}

	private void ParticleFinished()
	{
		QueueFree();
	}
}
