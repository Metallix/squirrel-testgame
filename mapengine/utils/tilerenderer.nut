RequireScript( "/data/core/utils/drawtexturedquad" );

namespace( "utils", function()
{
class TileRenderer
{
	tilesetCanvas = null;
	tiles = null;
	tileWidth = 0;
	tileHeight = 0;
	tilesetWidth = 0;
	tilesetHeight = 0;
	
	constructor( filename, tileWidth, tileHeight )
	{
		this.tileWidth = tileWidth;
		this.tileHeight = tileHeight;
		
		loadTileset( filename );
	}
	
	function loadTileset( filename )
	{
		tilesetCanvas = Cache.canvas( filename );
		
		tilesetWidth = tilesetCanvas.width / tileWidth;
		tilesetHeight = tilesetCanvas.height / tileHeight;
		
		tiles = [];
		
		local length = tilesetWidth * tilesetHeight
		for ( local index = 0; index < length; index++ )
		{
			tiles.push( createTileCanvas( index ) );
		}
	}
	
	function createTileCanvas( tileIndex )
	{
		local canvas = Canvas( tileWidth, tileHeight );
		canvas.setBlendMode( BM_REPLACE );
		canvas.drawSubImage(
			tilesetCanvas,
			( tileIndex % tilesetWidth ) * tileWidth,
			Math.floor( tileIndex / tilesetHeight ) * tileHeight,
			tileWidth,
			tileHeight,
			0,
			0);
		return canvas;
	}
}
});
