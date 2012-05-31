RequireScript("/data/core/message/update");
RequireScript("/data/core/entitymanager");

namespace( "update", function()
{	
class UpdateManager extends core.EntityManager
{
	updateMessage = null;
	constructor()
	{
		base.constructor();
		updateMessage = core.Update( 0 );
	}
	
	function update( t )
	{
		updateMessage.time = t;
		foreach ( e in entities )
		{
			e[updateMessage];
		}
	}
}
});