RequireScript( "/data/core/property" );
RequireScript( "/data/bullets/message/setbulletmanager" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/core/message/update" );

namespace( "bullets", function()
{
class BulletRenderer extends core.Property
{
	bulletManager = null;
}
BulletRenderer[ SetBulletManager ] <- function ( message )
{
	bulletManager = message.bulletManager;
}

BulletRenderer[ core.Render ] <- function ( message )
{
    assert( bulletManager, "No bullet manager defined." );
    bulletManager.render();
}

BulletRenderer[ core.Update ] <- function ( message )
{
    assert( bulletManager, "No bullet manager defined." );
    bulletManager.update( message.time );
}
});