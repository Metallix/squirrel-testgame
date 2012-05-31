RequireScript( "/data/core/entity" );

namespace( "mapengine", function()
{

class SpriteFactory
{
	constructor()
	{
	}
	
	function loadSprite( path )
	{
		local sprite = core.Entity();
		
		sprite.addProperty( null );
		
		return sprite();
	}
}

});