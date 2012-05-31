RequireScript( "/data/game/message/setmenu" );
RequireScript( "/data/game/message/pushmenu" );
RequireScript( "/data/game/message/popmenu" );
RequireScript( "/data/game/message/closemenu" );
RequireScript( "/data/core/entity" );
RequireScript( "/data/game/properties/menurenderer" );

namespace( "game", function()
{
class MenuController
{
    </ Inject = "Context" />
    context = null;
    </ Inject = "updateManager" />
    updateManager = null;
    </ Inject = "guiRenderManager" />
    guiRenderManager = null;
    
    menuStack = null;
    menuEntity = null;
    
    constructor()
    {
        menuStack = [];
    }
    
    </ ContextState = ContextState.INITIALIZE />
    function init()
    {
        menuEntity = core.Entity();
        menuEntity.addProperty( game.MenuRenderer() );
        updateManager.addEntity( menuEntity );
        guiRenderManager.addEntity( menuEntity );
    }
    
    function pushMenu( menu )
    {
        if ( menuStack.len() > 0 )
        {
            context.removeDynamicObject( menuStack.top() );
        }
        menuStack.push( context.addDynamicObject( menu ) );
        menuEntity[ game.SetMenu( menu ) ];
        
    }
    
    function popMenu()
    {
        context.removeDynamicObject( menuStack.pop() );
        if ( menuStack.len() > 0 )
        {
            context.addDynamicObject( menuStack.top() );
            menuEntity[ game.SetMenu( menuStack.top() ) ];
        }
        else
        {
            menuEntity[ game.SetMenu( null ) ];
        }
    }
    
    function changeMenu( menu )
    {
        popMenu();
        pushMenu( menu );
    }
    
    function closeMenu()
    {
        if ( menuStack.len() > 0 )
        {
            context.removeDynamicObject( menuStack.pop() );
            while( menuStack.len() )
            {
                menuStack.pop();
            }
        }
        menuEntity[ game.SetMenu( null ) ];
    }
}

MenuController[ game.PushMenu ] <- function( message )
{
    pushMenu( message.menu );
}

MenuController[ game.PopMenu ] <- function( message )
{
    popMenu();
}

MenuController[ game.CloseMenu ] <- function( message )
{
    closeMenu();
}

});