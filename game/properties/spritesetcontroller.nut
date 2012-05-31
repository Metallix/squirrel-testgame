RequireScript( "/data/core/property" );
RequireScript( "/data/game/message/setspriteset" );
RequireScript( "/data/game/message/playermoved" );
RequireScript( "/data/core/message/update" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/setrotation" );
RequireScript( "/data/core/properties/position" );
RequireScript( "/data/core/properties/rotation" );

namespace( "game", function()
{
class SpritesetController extends core.Property
{
	spriteset = null;
	receivedPlayerMoved = false;
	getPosition = core.GetPosition();
    getRotation = core.GetRotation();
}

SpritesetController[ game.SetSpriteset ] <- function( message )
{
	spriteset = message.spriteset;
}

SpritesetController[ game.PlayerMoved ] <- function( message )
{
	receivedPlayerMoved = true;
	spriteset.currentMode = message.direction;
}

SpritesetController[ core.Update ] <- function( message )
{
	if ( receivedPlayerMoved )
	{
		receivedPlayerMoved = false;
		spriteset.animate();
	}
	else
	{
		spriteset.reset();
	}
}

SpritesetController[ core.SetPosition ] <- function( message )
{
    if ( spriteset ) spriteset.setPosition( Vec2( message.x, message.y ) );
}

SpritesetController[ core.SetRotation ] <- function( message )
{
    if ( spriteset ) spriteset.setRotation( message.degrees );
}

SpritesetController[ core.Render ] <- function( message )
{
    spriteset.render( message.time, message.cameraMatrix );
}
});