RequireScript( "/data/game/battle/battleaction" );

namespace( "game", function()
{
class MoveShootBattleAction extends game.BattleAction
{    
    state = null;
    progress = null;
    length = 10000;
    damageStep = null;
    
    constructor()
    {
        base();
        progress = 0;
        state = State({ INIT = 0, MOVE = 1, FINISH = 2 });
        state.INIT.set();
    }
    
    function update( time )
    {
        if ( state.INIT.active() ) init();
        else if ( state.MOVE.active() ) move( time );
    }
    
    function init()
    {
        damageStep = 0;
        state.MOVE.set();
    }
    
    function move( time )
    {
        local playerPos = player[ core.GetPosition() ][ core.Position ];
        local targetPos = target[ core.GetPosition() ][ core.Position ];
        local reverseTargetVector = playerPos - targetPos;
        local transformedReverseTargetVector = reverseTargetVector.transform( math.Matrix33().identity().rotate( time / 1000.0 ) );
        local angle = 90 - transformedReverseTargetVector.getAngle();
        progress += time;
        playerPos = targetPos + transformedReverseTargetVector;
        player[ core.SetPosition( playerPos.x, playerPos.y ) ];
        player[ core.SetRotation( angle ) ];
        
        if (
            damageStep == 0 && progress > 1000 ||
            damageStep == 1 && progress > 2000 ||
            damageStep == 2 && progress > 3000
            )
        {
            target[ game.InflictDamage( 40 ) ];
            damageStep++;
        }
        
        if ( progress >= length )
        {
            state.FINISH.set();
        }
    }
    
    function isComplete()
    {
        return state.FINISH.active();
    }
}
});