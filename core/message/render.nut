namespace( "core", function()
{
class Render
{
	time = 0;
    cameraMatrix = null
	constructor( t, c = null )
	{
		time = t;
        cameraMatrix = c;
	}
}
});