RequireScript("/data/core/message/render");
RequireScript("/data/core/entitymanager");
RequireScript("/data/core/utils/math/matrix33");

namespace( "render", function()
{	
class RenderManager extends core.EntityManager
{
	renderMessage = null;
    cameraMatrix = math.Matrix33().identity();
    node = null;
    
	constructor()
	{
		base.constructor();
		renderMessage = core.Render( 0 );
	}
	
	function render( t )
	{
		renderMessage.time = t;
        renderMessage.cameraMatrix = cameraMatrix;
		node = startNode;
        while( node )
        {
            node.entity[ renderMessage ];
            node = node.next;
        }
	}
}
});