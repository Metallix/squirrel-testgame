namespace( "core", function()
{
class Render
{
	time = 0;
    cameraMatrix = null
    worldMatrix = null;
	constructor( t, c = null, w = null )
	{
		time = t;
        cameraMatrix = c;
        worldMatrix = w
	}
}
});