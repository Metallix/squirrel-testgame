namespace( "core", function(){

class DynamicContextObject
{
	instance = null;
	context = null;
	next = null;
	
	constructor( instance, context )
	{
		this.instance = instance;
		this.context = context;
	}
}

});