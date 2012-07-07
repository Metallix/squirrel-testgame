RequireScript( "/data/game/state/gamestate" );

namespace( "seagame", function()
{
class EvolutionState1a extends state.GameState
{    
    static maxSpheres = 20;
    
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
    
    
    energySphereCount = null;
    spawnSphereTimer = 1000;
    spheres = null;
    camera = null;
    
    constructor()
    {
        energySphereCount = 0;
        spheres = {};
    }
    
    function onBecomeActive()
    {
        camera = seaEntityFactory.createEntity( "DynamicCamera" );
        camera[ game.SetCameraTarget( gameModel.playerEntity ) ];
        camera[ core.AddToContext( context ) ];
        updateManager.addEntity( camera );
    }
    
    function update( t )
	{
		if ( energySphereCount < maxSpheres && spawnSphereTimer <= 0 )
        {
            spawnEnergySphere()
            spawnSphereTimer = 500;
            utils.debugLog.info( "spawned " + energySphereCount );
        }
        else
        {
            spawnSphereTimer -= t;
        }
        
        local removeArray = [];
        foreach ( sphere in spheres )
        {
            if ( sphere[ seagame.GetEnergySphereState() ][ seagame.EnergySphere ] ) removeArray.push( sphere );
        }
        foreach ( sphere in removeArray )
        {
            removeEnergySphere( sphere );
        }
	}
    
    function onResignActive()
    {
        camera[ core.RemoveFromContext() ];
        updateManager.removeEntity( camera );
    }
    
    function spawnEnergySphere()
    {
        energySphereCount++
        
        local playerPos = gameModel.playerEntity[ core.GetPosition() ][ core.Position ];
        local distanceVec = Vec2( 500, 0 );
        distanceVec.rotateBy( Math.randf() * 360 );
        local spawnPos = playerPos + distanceVec;        
        local moveVector = spawnPos - playerPos;
        moveVector.normalize();
        moveVector.rotateBy( Math.randf() > 0.5 ? 25 : -25 );
        local sphere = seaEntityFactory.createEntity( "EnergySphere" );
        sphere[ core.SetPosition( spawnPos.x, spawnPos.y ) ];
        sphere[ seagame.SetEnergySphereConfig( moveVector * -200, gameModel.playerEntity ) ];
        
        renderManager.addEntity( sphere );
        updateManager.addEntity( sphere );
        
        spheres[ sphere ] <- sphere;
    }
    
    function removeEnergySphere( sphere )
    {
        renderManager.removeEntity( sphere );
        updateManager.removeEntity( sphere );
        delete spheres[ sphere ];
        energySphereCount--
    }
    
    function prepareEvolution()
    {
        camera[ core.SetScale( 5, 5 ) ];
    }
}

EvolutionState1a[ seagame.PrepareEvolution ] <- function( message )
{
    prepareEvolution();
}
});