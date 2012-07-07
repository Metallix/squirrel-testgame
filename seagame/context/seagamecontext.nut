RequireScript("/data/game/gamecontext");
RequireScript("/data/game/message/setgamestate");
RequireScript("/data/seagame/state/seagamestate");
RequireScript("/data/seagame/entityfactory/seaentityfactory");
RequireScript("/data/seagame/model/gamemodel");

namespace( "seagame", function()
{

class SeaGameContextInitializer
{
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    
    </ ContextState = ContextState.COMPLETE />
    function init()
    {
        dispatcher( game.SetGameState( seagame.SeaGameState() ) );
    }
}

class SeaGameContext extends game.GameContext
{
    initializer = SeaGameContextInitializer();
    
    seaEntityFactory = seagame.SeaEntityFactory();
    
    gameModel = seagame.GameModel();
}

});