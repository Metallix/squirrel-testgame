namespace("core", function(){
	
	class Property
	{		
		entity = null;
		
		function processMessage( message )
		{
            if ( typeof message == "instance" )
            {            
                local messageClass = message.getclass();
                if ( messageClass in this )
                {
                    return this[ messageClass ]( message );
                }
                return null;
            }
            else error( "processMessage was called with " + message + ", but requires a valid message instance." );
		}
	}
	
});
