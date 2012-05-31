RequireScript( "/data/core/property" );
RequireScript( "/data/core/properties/position" );
RequireScript( "/data/mapengine/message/getmapposition" );
RequireScript( "/data/mapengine/message/setmapposition" );
RequireScript( "/data/core/message/update" );
RequireScript( "/data/game/message/playermoved" );
RequireScript( "/data/mapengine/properties/mapentity" );

namespace( "game", function()
{
class PlayerInput extends core.Property
{
	getPosition = message.GetMapPosition();
	setPosition = message.SetMapPosition( 0, 0, 0 );
	playerMoved = game.PlayerMoved( 0 );
}

PlayerInput[ core.Update ] <- function ( message )
{
	local position = entity[ getPosition ][ properties.MapEntity ]
	setPosition.x = position.x;
	setPosition.y = position.y;
	setPosition.z = position.z;
	
	if ( Kbd.up.pressed )
	{
		setPosition.y-=1.5;
		playerMoved.direction = 0;
		entity[ setPosition ];
		entity[ playerMoved ];
	}
	if ( Kbd.right.pressed )
	{
		setPosition.x+=1.5;
		playerMoved.direction = 1;
		entity[ setPosition ];
		entity[ playerMoved ];
	}
	if ( Kbd.left.pressed )
	{
		setPosition.x-=1.5;
		playerMoved.direction = 2;
		entity[ setPosition ];
		entity[ playerMoved ];
	}
	if ( Kbd.down.pressed )
	{
		setPosition.y+=1.5;
		playerMoved.direction = 3;
		entity[ setPosition ];
		entity[ playerMoved ];
	}
	if ( Kbd.a.pressed )
	{
		setPosition.z+=1.5;
		entity[ setPosition ];
	}
	if ( Kbd.q.pressed )
	{
		setPosition.z-=1.5;
		entity[ setPosition ];
	}
}
});