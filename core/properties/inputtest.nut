RequireScript( "/data/core/property" );
RequireScript( "/data/core/properties/image" );
RequireScript( "/data/core/message/processinput" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/getposition" );
RequireScript( "/data/core/message/dispatch" );
RequireScript( "/data/bullets/bullet" );

namespace("core", function()
{
class InputTest extends core.Property
{
	bulletSetup = null;
	bulletManager = null;
	
	constructor()
	{
		bulletSetup = bullets.BulletSetup();
		bulletSetup.texture = Texture.FromFile( "/data/test.png" );
		bulletSetup.position = Vec2(0,0);
		bulletSetup.velocity = Vec2(1,1);
		bulletSetup.acceleration = Vec2(0,0);
	}
}

InputTest[ core.ProcessInput ] <- function( message ) 
{
	local position = entity[ core.GetPosition() ][ core.Position ];
	/*
	if ( IsKeyDown( KEY_LEFT ) )
	{
		entity[ core.SetPosition( position.x - 10, position.y ) ];
	}
	if ( IsKeyDown( KEY_RIGHT ) )
	{
		entity[ core.SetPosition( position.x + 10, position.y) ];
	}
	if ( IsKeyDown( KEY_UP ) )
	{
		entity[ core.SetPosition( position.x, position.y - 10 ) ];
	}
	if ( IsKeyDown( KEY_DOWN ) )
	{
		entity[ core.SetPosition( position.x, position.y + 10 ) ];
	}
	if ( IsKeyDown( KEY_SPACE ) )
	{
		entity[ core.Dispatch( bullets.AddBullet( bulletSetup ) ) ];
	}*/
}
});