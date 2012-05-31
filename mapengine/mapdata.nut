RequireScript( "/data/core/renderdata" );

namespace( "mapengine", function()
{
class MapData
{		
	width = 20;
	height = 15;
	tileWidth = 16;
	tileHeight = 16;
	layers = null;
	tileset = null;
	
	constructor()
	{
		tileset = [ Texture.FromFile("/data/test.png") ];
		layers =
		[
			{
				name = "ground",
				tiles = [0,0,0,0,0,0,0,0,0,0,0,0],
				width = 4,
				height = 3
			}
		]
	}
}
});