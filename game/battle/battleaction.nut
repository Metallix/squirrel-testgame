namespace( "game", function()
{
class BattleAction
{
    player = null;
    target = null;
    
    function requiresTarget()
    {
        return true;
    }
    
    function update( time )
    {
    }
    
    function isComplete()
    {
        return true;
    }
}
});