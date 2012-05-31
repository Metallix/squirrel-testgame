RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/getposition" );

namespace("core", function()
{
class Position extends core.Property
{
	position = null;
	constructor()
	{
		position = Vec2( 0, 0 );
	}
}	

Position[ core.SetPosition ] <- function( message )
{
	position.x = message.x;
	position.y = message.y;
}

Position[ core.GetPosition ] <- function( message )
{
	return position;
}

});