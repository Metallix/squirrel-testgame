RequireScript( "render/renderdata" );

namespace( "mapengine", function()
{
class SpriteData extends render.RenderData
{
	data = null;
	
	constructor( path )
	{
		data = Texture.FromFile( "/data/test.png" );
	}
	
	function render()
	{
		DrawImage( data, 100, 100 );
	}
}
});