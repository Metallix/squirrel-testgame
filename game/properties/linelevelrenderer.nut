RequireScript("/data/core/property" );
RequireScript("/data/game/message/setlinelevel" );
RequireScript("/data/core/message/render" );

namespace( "linelevelrenderer", function()
{
class LineLevelRenderer extends Property
{
	lineLevel = null;
	
	function renderLevel()
	{
		local prevVal = 0;
		local currVal = 0;
		for ( local index = 1; index < 160; index ++ )
		{
			currVal = 0;
			DrawLine( 160 + ( index - 1 ) * 2, 240 + prevVal, 160 + index * 2, 240 + currVal, color );
			prevVal = currVal;
		}
	}
}

LineLevelRenderer[ message.SetLineLevel ] <- function ( message )
{
	lineLevel = message.level;
}

LineLevelRenderer[ core.Render ] <- function ( message )
{
	renderLevel();
}

});