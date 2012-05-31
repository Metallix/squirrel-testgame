RequireScript("/common/scripts/font");
RequireScript("/data/core/context");
RequireScript("/data/mapengine/message/startmapengine");
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
	</ Inject = "sphereIntro" />
	sphereIntro = null;
	</ Inject = "renderManager" />
	renderManager = null;
    </ Inject = "guiRenderManager" />
	guiRenderManager = null;
	</ Inject = "updateManager" />
	updateManager = null;
    </ Inject = "debugRenderManager" />
	debugRenderManager = null;
    </ Inject = "battleIntro" />
    battleIntro = null;
	
	gameStates = [ state.GameState() ];
	
	lastUpdateTicks = 0;
	lastRenderTicks = 0;
    frameTime = 0;
    ticks = 0;
	
	constructor()
	{
		lastUpdateTicks = GetTicks();
		lastRenderTicks = GetTicks();
	}
	
	</ ContextState = ContextState.COMPLETE />
	function init()
	{
		dispatch( game.PushGameState( battleIntro ) );
		Game.update <- function()
		{
			ticks = GetTicks();
            frameTime = ticks - lastRenderTicks;
			updateManager.update( frameTime );
			gameStates.top().update( frameTime );
			lastUpdateTicks = ticks;
			
		}.bindenv( this );
		
		Game.render <- function()
		{
			ticks = GetTicks();
            frameTime = ticks - lastRenderTicks;
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
        gameStates.top().onResignActive();
        gameStates.pop().onDestroy();
		gameStates.push( message.state );
		gameStates.top().onCreate();
        gameStates.top().onBecomeActive();
	}
    
    </ MessageHandler = game.PushGameState />
	function handlePushGameState( message )
	{
        gameStates.top().onResignActive();
		gameStates.push( message.state );
		gameStates.top().onCreate();
        gameStates.top().onBecomeActive();
	}
    
    </ MessageHandler = game.PopGameState />
	function handlePopGameState( message )
	{
        assert( gameStates.len() > 1, "Cannot pop base gamestate." );
        gameStates.top().onResignActive();
        gameStates.pop().onDestroy();
        gameStates.top().onBecomeActive();
	}
}
});