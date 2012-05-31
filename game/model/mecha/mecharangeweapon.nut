RequireScript( "/data/bullets/bullet" );

namespace( "game", function()
{
class MechaRangeWeapon
{
    ready = false;
    setup = bullets.BulletSetup();
    
    constructor()
    {
        setup.texture = Cache.texture( "/data/resources/sphere100.png" );
        setup.position = Vec2( 0, 0 );
        setup.velocity = Vec2( 1, 1 );
        setup.acceleration = Vec2( 1, 1 );
        setup.lifetime = 300;
        ready = true;
    }
    
    function fire( position, direction )
    {
        setup.position.x = position.x;
        setup.position.y = position.y;
        setup.acceleration.x = direction.x;
        setup.acceleration.y = direction.y;
        return setup;
    }
}
});