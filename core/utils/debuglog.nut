RequireScript( "/common/scripts/game" );

namespace( "utils", function()
{
class DebugLog
{	
	icons =
	{
		INFO = Cache.texture( "/data/resources/image/system/console_info.png" ),
		WARNING = Cache.texture( "/data/resources/image/system/console_warn.png" ),
		ERROR = Cache.texture( "/data/resources/image/system/console_error.png" )
	}
	displayModes =
	{
		NONE = 0,
		LAST = 1,
		FULL = 2
	};
	types =
	{
		INFO = 0,
		WARNING = 1,
		ERROR = 2
	};
	maxSize = 30;
	iconSpace = 20;
	horizontalMargin = 5;
	verticalMargin = 4;
	
	displayMode = null;
	messagebuffer = null;
	font = null;
	bgColor = null;
	waitForKeyRelease = false;
	
	constructor()
	{
		messagebuffer = [];
		font = Game.getSystemFont();
		bgColor = CreateColor(200,0,0,200);
		displayMode = displayModes.NONE;
	}
	
	function toggleDisplayMode ()
	{
		if ( displayMode == displayModes.NONE) displayMode = displayModes.LAST;
		else if ( displayMode == displayModes.LAST) displayMode = displayModes.FULL;
		else if ( displayMode == displayModes.FULL) displayMode = displayModes.NONE;
	}

	function info( message )
	{
		addMsgObj( { type = types.INFO, message = "" + message } );
	}

	function warn( message )
	{
		addMsgObj( { type = types.WARNING, message = "" + message } );
	}

	function error( message )
	{
		addMsgObj( { type = types.ERROR, message = "" + message } );
	}

	function addMsgObj(obj)
	{
		messagebuffer.push( obj );
		while ( messagebuffer.len() > maxSize ){
			messagebuffer.remove( 0 );
		}
	}

	function render()
	{
		if ( Kbd.f5.pressed && !waitForKeyRelease )
		{
			toggleDisplayMode();
			waitForKeyRelease = true;
		}
		else if ( !Kbd.f5.pressed )
		{
			waitForKeyRelease = false;
		}
		
		if ( displayMode == displayModes.NONE ) return;
		
		if( displayMode == this.displayModes.FULL )
		{
			DrawRect( 0, 0, GetWindowWidth(), GetWindowHeight(), bgColor);
		}
		
		local len = messagebuffer.len();
		local idx = len;
		local pos = GetWindowHeight();
		local height = 0;
		
		if( displayMode == displayModes.LAST && messagebuffer.len() )
		{
			height = getMsgHeight( messagebuffer.top().message );
			pos -= height;
			DrawRect( 0, pos, GetWindowWidth(), height, bgColor );
			renderMessage( messagebuffer.top().type, messagebuffer.top().message, pos, height );
		}
		else while ( --idx >= 0 && ( idx < 1 || displayMode == displayModes.FULL ) )
		{
			height = getMsgHeight( messagebuffer[idx].message );
			pos -= height;
			renderMessage( messagebuffer[ idx ].type, messagebuffer[ idx ].message, pos, height );
		} 
	}

	function getMsgHeight( msg )
	{
		local msgWidth = GetWindowWidth() - horizontalMargin * 2 - iconSpace;
		return Math.max( iconSpace, font.getStringHeight( msg, msgWidth ) + verticalMargin );
	}

	function renderMessage ( type, msg, pos, height )
	{
		local msgWidth = GetWindowWidth() - horizontalMargin * 2 - iconSpace;	
		local img = icons.INFO;
		switch(type){
			case types.WARNING: img = icons.WARNING; break;
			case types.ERROR:   img = icons.ERROR; break;
		}
		DrawImage( img, horizontalMargin, pos + verticalMargin / 2 );
		font.drawTextBox( msg, horizontalMargin + iconSpace, pos + verticalMargin / 2, msgWidth, height );
		
		return height;
	}
}

debugLog <- DebugLog();	

});