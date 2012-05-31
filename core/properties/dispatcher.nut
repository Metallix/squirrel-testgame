RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/dispatch" );

namespace( "core", function()
{
class Dispatcher extends Property
{
	context = null;
	
	constructor( context )
	{
		this.context = context;
	}
}

Dispatcher[ Dispatch ] <- function( message )
{
	context.dispatchMessage( message.message );
}
});