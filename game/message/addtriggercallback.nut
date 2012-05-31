namespace( "game", function()
{
TRIGGER_ACTIVATE <- 1 << 0;
TRIGGER_UPDATE 	<- 1 << 1;	

class AddTriggerCallback
{
	type = null;
	callback = null;
	
	constructor( type, callback )
	{
		this.type = type;
		this.callback = callback;
	}
}
});