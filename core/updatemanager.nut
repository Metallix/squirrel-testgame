RequireScript("/data/core/message/update");
RequireScript("/data/core/entitymanager");

namespace( "update", function()
{	
class UpdateManager extends core.EntityManager
{
	updateMessage = null;
	node = null;
    constructor()
	{
		base.constructor();
		updateMessage = core.Update( 0 );
	}
	
	function update( t )
	{
		updateMessage.time = t;
		node = startNode;
        while( node )
        {
            node.entity[ updateMessage ];
            node = node.next;
        }
	}
}
});