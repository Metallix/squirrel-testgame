namespace("game", function()
{
class LineLevelObject extends Property
{
	levelProgres = null;
	
	constructor()
	{
		levelProgress = 0;
	}
	
	function resolvePhysics()
	{
	}
}

LineLevelObject[ core.Update ] <- function( message )
{
	levelProgress++;
	resolvePhysics();
}
});