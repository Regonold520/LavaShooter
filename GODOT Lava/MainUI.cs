using Godot;
using System;

public partial class MainUI : CanvasLayer
{

	private Label BossHealth;
	private Label BossName;

	private PlayerVariables _playerVariables;
	
	public override void _Ready()
	{
		BossHealth = GetNode<Label>("BossHealth");
		BossName = GetNode<Label>("BossName");
		
		_playerVariables = GetNode<PlayerVariables>("/root/PlayerVariables");

	}

	public override void _Process(double delta)
	{
		if (_playerVariables.BossActive)
		{
			BossName.Visible = true;
			BossHealth.Visible = true;
			
			ChangeBossText();
		}
		else
		{
			BossName.Visible = false;
			BossHealth.Visible = false;
		}
		
	}

	private void ChangeBossText()
	{
		BossName.Text = _playerVariables.CurrentBoss;
		BossHealth.Text = _playerVariables.BossHP.ToString();
	}
}
