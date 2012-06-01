RequireScript("/data/core/message/render");
RequireScript("/data/core/entitymanager");
RequireScript("/data/core/utils/math/matrix33");

namespace( "render", function()
{	
class RenderManager extends core.EntityManager
{
	renderMessage = null;
    cameraMatrix = math.Matrix33().identity().translate(320,240).scale( 2, 2);
    worldMatrix =  math.Matrix33().identity();
    
	constructor()
	{
		base.constructor();
		renderMessage = core.Render( 0 );
	}
	
	function render( t )
	{
		renderMessage.time = t;
        renderMessage.cameraMatrix = cameraMatrix;
        renderMessage.worldMatrix = worldMatrix;
		foreach ( e in entities )
		{
			e[ renderMessage ];
		}
	}
}
});