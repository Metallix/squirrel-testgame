namespace( "core", function()
{
class Render
{
	time = 0;
    cameraMatrix = null
	constructor( t, m = null )
	{
		time = t;
        cameraMatrix = m;
	}
}
});