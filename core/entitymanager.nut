namespace( "core", function()
{	
class EntityManager
{
	entities = null;
	
	constructor()
	{
		entities = [];
	}
	
	function addEntity( entity )
	{
		assert( entity, "addEntity called with null entity" );
        entities.push( entity );
	}
    
    function removeEntity( entity )
	{
        entities.remove( entities.find( entity ) );
	}
}
});