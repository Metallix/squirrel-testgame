RequireScript( "/data/game/menu/menu" );
RequireScript( "/data/game/controller/inputcontroller" );
RequireScript( "/data/game/menu/components/item" );
RequireScript( "/data/game/message/pushmenu" );
RequireScript( "/data/game/menu/selecttargetmenu" );

namespace( "game", function()
{

class ChooseBattleActionMenu extends game.Menu
{    
    static INTRO_MAX_TIME = 1000.0;
    
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    
    state = null;
    player = null;
    targets = null;
    
    introTime = null;
    
    colorLine = CreateColor( 255, 255, 255 );
    
    selectedItem = null;
    menuItemList = null;
    selectTargetItem = null;
    
    constructor( player, targets )
    {
        state = State( { START = 0, INTRO = 1, MENU = 2 } );
        state.START.set();
        this.targets = targets;
        this.player = player;
        createItems();
    }
    
    function update( t )
    {
        if ( state.START.active() )
        {
            startIntro();
        }
        else if ( state.INTRO.active() )
        {
            introTime += t;
            if ( introTime >= INTRO_MAX_TIME )
            {
                startMenu();
            }
        }
        
        local index = 0;
        local length = menuItemList.len();
        for( index = 0; index < length; index++ )
        {
            menuItemList[ index ].update( t );
        }
        selectTargetItem.update( t );
    }
    
    function render( t, cm )
    {
        if ( state.INTRO.active() )
        {
            renderIntro( t, cm );
        }
        else if ( state.MENU.active() )
        {
            renderMenu( t, cm );
        }
    }
    
    function renderIntro( t, cm )
    {
        renderMenu( t, cm, introTime / INTRO_MAX_TIME );
    }
    
    function renderMenu( t, cm, progress = 1.0 )
    {
        DrawLine( 0, 100, 640 * progress, 100, colorLine );
        DrawLine( 640 * ( 1 - progress ) , 380, 640, 380, colorLine );
        
        local index = 0;
        local length = menuItemList.len();
        for( index = 0; index < length; index++ )
        {
            if ( progress > 0.25 && menuItemList[ index ].state.INVISIBLE.active() )
            {
                menuItemList[ index ].fadeIn();
                selectTargetItem.fadeIn();
            }
            menuItemList[ index ].render( t );
        }
        
        selectTargetItem.render( t );
    }
    
    function startIntro()
    {
        introTime = 0;
        state.INTRO.set();
    }
    
    function startMenu()
    {
        state.MENU.set();
        selectedItem = menuItemList[ 0 ];
        selectedItem.selected = true;
    }
    
    function createItems()
    {    
        local list = player[ game.GetBattleActionList() ][ game.BattleEntity ];
        local index = 0;
        local length = list.len();
        local currentMenuItem = null;
        local previousMenuItem = null;
        local nextMenuItem = null;
        
        menuItemList = [];
        for ( index = 0; index < length; index++ )
        {
            nextMenuItem = menu.Item();
            if ( currentMenuItem )
            {
                currentMenuItem.adjacentItems[ getconsttable().InputKeys.DOWN ] <- nextMenuItem;
            }
            currentMenuItem = nextMenuItem;
            currentMenuItem.position.x = 200 + index * 5;
            currentMenuItem.position.y = 300 + index * 40;
            if ( previousMenuItem )
            {
                currentMenuItem.adjacentItems[ getconsttable().InputKeys.UP ] <- previousMenuItem;
            }
            menuItemList.push( currentMenuItem )
            currentMenuItem.action = list[ index ];            
            previousMenuItem = currentMenuItem;
        }
        
        selectTargetItem = menu.Item();
        selectTargetItem.position.x = 200;
        selectTargetItem.position.y = 100;
        selectTargetItem.adjacentItems[ getconsttable().InputKeys.DOWN ] <- menuItemList[0];
        menuItemList[0].adjacentItems[ getconsttable().InputKeys.UP ] <- selectTargetItem;
        
    }
}

ChooseBattleActionMenu[ game.KeyDown ] <- function( message )
{   
    if ( state.MENU.active() )
    {
        if (  message.key in selectedItem.adjacentItems )
        {
            selectedItem.selected = false;
            selectedItem = selectedItem.adjacentItems[ message.key ];
            selectedItem.selected = true;
        }
        else if ( message.key == getconsttable().InputKeys.OK )
        {
            if ( selectedItem == selectTargetItem )
            {
                dispatcher( game.PushMenu( game.SelectTargetMenu( targets, player, null ) ) );
            }
            else
            {
                player[ game.SetBattleAction( selectedItem.action ) ];
                dispatcher( game.BattleMenuClosed() );
                dispatcher( game.CloseMenu() );
            }
            // if ( selectedItem.action.requiresTarget() )
            // {
                // dispatcher( game.PushMenu( game.SelectTargetMenu( targets, player, selectedItem.action ) ) );
            // }
            // else
            // {
                // player[ game.SetBattleAction( selectedItem.action ) ];
                // dispatcher( game.BattleMenuClosed() );
                // dispatcher( game.CloseMenu() );
            // }
        }
    }
}

});

