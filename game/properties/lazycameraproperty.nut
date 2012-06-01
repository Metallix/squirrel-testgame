RequireScript( "/data/core/properties/contextproperty" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/setscale" );
RequireScript( "/data/core/message/setrotation" );
RequireScript( "/data/core/message/update" );

namespace( "game", function()
{
class LazyCameraProperty extends core.ContextProperty
{
    </ Inject = "renderManager" />
    renderManager = null;

    target = null;
    current = null;
    
    lazyTime = 500.0;
    
    constructor()
    {
        target = createInitValues();
        current = createInitValues();
    }
    
    function createInitValues()
    {
        return (
        {
            position = Vec2( 0, 0 ),
            scale = Vec2( 1, 1 ),
            rotation = 0
        } );
    }
    
    function update( t )
    {
        current.position.x = getLazyValue( current.position.x, target.position.x, t );
        current.position.y = getLazyValue( current.position.y, target.position.y, t );
        current.scale.x = getLazyValue( current.scale.x, target.scale.x, t );
        current.scale.y = getLazyValue( current.scale.y, target.scale.y, t );
        current.rotation = getLazyValue( current.rotation, target.rotation, t );
        
        setCameraMatrix();
    }
    
    function getLazyValue( currentValue, targetValue, time )
    {
        return currentValue + ( targetValue - currentValue ) * ( time / lazyTime )
    }
    
    function setCameraMatrix()
    {
        renderManager.worldMatrix.setTranslation( current.position.x, current.position.y );
        renderManager.cameraMatrix.setScale( current.scale.x, current.scale.y );
        renderManager.cameraMatrix.setRotation( current.rotation );
    }
}

LazyCameraProperty[ core.SetPosition ] <- function ( message )
{
    target.position.x = - message.x;
    target.position.y = - message.y;
}

LazyCameraProperty[ core.SetScale ] <- function ( message )
{
    target.scale.x = message.x;
    target.scale.y = message.y;
}

LazyCameraProperty[ core.SetRotation ] <- function ( message )
{
    target.rotation = - message.degrees * Math.PI / 180.0;
}

LazyCameraProperty[ core.Update ] <- function ( message )
{
    update( message.time );
}

});