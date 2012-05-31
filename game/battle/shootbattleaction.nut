RequireScript( "/data/game/battle/battleaction" );
RequireScript( "/data/core/message/setrotation" );

namespace( "game", function()
{
class ShootBattleAction extends game.BattleAction
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
        player[ core.SetRotation( time / 100.0 ) ];
    }
    
    function isComplete()
    {
        return time > 10000;
    }
}
});