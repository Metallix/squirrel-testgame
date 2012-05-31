RequireScript( "/data/game/message/setmecharangeweapon" );
RequireScript( "/data/game/message/firemecharangeweapon" );
RequireScript( "/data/core/properties/contextproperty" );

namespace( "game", function ()
{
class MechaRangeWeaponSlot extends core.ContextProperty
{    
    </ Inject = "bulletManager" />
    bulletManager = null;
    
    weapon = null;
}

MechaRangeWeaponSlot[ SetMechaRangeWeapon ] <- function ( message )
{
    weapon = message.weapon;
}

MechaRangeWeaponSlot[ FireMechaRangeWeapon ] <- function ( message )
{
    if ( weapon && weapon.ready )
    {
        bulletManager.addBullet( entity, weapon.fire( Vec2(0,0), Vec2(0,0)i ) );
    }
}

});