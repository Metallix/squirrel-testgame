RequireScript( "/data/mapengine/message/setmapposition" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/core/property" );
RequireScript( "/data/mapengine/properties/mapentity" );

namespace( "properties", function()
{
class MapObject extends core.Property
{
	getMapPosition = message.GetMapPosition();
}

MapObject[ core.Render ] <- function( message )
{
	local position = entity[ getMapPosition ][ properties.MapEntity ];
	
	local texture = Cache.texture("/data/resources/image/wall.png");
	
	local w = 32;
	local h = 32;
	local x = position.x;
	local y = position.y - ( position.z * position.y / GetWindowHeight() );
	local p = h - h * y / GetWindowHeight() / 2
	
	DrawTexturedTriangle(
		texture,
		0, 0,
		w, 0,
		0, h,
		x, y,
		x + w, y,
		x, y + p);
	DrawTexturedTriangle(
		texture,
		w, 0,
		w, h,
		0, h,
		x + w, y,
		x + w, y + p,
		x, y + p);
}
});