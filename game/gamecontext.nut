RequireScript( "/data/core/context" );
RequireScript( "/data/core/rendermanager" );
RequireScript( "/data/core/updatemanager" );
RequireScript( "/data/core/debugrendermanager" );
RequireScript( "/data/game/gameloop" );
RequireScript( "/data/game/entityfactory" );
RequireScript( "/data/game/state/flightstate" );
RequireScript( "/data/game/state/sphereintro" );
RequireScript( "/data/game/state/battleintro" );
RequireScript( "/data/game/state/levelstate" );
RequireScript( "/data/game/gameloop" );
RequireScript( "/data/mapengine/mapcontroller" );
RequireScript( "/data/bullets/bulletmanager" );
RequireScript( "/data/game/controller/battlecontroller" );
RequireScript( "/data/game/controller/menucontroller" );
RequireScript( "/data/game/controller/inputcontroller" );

namespace("game", function()
{
class GameContext extends core.Context
{
	mapController = mapengine.MapController();
    
	renderManager = render.RenderManager();
	updateManager = update.UpdateManager();
    guiRenderManager = render.RenderManager();
    debugRenderManager = render.DebugRenderManager();
	
	gameEntityFactory = game.EntityFactory();
	
	gameLoop = game.GameLoop();
    
    bulletManager = bullets.BulletManager();
    
    battleController = game.BattleController();
    menuController = game.MenuController();
    inputController = game.InputController();
    
    sharedData = {};
}
});