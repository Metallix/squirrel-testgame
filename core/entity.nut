RequireScript( "/data/core/property" );

namespace( "core", function(){	
	class Entity
	{
		properties = null;
		result = null;
				
		constructor()
		{
			properties = [];
		}
		
		function addProperty( property )
		{
            property.entity = this;
			properties.push( property );
		}
		
		function _get( message )
		{
			result = {};
			foreach ( property in properties )
			{
                result[ property.getclass() ] <- property.processMessage( message );
			}
			return result;
		}
	}
});
