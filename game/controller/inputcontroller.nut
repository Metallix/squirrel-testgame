RequireScript( "/data/game/message/keydown" );
RequireScript( "/data/game/message/keyup" );

enum InputKeys
{
    LEFT,
    RIGHT,
    UP,
    DOWN,
    OK
}

namespace( "game", function()
{

class InputController
{
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    
    pressed = {};
    
    </ ContextState = ContextState.INITIALIZE />
    function init()
    {
        registerKeyHandler();
    }
    
    function registerKeyHandler()
    {
        Kbd.space.onPress = function() { this.onPress( InputKeys.OK ) }.bindenv( this );
        Kbd.left.onPress = function() { this.onPress( InputKeys.LEFT ) }.bindenv( this );
        Kbd.right.onPress = function() { this.onPress( InputKeys.RIGHT ) }.bindenv( this );
        Kbd.up.onPress = function() { this.onPress( InputKeys.UP ) }.bindenv( this );
        Kbd.down.onPress = function() { this.onPress( InputKeys.DOWN ) }.bindenv( this );
        
        Kbd.space.onRelease = function() { this.onRelease( InputKeys.OK ) }.bindenv( this );
        Kbd.left.onRelease = function() { this.onRelease( InputKeys.LEFT ) }.bindenv( this );
        Kbd.right.onRelease = function() { this.onRelease( InputKeys.RIGHT ) }.bindenv( this );
        Kbd.up.onRelease = function() { this.onRelease( InputKeys.UP ) }.bindenv( this );
        Kbd.down.onRelease = function() { this.onRelease( InputKeys.DOWN ) }.bindenv( this );
    }
    
    function onPress( key )
    {
        if ( !( key in pressed ) ) pressed[ key ] <- false;
        if ( !pressed[ key ] )
        {
            pressed[ key ] = true;
            dispatcher( game.KeyDown( key ) );
        }
    }
    
    function onRelease( key )
    {
        dispatcher( game.KeyUp( key ) );
        pressed[ key ] = false;
    }
}
});