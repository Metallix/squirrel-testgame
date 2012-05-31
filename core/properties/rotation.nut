RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/getrotation" );
RequireScript( "/data/core/message/setrotation" );

namespace( "core", function()
{
class Rotation extends core.Property
{
    degrees = null;
    constructor()
    {
        degrees = 0;
    }
}

Rotation[ core.SetRotation ] <- function( message )
{
    degrees = message.degrees;
}

Rotation[ core.GetRotation ] <- function( message )
{
    return degrees;
}
});