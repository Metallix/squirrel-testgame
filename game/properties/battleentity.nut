RequireScript( "/data/core/properties/contextproperty" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/game/message/proceedbattle" );
RequireScript( "/data/game/message/requestbattlemenu" );
RequireScript( "/data/game/message/showbattlemenu" );
RequireScript( "/data/game/message/getbattleactionlist" );
RequireScript( "/data/game/message/setbattleaction" );
RequireScript( "/data/game/message/setbattletarget" );
RequireScript( "/data/game/message/inflictdamage" );
RequireScript( "/data/game/message/battleentitydestroyed" );
RequireScript( "/data/game/battle/shootbattleaction" );
RequireScript( "/data/game/battle/moveshootbattleaction" );

namespace( "game", function()
{
class BattleEntity extends core.ContextProperty
{
    </ Inject = "MessageDispatcher" />
    dispatcher = null;

    target = null;
    action = null;
    health = null;
    
    constructor()
    {
        health = 100;
    }
    
    function proceedBattle( time )
    {
        if ( !action )
        {
            dispatcher( game.RequestBattleMenu( entity ) );
        }
        else
        {
            action.update( time );
            if ( action.isComplete() )
            {
                action = null;
            }
        }
    }
    
    function inflictDamage( damage )
    {
        health -= damage;
        utils.debugLog.info( health );
        if ( health < 0 )
        {
            destroy();
        }
    }
    
    function destroy()
    {
        dispatcher( game.BattleEntityDestroyed( entity ) );
    }
}

BattleEntity[ game.ProceedBattle ] <- function ( message )
{
    proceedBattle( message.time );
}

BattleEntity[ game.ShowBattleMenu ] <- function ( message )
{
}

BattleEntity[ game.GetBattleActionList ] <- function ( message )
{
    return [ game.ShootBattleAction(), game.MoveShootBattleAction() ];
}

BattleEntity[ game.SetBattleAction ] <- function ( message )
{
    action = message.action;
    action.target = target;
    action.player = entity;
}

BattleEntity[ game.SetBattleTarget ] <- function ( message )
{
    target = message.target;
}

BattleEntity[ core.Render ] <- function ( message )
{
    if ( target )
    {
        local targetPos = target[ core.GetPosition() ][ core.Position ];
        local playerPos = entity[ core.GetPosition() ][ core.Position ];
        local targetVec = targetPos - playerPos;
        targetVec.normalize();
        local orthoTargetVec = Vec2( targetVec.y, - targetVec.x );
        orthoTargetVec.normalize();
        local p1 = playerPos + targetVec * 100;
        local p2 = playerPos + orthoTargetVec * 5;
        local p3 = playerPos + orthoTargetVec * -5;
        
        p1 = p1.transform( message.cameraMatrix );
        p2 = p2.transform( message.cameraMatrix );
        p3 = p3.transform( message.cameraMatrix );
        
        DrawTriangle( p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, CreateColor( 255, 255, 255 ) );
    }
}

BattleEntity[ game.InflictDamage ] <- function ( message )
{
    inflictDamage( message.damage );
}
});