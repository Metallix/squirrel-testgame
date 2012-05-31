RequireScript( "/data/game/battle/selecttargetbattleaction" );

namespace( "game", function()
{
class SelectTargetBattleAction
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