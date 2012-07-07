RequireScript( "/data/core/properties/contextproperty" );
RequireScript( "/data/game/model/spriteset" );
RequireScript( "/data/seagame/message/collectenergysphere" );
RequireScript( "/data/seagame/message/prepareevolution" );

namespace( "seagame", function()
{
class Creature1a extends core.ContextProperty
{
    static getPosition = core.GetPosition();
    static requiredSphereCount = 50;
    
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    
    canvas = Canvas.FromFile( "/data/seagame/gfx/1a.png" );
    glow = Canvas.FromFile( "/data/seagame/gfx/starglow.png" );
    spriteset = null;
    glowSprite = null;
    position = null;
    rotation = null;
    renderPosition = null;
    collectedSpheres = null;
    
    constructor()
    {
        spriteset = model.SpriteSet();
        spriteset.createFromImage( canvas, canvas.width, canvas.height );
        spriteset.setPivot( Vec2( canvas.width / 2, canvas.height / 2 ) );
        
        glowSprite = model.SpriteSet();
        glowSprite.createFromImage( glow, glow.width, glow.height );
        glowSprite.setPivot( Vec2( glow.width / 2, glow.height / 2 ) );
        
        position = Vec2( 0, 0 );
        rotation = 0;
        collectedSpheres = 0;
    }
    
    function render( t, x, y, m )
    {
        rotation += t / 50.0;
        position.x = x;
        position.y = y;
        spriteset.setPosition( position );
        spriteset.setRotation( rotation );
        spriteset.render( t, m );
        spriteset.setRotation( -rotation * 2 );
        spriteset.render( t, m );
        renderPosition = position.transform( m );
        DrawRect( renderPosition.x - 5, renderPosition.y - 5, 10, 10, CreateColor( 255,255,255 ) );
        
        renderGlow( t, m );
    }
    
    function collectSphere()
    {
        collectedSpheres++;
        
        if ( collectedSpheres == 3 )
        {
            dispatcher( seagame.PrepareEvolution() );
        }
    }
    
    function renderGlow( t, m )
    {
        local alpha = Math.min( 255, Math.max( 0, collectedSpheres * 20 - Math.randf() * 50 ) ).tointeger();
        
        glowSprite.mask = 0xFFFFFF00 | alpha;
        glowSprite.setPosition( position );
        glowSprite.setRotation( rotation / 2.0 );
        glowSprite.render( t, m );
    }
}

Creature1a[ core.Render ] <- function( message )
{
    local position = entity[ getPosition ][ core.Position ];
    render( message.time, position.x, position.y, message.cameraMatrix );
}

Creature1a[ seagame.CollectEnergySphere ] <- function( message )
{
    collectSphere();
}

});