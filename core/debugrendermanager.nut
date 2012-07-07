RequireScript("/data/core/message/renderdebug");
RequireScript("/data/core/entitymanager");

namespace( "render", function()
{	
class DebugRenderManager extends core.EntityManager
{
	renderMessage = null;
    node = null;
	constructor()
	{
		base.constructor();
		renderMessage = core.RenderDebug( 0 );
	}
	
	function render( t )
	{
		renderMessage.time = t;
		node = startNode;
        while( node )
        {
            node.entity[ renderMessage ];
            node = node.next;
        }
	}
}
});