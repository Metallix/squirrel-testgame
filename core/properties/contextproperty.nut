RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/addtocontext" );
RequireScript( "/data/core/message/removefromcontext" );

namespace( "core", function()
{
class ContextProperty extends core.Property
{
}

ContextProperty[ core.AddToContext ] <- function ( message )
{
    message.context.addDynamicObject( this );
}

ContextProperty[ core.RemoveFromContext ] <- function ( message )
{
    message.context.removeDynamicObject( this );
}

});