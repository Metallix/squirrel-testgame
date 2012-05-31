RequireScript( "/data/core/properties/contextproperty" );
RequireScript( "/data/game/message/proceedbattle" );
RequireScript( "/data/game/message/requestbattlemenu" );
RequireScript( "/data/game/message/showbattlemenu" );
RequireScript( "/data/game/message/getbattleactionlist" );
RequireScript( "/data/game/message/setbattleaction" );
RequireScript( "/data/game/battle/shootbattleaction" );

namespace( "game", function()
{
class BattleEntity extends core.ContextProperty
{
    </ Inject = "MessageDispatcher" />
    dispatcher = null;

    target = null;
    action = null;
    
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
    return [ game.ShootBattleAction(), game.ShootBattleAction() ];
}

BattleEntity[ game.SetBattleAction ] <- function ( message )
{
    action = message.action;
    action.target = target;
    action.player = entity;
}
});