RequireScript( "/data/core/message/setimagedata" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/processinput" );
RequireScript( "/data/core/message/addtocontext" );
RequireScript( "/data/core/message/removefromcontext" );
RequireScript( "/data/game/message/setmechatarget" );
RequireScript( "/data/bullets/message/setbulletmanager" );
RequireScript( "/data/game/message/setmecharangeweapon" );
RequireScript( "/data/game/model/mecha/mecharangeweapon" );
RequireScript( "/data/game/state/gamestate" );
RequireScript( "/data/game/model/spriteset" );

namespace("state", function()
{
class FlightState extends GameState
{
    </ Inject = "Context" />
    context = 0;
	</ Inject = "updateManager" />
	updateManager = null;
    </ Inject = "renderManager" />
	renderManager = null;
    </ Inject = "debugRenderManager" />
	debugRenderManager = null;
	</ Inject = "gameEntityFactory" />
	gameEntityFactory = null;
	</ Inject = "bulletManager" />
	bulletManager = null;
    
	playerShip = null;
	enemyShip = null;
	bullets = null;
	inputMessage = null;
	
	constructor()
	{
		inputMessage = core.ProcessInput();
	}
	
	</ ContextState = ContextState.INITIALIZE />
	function init()
	{
		playerShip = gameEntityFactory.createEntity( "PlayerShip" );
		playerShip[ core.SetPosition( 50, 50 ) ];
        local spriteset = model.SpriteSet();
		spriteset.createFromImage( Canvas.FromFile( "/data/resources/bat.png"), 128, 128 );
        spriteset.setPivot( Vec2( 64, 64 ) );
		playerShip[ game.SetSpriteset( spriteset ) ];
        
        
        enemyShip = gameEntityFactory.createEntity( "EnemyShip" );
		enemyShip[ core.SetImageData( Texture.FromFile("/data/test.png") ) ];
		enemyShip[ core.SetPosition( 250, 250 ) ];
        
        playerShip[ game.SetMechaTarget( enemyShip ) ];
        playerShip[ game.SetMechaRangeWeapon( game.MechaRangeWeapon() ) ];
        
        bulletManager.addGroup( playerShip );
        bullets = gameEntityFactory.createEntity( "Bullets" );
        bullets[ ::bullets.SetBulletManager( bulletManager ) ];
	}
	
	function onBecomeActive()
	{
        playerShip[ core.AddToContext( context ) ];
        
        updateManager.addEntity( playerShip );
		renderManager.addEntity( playerShip );
        debugRenderManager.addEntity( playerShip );
        
        renderManager.addEntity( enemyShip );
		updateManager.addEntity( bullets );
        renderManager.addEntity( bullets );
	}
	
	function onResignActive()
	{
        playerShip[ core.RemoveFromContext( context ) ];
        
        updateManager.removeEntity( playerShip );
		renderManager.removeEntity( playerShip );
        debugRenderManager.removeEntity( playerShip );
        
        renderManager.removeEntity( enemyShip );
        updateManager.removeEntity( bullets );
		renderManager.removeEntity( bullets );
	}
	
	function update( t )
	{
		playerShip[ inputMessage ];
	}
}
});