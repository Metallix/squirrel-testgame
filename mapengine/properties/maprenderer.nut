RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/mapengine/controller/layerrendermanager" );

namespace( "mapengine.properties", function()
{

class MapRenderer extends core.Property
{	
	mapData = null;
	cameraPosition = null;
	layerList = null;
	constructor()
	{
		cameraPosition = Vec2();
		layerList = [];
		
		//layerList.push( controller.LayerRenderManager() );
	}
	
	
}

MapRenderer[ core.Render ] <- function ( message )
{
	local index = 0;
	local length = layerList.len();
	for ( index = 0; index < length; index++ )
	{
		layerList[index].render( message.time );
	}
}
});