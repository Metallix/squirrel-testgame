RequireScript( "/data/mapengine/controller/sortrendermanager" );
RequireScript( "/data/mapengine/message/getrenderinfo" );
RequireScript( "/data/mapengine/utils/tilerenderer" );
RequireScript( "/data/core/utils/drawtexturedquad" );

namespace( "controller", function()
{
class LayerRenderManager extends controller.SortRenderManager
{
	tileRenderer = null;
	texture = null;
	canvas = null;
	
	constructor()
	{
		base.constructor();
		
		tileRenderer = utils.TileRenderer( "/data/resources/image/dorma.png", 32, 32 );
		
		createCanvas();
		validateCanvas();
	}
	
	function render( t )
	{
		renderLayer( t );
		base.render( t );
	}
	
	function hasChanged( entity )
	{
		return entity[ getRenderInfo ][properties.MapEntity].renderInfoChanged;
	}
	
	function getValue( entity )
	{
		return entity[ getRenderInfo ][properties.MapEntity].renderIndex;
	}
	
	function renderLayer( t )
	{
		drawTexture();
	}
	
	function createCanvas()
	{
		canvas = Canvas( GetWindowWidth(), GetWindowHeight() );
	}
	
	function validateCanvas()
	{
		for ( local x = 0; x < 20; x++ )
		for ( local y = 0; y < 15; y++ )
		{
			canvas.drawSubImage( tileRenderer.tiles[1], 0, 0, 32, 32, x * 32, y * 32 );
		}
		texture = Texture.FromCanvas( canvas );
	}
	
	function drawTexture()
	{
		for ( local i = 0; i < 3; i++ )
			DrawImage( texture, 0, 0 );
	}
}
});