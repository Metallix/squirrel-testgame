RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/addtocontext" );
RequireScript( "/data/game/message/proceedbattle" );
RequireScript( "/data/game/message/requestbattlemenu" );
RequireScript( "/data/game/message/battlemenuclosed" );
RequireScript( "/data/game/message/showbattlemenu" );
RequireScript( "/data/game/message/pushmenu" );
RequireScript( "/data/game/message/setcameratarget" );
RequireScript( "/data/game/menu/choosebattleactionmenu" );

namespace( "game", function()
{

enum BattleState
{
    IDLE,
    LOCKED,
    MENU
}

class BattleController
{
    </ Inject = "Context" />
    context = null;
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    </ Inject = "updateManager" />
	updateManager = null;
    </ Inject = "renderManager" />
    renderManager = null;
    
    players = null;
    playerSlots = null;
    state = null;
    camera = null;
    
    constructor()
    {
        state = BattleState.IDLE;
        players = [];
        playerSlots = [ 3, 6, 11 ];
    }
    
    function addPlayerEntity( e )
    {
        updateManager.addEntity( e );
		renderManager.addEntity( e );
        players.push( e );
        e[core.AddToContext( context )];
    }
    
    function removePlayerEntity( e )
    {
        players.remove( players.find( e ) );
        updateManager.removeEntity( e );
		renderManager.removeEntity( e );
    }
    
    function applyInitialPlayerFormation()
    {
        foreach ( index, entity in players )
        {
            entity[ core.SetPosition( 100 + index * 200, 0 ) ];
        }
    }
    
    function update( t )
    {
        switch ( state )
        {
            case BattleState.IDLE: proceedBattle( t ); break;
        }
    }
    
    function proceedBattle( t )
    {
        foreach ( entity in players )
        {
            entity[ game.ProceedBattle( t ) ];
        }
    }
    
    function enterPlayerBattleMenu( player )
    {
        if ( state == BattleState.IDLE )
        {
            state = BattleState.MENU;
            player[ game.ShowBattleMenu() ];
            dispatcher( game.PushMenu( game.ChooseBattleActionMenu( player, getPlayerTargets( player ) ) ) );
            if ( camera )
            {
                camera[ game.SetCameraTarget( player ) ];
            }
        }
    }
    
    function getPlayerTargets( player )
    {
        local targets = [];
        foreach ( entity in players )
        {
            if ( entity != player ) targets.push( entity );
        }
        return targets;
    }
}

BattleController[ game.RequestBattleMenu ] <- function ( message )
{
    enterPlayerBattleMenu( message.player );
}

BattleController[ game.BattleMenuClosed ] <- function ( message )
{
    state = BattleState.IDLE
}

BattleController[ game.BattleEntityDestroyed ] <- function ( message )
{
    removePlayerEntity( message.entity );
}
});