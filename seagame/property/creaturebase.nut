RequireScript( "/data/core/property" );
RequireScript( "/data/seagame/model/evolutionlevel/evolutionlevel" );
RequireScript( "/data/seagame/message/setevolutionlevel" );

namespace( "seagame", function()
{
class CreatureBase extends core.ContextProperty
{   
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    </ Inject = "Context" />
    context = null;
    
    evolutionLevel = null;
    
    function setEvolutionLevel( level )
    {
        if ( evolutionLevel )
        {
            destroyCurrentEvolution();
        }
        createNextEvolution( level );
    }
    
    function evolve( type )
    {
        destroyCurrentEvolution();
        
        switch ( type )
        {
            case "a":
                evolveA();
                break;
            case "b":
                evolveB();
                break;
        }
    }
    
    function evolveA()
    {
        createNextEvolution( evolutionLevel.getNextLevelA() );
    }
    
    function evolveB()
    {
        createNextEvolution( evolutionLevel.getNextLevelB() );
    }
    
    function destroyCurrentEvolution()
    {
        entity[ core.RemoveFromContext() ];
        foreach( property in evolutionLevel.properties )
        {
            entity.removeProperty( property );
        }
        dispatcher( game.PopGameState() );
    }
    
    function createNextEvolution( level )
    {
        evolutionLevel = level;
        foreach( property in evolutionLevel.properties )
        {
            entity.addProperty( property );
        }
        entity[ core.AddToContext( context ) ];
        dispatcher( game.PushGameState( level.state ) );
    }
}

CreatureBase[ seagame.SetEvolutionLevel ] <- function( message )
{
    setEvolutionLevel( message.level );
}
});