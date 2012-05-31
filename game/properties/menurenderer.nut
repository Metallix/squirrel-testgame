RequireScript( "/data/core/message/update" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/game/message/setmenu" );

namespace( "game", function()
{
class MenuRenderer extends core.Property
{
    menu = null;
}

MenuRenderer[ core.Update ] <- function( message )
{
    if ( menu ) menu.update( message.time );
}

MenuRenderer[ core.Render ] <- function( message )
{
    if ( menu ) menu.render( message.time, message.cameraMatrix );
}

MenuRenderer[ game.SetMenu ] <- function( message )
{
    menu = message.menu;
}

});