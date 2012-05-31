RequireScript( "/data/game/state/gamestate" );
RequireScript( "/data/core/message/addtocontext" );
RequireScript( "/data/core/message/removefromcontext" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/setscale" );
RequireScript( "/data/core/message/setrotation" );

namespace( "state", function()
{
class BattleIntro extends state.GameState
{
    </ Inject = "Context" />
    context = null;
    </ Inject = "updateManager" />
	updateManager = null;
    </ Inject = "renderManager" />
    renderManager = null;
    </ Inject = "gameEntityFactory" />
	gameEntityFactory = null;
    </ Inject = "battleController" />
    battleController = null;
    
    activeTime = 0;
    cameraPosition = 0;
    cameraZoom = 0.1;
    
    function onCreate()
    {
        createBattleEntites();
        createBattleCamera();
        battleController.applyInitialPlayerFormation();
    }
    
    function update( t )
    {
        activeTime += t;
        
        // if ( cameraPosition > 0 )
        // {
            // cameraPosition -= t / 100.0;
            // cameraZoom += t / 10000.0;
        // }
        
        // renderManager.cameraMatrix.setTranslation( cameraPosition, 100 )
        // renderManager.cameraMatrix.setScale( cameraZoom, cameraZoom );
        battleController.update( t );
    }
    
    function createBattleCamera()
    {
        local camera = gameEntityFactory.createEntity( "BattleCamera" );
        camera[ core.AddToContext( context ) ];
        camera[ core.SetPosition( -300, -200 ) ];
        camera[ core.SetScale( 0.5, 0.5 ) ];
        camera[ core.SetRotation( 10 ) ];
        
        updateManager.addEntity( camera );
        battleController.camera = camera;
    }
    
    function createBattleEntites()
    {      
        local ship;
        local spriteset;
        
        ship = gameEntityFactory.createEntity( "PlayerShip" );
		ship[ core.SetPosition( 50, 50 ) ];
        spriteset = model.SpriteSet();
        spriteset.createFromImage( Canvas.FromFile( "/data/resources/bat.png"), 128, 128 );
        spriteset.setPivot( Vec2( 64, 64 ) );
		ship[ game.SetSpriteset( spriteset ) ];
        updateManager.addEntity( ship );
		renderManager.addEntity( ship );
        battleController.addPlayerEntity( ship );
        
        
        ship = gameEntityFactory.createEntity( "PlayerShip" );
		ship[ core.SetPosition( 50, 50 ) ];
        spriteset = model.SpriteSet();
        spriteset.createFromImage( Canvas.FromFile( "/data/resources/bat.png"), 128, 128 );
        spriteset.setPivot( Vec2( 64, 64 ) );
		ship[ game.SetSpriteset( spriteset ) ];
        updateManager.addEntity( ship );
		renderManager.addEntity( ship );
        battleController.addPlayerEntity( ship );
        
        
        ship = gameEntityFactory.createEntity( "PlayerShip" );
		ship[ core.SetPosition( 50, 50 ) ];
        spriteset = model.SpriteSet();
        spriteset.createFromImage( Canvas.FromFile( "/data/resources/bat.png"), 128, 128 );
        spriteset.setPivot( Vec2( 64, 64 ) );
		ship[ game.SetSpriteset( spriteset ) ];
        updateManager.addEntity( ship );
		renderManager.addEntity( ship );
        battleController.addPlayerEntity( ship );
        
        cameraPosition = 100;
    }
}
});