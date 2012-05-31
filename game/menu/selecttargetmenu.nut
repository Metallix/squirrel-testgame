RequireScript( "/data/game/menu/menu" );
RequireScript( "/data/core/utils/debuglog" );
RequireScript( "/data/game/message/keyup" );
RequireScript( "/data/game/controller/inputcontroller" );
RequireScript( "/data/game/menu/menu" );
RequireScript( "/data/core/properties/position" );
RequireScript( "/data/core/message/getposition" );
RequireScript( "/data/game/message/keydown" );

namespace( "game", function()
{

class SelectTargetMenu extends game.Menu
{
    targetEntities = null;    
    selectedData = null;
    action = null;
    player = null;
    
    </ Inject = "Context" />
    context = null;
    </ Inject = "MessageDispatcher" />
    dispatcher = null;
    
    constructor( acceptedTargetEntities, player, action )
    {
        targetEntities = acceptedTargetEntities;
        selectIndex( 0 );
        this.action = action;
        this.player = player;
    }
    
    function selectIndex( index )
    {
        selectedData = 
        {
			entity = targetEntities[ index ],
			index = index
        }
    }
    
    function update( t )
    {
    }
    
    function render( t, cm )
    {
        if ( selectedData )
        {
            local screenPosition = selectedData.entity[ core.GetPosition() ][ core.Position ].transform( cm );
            DrawRect( screenPosition.x, screenPosition.y, 200, 200, CreateColor( 255, 255, 0 ) );
        }
    }
}

SelectTargetMenu[ game.KeyDown ] <- function( message )
{   
    switch( message.key )
    {
        case getconsttable().InputKeys.LEFT:
            selectIndex( ++selectedData.index % targetEntities.len() );
            break;
        case getconsttable().InputKeys.RIGHT:
            selectIndex( ( --selectedData.index + targetEntities.len() ) % targetEntities.len() );
            break;
        case getconsttable().InputKeys.OK:
            player[ game.AddAction( selectedItem.action ) ];
            dispatcher( game.BattleMenuClosed() );
            dispatcher( game.CloseMenu() );
            break;
    }
}

});