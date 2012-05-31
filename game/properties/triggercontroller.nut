RequireScript( "/data/core/property" );
RequireScript( "/data/game/message/addtriggeractivator" );
RequireScript( "/data/game/message/addtriggercallback" );
RequireScript( "/data/game/message/setspriteset" );
RequireScript( "/data/core/message/update" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/core/message/getposition" );
RequireScript( "/data/core/properties/position" );

namespace( "game", function()
{
class TriggerController extends core.Property
{
	activatorEntityList = null;
	triggerCallbackList = null;
	getPosition = core.GetPosition();
	spriteset = null;
	constructor()
	{
		activatorEntityList = [];
		triggerCallbackList = {};
		triggerCallbackList[ game.TRIGGER_ACTIVATE ] <- [];
		triggerCallbackList[ game.TRIGGER_UPDATE ] <- [];
	}
}

TriggerController[ game.SetSpriteset ] <- function( message )
{
	spriteset = message.spriteset;
}

TriggerController[ AddTriggerActivator ] <- function( message )
{
	local activatorEntity = {};
	activatorEntity.entity <- message.entity;
	activatorEntity.active <- false;
	activatorEntityList.push( activatorEntity );
}

TriggerController[ AddTriggerCallback ] <- function( message )
{
	triggerCallbackList[ message.type ].push( message.callback );
}

TriggerController[ core.Update ] <- function( message )
{
	local length = activatorEntityList.len();
	local entityPosition = null;
	local triggerPosition = entity[ getPosition ][ core.Position ];
	for( local index = 0; index < length; index++ )
	{
		entityPosition = activatorEntityList[ index ].entity[ getPosition ][ core.Position ];
		if ( entityPosition.getDistanceFrom( triggerPosition ) < 10 )
		{
			local type = game.TRIGGER_ACTIVATE;
			if ( activatorEntityList[ index ].active )
			{
				type = game.TRIGGER_UPDATE;
			}
			
			for( local callbackIndex = 0; callbackIndex < triggerCallbackList[ type ].len(); callbackIndex++ )
			{
				triggerCallbackList[ type ][ callbackIndex ]( activatorEntityList[ index ].entity );
			}
			
			activatorEntityList[ index ].active = true;
			spriteset.currentFrame = 1;
		}
		else
		{
			activatorEntityList[ index ].active = false;
			spriteset.currentFrame = 0;
		}
	}
}

TriggerController[ core.Render ] <- function( message )
{
	local position = entity[ getPosition ][ core.Position ];
	spriteset.render( position.x, position.y, message.time );
}

});