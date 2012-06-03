RequireScript( "/data/game/battle/battleaction" );

namespace( "game", function()
{
class SelectTargetBattleAction extends game.BattleAction
{
    time = null;

    constructor()
    {
        base();
        time = 0;
    }
    
    function update( t )
    {
        time += t;
    }
    
    function isComplete()
    {
        return time > 1000;
    }
}
});