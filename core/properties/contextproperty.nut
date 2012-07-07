RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/addtocontext" );
RequireScript( "/data/core/message/removefromcontext" );

namespace( "core", function()
{
class ContextProperty extends core.Property
{
    dynamicObject = null;
}

ContextProperty[ core.AddToContext ] <- function ( message )
{
    dynamicObject = message.context.addDynamicObject( this );
}

ContextProperty[ core.RemoveFromContext ] <- function ( message )
{
    message.context.removeDynamicObject( dynamicObject );
}

});