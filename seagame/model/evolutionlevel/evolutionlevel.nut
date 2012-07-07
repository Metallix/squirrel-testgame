RequireScript( "/data/seagame/property/movement" );
RequireScript( "/data/seagame/property/creature1a" );
RequireScript( "/data/seagame/state/evolutionstate1a" );

namespace( "seagame", function()
{
class EvolutionLevel
{
    properties = null;
    state = null;
    
    constructor()
    {
        properties =
        [
            seagame.Movement(),
            seagame.Creature1a()
        ];
        state = seagame.EvolutionState1a();
    }
    
    function getNextLevelA()
    {
        return EvolutionLevel;
    }
    
    function getNextLevelB()
    {
        return EvolutionLevel;
    }
}
});