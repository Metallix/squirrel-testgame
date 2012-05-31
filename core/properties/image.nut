RequireScript("/data/core/property");
RequireScript("/data/core/message/setimagedata");
RequireScript("/data/core/message/setposition");
RequireScript("/data/core/message/getposition");
RequireScript("/data/core/properties/position");
RequireScript("/data/core/message/render");

namespace("core", function()
{
class Image extends core.Property
{
	texture = null;
	getPosition = core.GetPosition();
}

Image[ core.SetImageData ] <- function( message )
{
	texture = message.texture;
}

Image[ core.Render ] <- function( message )
{
	local position = entity[ getPosition ][ core.Position ];
	DrawImage( texture, position.x, position.y );
}

});