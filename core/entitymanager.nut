namespace( "core", function()
{	
class EntityManager
{
	startNode = null;
    lastNode = null;
    
	constructor()
	{
        startNode = null;
        lastNode = startNode;
	}
	
	function addEntity( entity )
	{
		assert( entity, "addEntity called with null entity" );
        if ( !startNode )
        {
            startNode = { entity = entity, next = null, prev = null };
            lastNode = startNode;
        }
        else
        {
            lastNode.next = { entity = entity, next = null, prev = lastNode };
            lastNode = lastNode.next;
        }
	}
    
    function removeEntity( entity )
	{
        local node = startNode;
        while( node )
        {
            if ( node.entity == entity )
            {
                if ( !node.next ) lastNode = node.prev;
                if ( !node.prev ) startNode = node.next;
                if ( node.prev )
                {
                    node.prev.next = node.next;
                }
                if ( node.next )
                {
                    node.next.prev = node.prev;
                }
                node.next = null;
                node.prev = null;
                return;
            }
            else
            {
                node = node.next;
            }
        }
	}
}
});