RequireScript( "/data/core/dynamiccontextobject" );
namespace("core", function()
{
enum ContextState
{
	UNDEFINED,
	INITIALIZE,
	COMPLETE
};

class Context
{
	state = null;
	dynamicObjects = null;
    firstDynamicObject = null;
	
	constructor()
	{
		state = ContextState.UNDEFINED;
		dynamicObjects = [];
	}
	
	function build()
	{
		this.forEachContextObjectMember( performInjection );
		
		state = ContextState.INITIALIZE;
		this.forEachContextObjectMember( function( contextObject, memberName, attributes ) {
	 		if ( attributes != null )
	 		{
		 		if ( "ContextState" in attributes && state == attributes[ "ContextState" ] && type( contextObject[ memberName ] ) == "function" )
				{
					contextObject[ memberName ]();
				}
	 		}
		});
		state = ContextState.COMPLETE;
		this.forEachContextObjectMember( function( contextObject, memberName, attributes ) {
	 		if ( attributes != null )
	 		{
		 		if ( "ContextState" in attributes && state == attributes[ "ContextState" ] && type( contextObject[ memberName ] ) == "function" )
				{
					contextObject[ memberName ]();
				}
	 		}
		});
	}
	
	function dispatchMessage( message )
	{
        local messageClass = message.getclass();
        
        this.forEachContextObjectMember( function( contextObject, memberName, attributes )
        {
	 		if (    messageClass in contextObject &&
                    type( contextObject[ messageClass ] ) == "function" &&
                    contextObject[ messageClass ] == contextObject[ memberName ]
                    )
            {
                return contextObject[ messageClass ]( message );
            }
            else if (   attributes != null &&
                        "MessageHandler" in attributes &&
                        messageClass == attributes[ "MessageHandler" ] &&
                        type( contextObject[ memberName ] ) == "function" )
            {
                return contextObject[ memberName ]( message );
            }
		});
		return null;
	}
	
	function addDynamicObject( object )
	{
		local dynamicContextObject = ::core.DynamicContextObject( object, this );
		
        if ( firstDynamicObject )
        {
            dynamicContextObject.next = firstDynamicObject
        }
        firstDynamicObject = dynamicContextObject;
		
		local memberClass = object.getclass();
		foreach ( memberName, memberObject in memberClass )
		{
			performInjection( object, memberName, memberClass.getattributes( memberName ) );
		}        
		
		return dynamicContextObject;
	}
	
	function removeDynamicObject( dynamicContextObject )
	{
        local previous = null;
        local current = firstDynamicObject;
        while( current )
        {
            if ( current == dynamicContextObject )
            {
                if ( previous ) previous.next = current.next;
                else firstDynamicObject = null;
            }
            previous = current;
            current = current.next;
        }
		removeDynamicInjection( dynamicContextObject.instance );
	}
	
	function forEachContextObjectMember( func )
	{
		local memberClass = null;
		foreach ( name, object in this.getclass() )
		{
			if ( type( object ) == "instance" )
			{
				memberClass = object.getclass();
				foreach ( memberName, memberObject in memberClass )
				{
					func( object, memberName, memberClass.getattributes( memberName ) );
				}
			}
		}
        
        local current = firstDynamicObject;
        while ( current )
        {
            memberClass = current.instance.getclass();
            foreach ( memberName, memberObject in memberClass )
            {
                func( current.instance, memberName, memberClass.getattributes( memberName ) );
            }
            current = current.next;
        }
	}
	
	function performInjection( contextObject, memberName, attributes )
	{
 		if ( attributes != null )
 		{
	 		if ( "Inject" in attributes )
	 		{
		 		if ( "Context" == attributes[ "Inject" ] )
				{
					contextObject[ memberName ] = this;
				}
				else if ( "MessageDispatcher" == attributes[ "Inject" ] )
				{
					contextObject[ memberName ] = this.dispatchMessage.bindenv( this );
				}
		 		else if ( attributes[ "Inject" ] )
				{
					contextObject[ memberName ] = this[ attributes[ "Inject" ] ];
				}
	 		}
 		}
	}
	
	function removeDynamicInjection( contextObject )
	{
 		local memberClass = contextObject.getclass();
        local attributes = null;
        foreach ( memberName, memberObject in memberClass )
        {
            attributes = memberClass.getattributes( memberName );
            if ( attributes != null )
            {
                if ( "Inject" in attributes )
                {
                    contextObject[ memberName ] = null;
                }
            }
        }
	}
}
});