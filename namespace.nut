function namespace( namespace, func )
{
	local split = function ( namespace, char )
	{
		local tokens = [];
		local idx = 0;
		local nextIdx = namespace.find( char );
		while( nextIdx )
		{
			tokens.push( namespace.slice( idx, nextIdx ) );
			idx = nextIdx + 1;
			nextIdx = namespace.find( char, idx );
		}
		tokens.push( namespace.slice( idx ) );
		return tokens;
	}
	
	if ( typeof( namespace ) == "string" )
	{
		local chunks = split( namespace, "." );
		local node = getroottable();
		foreach ( c in chunks )
		{
			if ( !( c in node) )
			{
				node[ c ] <- {};
			}
			node = node[ c ];
		}
		if ( typeof( func ) == "function" )
		{
			func.bindenv(node)();
		}
	}
	else if ( typeof( namespace ) == "table" && typeof( func ) == "function" )
	{
		func.bindenv( namespace )();
	}
}

getroottable()._get <- function( idx ){ return idx };