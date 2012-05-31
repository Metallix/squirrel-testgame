RequireScript( "/data/game/entityfactory" );
RequireScript( "/data/core/rendermanager" );
RequireScript( "/data/core/updatemanager" );
RequireScript( "/data/core/message/setimagedata" );

namespace( "game", function()
{
class LevelState
{
	</ Inject = "renderManager" />
	renderManager = null;
	</ Inject = "updateManager" />
	updateManager = null;
	</ Inject = "gameEntityFactory" />
	gameEntityFactory = null;
	
	player = null;
	
	updateMessage = core.Update( 0 );
	
	</ ContextState = ContextState.INITIALIZE />
	function init()
	{
		//player = gameEntityFactory.createEntity( "Player" );
		//player[ core.SetImageData( Texture.FromFile( "/data/resources/image/player.png" ) ) ];
	}
	
	function onBecomeActive()
	{
		//renderManager.addEntity( player );
		//updateManager.addEntity( player );
	}
	
	function update( t )
	{
	}
	
	function onResignActive()
	{
		//renderManager.removeEntity( player );
		//updateManager.removeEntity( player );
	}
}
})