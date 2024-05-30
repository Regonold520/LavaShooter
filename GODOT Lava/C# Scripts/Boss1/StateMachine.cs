using Godot;
using System;

public partial class StateMachine : Node
{
	private State StartState;
	
	public State ActiveState;

	public string ActiveStateStr;
	
	public override void _Ready()
	{
		
		StartState = (State) FindChild("Pursue");
		ActiveState = StartState;
		ActiveStateStr = "Pursue";
		ActiveState.StateActive = true;
		
		

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}

	private void Test()
	{
		GD.Print("YOU GOT ME :(");
	}

	public void SwitchState(string State)
	{
		ActiveState.StateActive = false;
		ActiveState = (State) FindChild(State);
		
		ActiveStateStr = State.ToString();
		
		GD.Print(ActiveStateStr);
		
		ActiveState.StateActive = true;
		ActiveState.EnterState();
	}

}
 
