RequireScript( "/data/core/property" );
RequireScript( "/data/game/model/spriteset" );
RequireScript( "/data/seagame/message/setenergysphereconfig" );
RequireScript( "/data/seagame/message/getenergyspherestate" );
RequireScript( "/data/seagame/message/collectenergysphere" );

namespace( "seagame", function()
{
class EnergySphere extends core.ContextProperty
{
    static getPosition = core.GetPosition();
    static setPosition = core.SetPosition( 0, 0 );
    
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
        
    canvas = Canvas.FromFile( "/data/seagame/gfx/energysphere.png" );
    spriteset = null;
    position = null;
    rotation = null;
    alpha = null;
    path = Vec2( 0, 0 );
    lifeTime = null;
    readyToDestroy = null;
    state = null;
    
    player = null;
    playerPos = null;
    playerVec = null;
    
    constructor()
    {
        spriteset = model.SpriteSet();
        spriteset.createFromImage( canvas, canvas.width, canvas.height );
        spriteset.setPivot( Vec2( canvas.width / 2, canvas.height / 2 ) );
        position = Vec2( 0, 0 );
        rotation = 0;
        lifeTime = 0;
        alpha = 0;
        readyToDestroy = false;
        state = State({ FREE = 0, DEAD = 1, COLLECTED = 2 });
        state.FREE.set();
    }
    
    function update( t )
    {
        lifeTime += t;
        rotation += t;
        position = entity[ getPosition ][ core.Position ];     
        playerPos = player[ getPosition ][ core.Position ];
        playerVec = playerPos - position;
        
        if ( !state.COLLECTED.active() && playerVec.getLength() < 100 )
        {
            state.COLLECTED.set();
            player[ seagame.CollectEnergySphere() ];
        }
        
        if ( state.COLLECTED.active() )
        {
            setPosition.x = position.x + playerVec.x * t / 100.0;
            setPosition.y = position.y + playerVec.y * t / 100.0;
        }
        else
        {
            setPosition.x = position.x + path.x * t / 1000.0;
            setPosition.y = position.y + path.y * t / 1000.0;
        }
        
        updateAlpha( t );
        
        entity[ setPosition ]
        
        spriteset.setPosition( position );
        spriteset.mask = 0xFFFFFF00 | alpha;
        
        if ( lifeTime > 5000 )
        {
            die();
        }
    }
    
    function render( t, m )
    {
        spriteset.render( t, m );
    }
    
    function die()
    {
        readyToDestroy = true;
        state.DEAD.set();
    }
    
    function updateAlpha( t )
    {
        if ( state.COLLECTED.active() ) alpha = Math.max( 0, alpha - t ).tointeger();
        else if ( lifeTime < 500 ) alpha = lifeTime / 2;
        else if ( lifeTime < 4500 ) alpha = 250;
        else alpha = ( 5000 - Math.min( lifeTime, 5000 ) ) / 2;
    }
}

EnergySphere[ core.Update ] <- function( message )
{
    update( message.time );
}

EnergySphere[ core.Render ] <- function( message )
{
    render( message.time, message.cameraMatrix );
}

EnergySphere[ seagame.SetEnergySphereConfig ] <- function( message )
{
    path = message.path;
    player = message.player;
}

EnergySphere[ seagame.GetEnergySphereState ] <- function( message )
{
    return readyToDestroy;
}
});