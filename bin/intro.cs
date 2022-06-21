using Godot;
using System;

public class intro : Control
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
    //private int counter = 0;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        // Get our VideoPlayer node from the scene
        VideoPlayer videoPlayer = GetNode<VideoPlayer>("VideoPlayer");
        // Connect the videoPlayer's "video_finished" signal to our own "video_finished" slot
        videoPlayer.Connect("finished", this, "finished");
        
    }

    public void finished()
    {
        // Go to our test scene in res://maps/test.tscn
        GetTree().ChangeScene("res://maps/test.tscn");
    }

    public override void _Process(float delta)
    {
        // if user presses escape, go to test scene
        if (Input.IsActionJustPressed("ui_cancel"))
        {
            GetTree().ChangeScene("res://maps/test.tscn");
        }
    }



}
