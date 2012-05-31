RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/getposition" );
RequireScript( "/data/core/message/setscale" );
RequireScript( "/data/core/message/setrotation" );
RequireScript( "/data/core/message/getrotation" );
RequireScript( "/data/core/message/update" );
RequireScript( "/data/game/message/setcameratarget" );

namespace( "game", function()
{
class FocusCameraProperty extends core.Property
{
    target = null;
    
    getPosition = null;
    setPosition = null;
    position = null;
    getRotation = null;
    setRotation = null;
    rotation = null;
    
    constructor()
    {
        getPosition = core.GetPosition();
        setPosition = core.SetPosition( 0, 0 );
        getRotation = core.GetRotation();
        setRotation = core.SetRotation( 0 );
    }
    
    function update( t )
    {
        if ( target )
        {
            position = target[ getPosition ][ core.Position ];
            setPosition.x = position.x - 320;
            setPosition.y = position.y - 240;
            entity[ setPosition ];
            
            rotation = target[ getRotation ][ core.Rotation ];
            setRotation.degrees = rotation;
            entity[ setRotation ];
        }
    }
}

FocusCameraProperty[ game.SetCameraTarget ] <- function( message )
{
    target = message.target;
}

FocusCameraProperty[ core.Update ] <- function( message )
{
    update( message.time );
}

});