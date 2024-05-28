using Godot;

namespace lavagun.C__Scripts;

public partial class PlayerVariables : Node
{
	[Export] public int Health = 110;

	[Export] private int _essenceStat = 0;

	[Export] public bool IsPaused = false;

	[Export] public bool WaveIntermission = false;
	[Export] public int PotI = 1;
	[Export] public int MaxPots = 3;


	public void Process(double delta)
	{
	}
}