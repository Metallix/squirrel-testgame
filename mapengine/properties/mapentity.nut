RequireScript("/data/core/property");
RequireScript("/data/core/message/setposition");
RequireScript("/data/mapengine/message/setmapposition");
RequireScript("/data/mapengine/message/getmapposition");
RequireScript("/data/mapengine/message/getrenderinfo");

namespace( "properties", function()
{
class MapEntity extends core.Property
{
	renderIndex = 0;
	renderInfoChanged = false;
	x = 0;
	y = 0;
	z = 0;
	layerIndex = 0;
}

MapEntity[ message.SetMapPosition ] <- function( message )
{
	x = message.x;
	y = message.y;
	z = message.z;
	renderIndex = y;
	renderInfoChanged = true;
	entity[ core.SetPosition( x, y - z ) ];
}

MapEntity[ message.GetMapPosition ] <- function( message )
{
	local position = {};
	position.x <- x;
	position.y <- y;
	position.z <- z;
	return position;
}

MapEntity[ message.GetRenderInfo ] <- function( message )
{
	local output = { layerIndex = layerIndex, renderIndex = renderIndex, renderInfoChanged = renderInfoChanged };
	renderInfoChanged = false;
	return output;
}
});