RequireScript("/common/scripts/font");
RequireScript("/data/core/context");
RequireScript("/data/core/properties/image");
RequireScript("/data/core/properties/inputtest");
RequireScript("/data/core/properties/position");
RequireScript("/data/core/message/setposition");
RequireScript("/data/core/message/processinput");
RequireScript("/data/game/state/gamestate");
RequireScript("/data/game/message/setgamestate");
RequireScript("/data/game/message/pushgamestate");
RequireScript("/data/game/message/popgamestate");
RequireScript("/data/core/utils/debuglog");

namespace("game", function()
{	

class GameLoop
{
	</ Inject = "MessageDispatcher" />
	dispatch = null;
    </ Inject = "Context" />
	context = null;
	</ Inject = "renderManager" />
	renderManager = null;
    </ Inject = "guiRenderManager" />
	guiRenderManager = null;
	</ Inject = "updateManager" />
	updateManager = null;
    </ Inject = "debugRenderManager" />
	debugRenderManager = null;
    </ Inject = "bulletManager" />
	bulletManager = null;
		
	lastUpdateTicks = 0;
	lastRenderTicks = 0;
    frameTime = 0;
    ticks = 0;
    gotGameState = false;
    gameStates = null;
    
	constructor()
	{
		lastUpdateTicks = GetTicks();
		lastRenderTicks = GetTicks();
        gameStates = [];
	}
	
	</ ContextState = ContextState.COMPLETE />
	function init()
	{
		Game.update <- function()
		{
			ticks = GetTicks();
            frameTime = ticks - lastRenderTicks;
			
            if ( gotGameState ) gameStates.top().instance.update( frameTime );
            updateManager.update( frameTime );
            bulletManager.update( frameTime );
			
			lastUpdateTicks = ticks;
			
		}.bindenv( this );
		
		Game.render <- function()
		{
			ticks = GetTicks();
            frameTime = ticks - lastRenderTicks;
            
            bulletManager.render();
	        renderManager.render( frameTime );
            guiRenderManager.render( frameTime );
            debugRenderManager.render( frameTime );
            
	        lastRenderTicks = ticks;
	        utils.debugLog.render();
		}.bindenv( this );
	}
	
	</ MessageHandler = game.SetGameState />
	function handleSetGameState( message )
	{
        if ( gotGameState )
        {
            gameStates.top().instance.onResignActive();
            gameStates.top().instance.onDestroy();
            context.removeDynamicObject( gameStates.pop() );
        }
        gameStates.push( context.addDynamicObject( message.state ) );
		gameStates.top().instance.onCreate();
        gameStates.top().instance.onBecomeActive();
        gotGameState = true;
	}
    
    </ MessageHandler = game.PushGameState />
	function handlePushGameState( message )
	{
        if ( gotGameState )
        {
            gameStates.top().instance.onResignActive();
            context.removeDynamicObject( gameStates.top() );
        }
		gameStates.push( context.addDynamicObject( message.state ) );
		gameStates.top().instance.onCreate();
        gameStates.top().instance.onBecomeActive();
        gotGameState = true;
	}
    
    </ MessageHandler = game.PopGameState />
	function handlePopGameState( message )
	{
        assert( gameStates.len() > 0, "Cannot pop gamestate: No state left." );
        if ( gotGameState )
        {
            gameStates.top().instance.onResignActive();
            gameStates.top().instance.onDestroy();
            context.removeDynamicObject( gameStates.pop() );
        }
        context.addDynamicObject( gameStates.top().instance );
        gameStates.top().instance.onBecomeActive();
        gotGameState = gameStates.len() > 0;
	}
}
});