RequireScript( "/data/core/properties/contextproperty" );

namespace( "seagame", function()
{
class Movement extends core.ContextProperty
{
    static getPosition = core.GetPosition();
    
    position = null;
    maxSpeed = null;
    velocity = null;
    moveVector = null;
    friction = 0.1;
    timeFactor = 0.1;
    time = 0;
    maxSpeed = 5;
    
    constructor()
    {
        moveVector = Vec2( 0, 0 );
    }
    
    function update( t )
    {
        if ( t > 0 )
        {
            time = t * timeFactor;        
            moveVector *= Math.pow( 1 - friction, time );
            moveVector.x += ( Kbd.right.pressed ? time : 0 ) - ( Kbd.left.pressed ? time : 0 );
            moveVector.y += ( Kbd.down.pressed  ? time : 0 ) - ( Kbd.up.pressed   ? time : 0 )
            if ( moveVector.getLength() > maxSpeed * time )
            {
                moveVector.normalize();
                moveVector *= maxSpeed * time;
            }
            position = entity[ getPosition ][ core.Position ];
            entity[ core.SetPosition( position.x + moveVector.x, position.y + moveVector.y ) ];
        }
    }
}

Movement[ core.Update ] <- function( message )
{
    update( message.time );
}

});