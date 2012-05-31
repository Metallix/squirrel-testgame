function assert( condition, message )
{
    if ( !condition ) error( "Assertion failed: " + message );
}