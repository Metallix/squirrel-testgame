RequireScript( "/data/game/state/gamestate" );
RequireScript( "/data/seagame/model/evolutionlevel/evolutionlevel" );

namespace( "seagame", function()
{
class SeaGameState extends state.GameState
{
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    </ Inject = "seaEntityFactory" />
    seaEntityFactory = null;
    </ Inject = "renderManager" />
    renderManager = null;
    </ Inject = "updateManager" />
    updateManager = null;
    </ Inject = "Context" />
    context = null;
    </ Inject = "gameModel" />
    gameModel = null;
    
    function onBecomeActive()
    {
        gameModel.playerEntity = seaEntityFactory.createEntity( "PlayerCreature" );
        gameModel.playerEntity[ core.AddToContext( context ) ]
        renderManager.addEntity( gameModel.playerEntity );
        updateManager.addEntity( gameModel.playerEntity );
        
        gameModel.playerEntity[ seagame.SetEvolutionLevel( seagame.EvolutionLevel() ) ];
    }
    
    function onResignActive()
    {
        renderManager.removeEntity( gameModel.playerEntity );
        updateManager.removeEntity( gameModel.playerEntity );
    }
}
});