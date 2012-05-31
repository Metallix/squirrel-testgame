class MyMessage
{
    function toString()
    {
        return "MyMessage";
    }
}

class A
{
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    
    function sendMyMessage()
    {
        dispatcher( MyMessage() );
    }
}

class B
{
    function printMessage( message )
    {
        ::print( message.toString() ); // prints out string representation of MyMessage
    }
}

B[ MyMessage ] <- function( message )
{
    printMessage( message );
}

RequireScript( "/data/core/context" );

class C extends core.Context
{
    a = A();
    b = B();
}

function main(...)
{
    local context = C();
    context.build();
}