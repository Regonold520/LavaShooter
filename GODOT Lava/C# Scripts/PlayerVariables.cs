using Godot;

public partial class PlayerVariables : Node
{
	[Export] public int Health = 110;

	[Export] public int EssenceStat = 0;

	[Export] public bool IsPaused = false;

	[Export] public bool WaveIntermission = false;
	[Export] public int PotI = 1;
	[Export] public int MaxPots = 3;
	
	[ExportGroup("Boss Variables")]
	[Export] public bool BossActive = false;
	[Export] public string CurrentBoss = "";
	[Export] public int BossHP;


	public void Process(double delta)
	{
	}
}
