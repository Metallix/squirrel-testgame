RequireScript("/data/mapengine/message/startmapengine");
RequireScript("/data/mapengine/properties/maprenderer");
RequireScript("/data/core/entity");
RequireScript("/data/core/context");
namespace("mapengine", function()
{
class MapController
{
	</ Inject = "renderManager" />
	renderManager = null;
	
	mapEngine = null;
	
	</ ContextState = ContextState.INITIALIZE />
	function init()
	{
		mapEngine = core.Entity();
		mapEngine.addProperty( mapengine.properties.MapRenderer() );
	}
}

MapController[ message.StartMapEngine ] <- function( message )
{
	renderManager.addEntity( mapEngine );
}

});