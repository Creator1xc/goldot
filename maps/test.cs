using Godot;
using System;

public class test : Node
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
    
    
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        // get the parent node of this node
        Node parent = GetParent();
        // then get the info_player_start node from the parent
        Node info_player_start = parent.GetNode("info_player_start");
        // get the health variable from the info_player_start node
        object health = info_player_start.Get("health");
        // set the health to 50
        info_player_start.Set("health", 200);

        // get the useable StaticBody from the parent
        StaticBody useable = parent.GetNode<StaticBody>("useable");
        // connect the signal use_function
        useable.Connect("use_function", this, "hello_world");

    }

    public void hello_world()
    {
        // Get our door_default node
        Node door_default = GetParent().GetNode("door_default");
        // run the open_door function
        door_default.Call("open_door");


    }



//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
