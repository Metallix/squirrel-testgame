namespace( "menu", function()
{
class Item
{
    state = null;
    fadeAlpha = null;
    position = null;
    rectangleColor = null;
    selectedRectangleColor = null;
    lineColor = null;
    fadeInProgress = null;
    width = null;
    height = null;
    selected = null;
    adjacentItems = null;
    action = null;
    
    constructor()
    {
        state = State( { INVISIBLE = 0, FADE_IN = 1, IDLE = 2 } );
        state.INVISIBLE.set();
        
        position = Vec2( 0, 0 );
        rectangleColor = CreateColor( 255, 255, 255, 0 );
        selectedRectangleColor = CreateColor( 255, 0, 0, 255 );
        lineColor = CreateColor( 255, 255, 255, 255 );
        
        width = 200;
        height = 30;
        selected = false;
        adjacentItems = {};
    }
    
    function update( t )
    {
        if ( state.FADE_IN.active() )
        {
            fadeInProgress += t * 0.001;
            if ( fadeInProgress >= 1 )
            {
                state.IDLE.set();
                fadeInProgress = 1;
            }
            fadeAlpha = 10 * fadeInProgress;
            rectangleColor = (rectangleColor & 0xFFFFFF00) | fadeAlpha.tointeger();
        }
    }
    
    function render( t )
    {
        if ( state.FADE_IN.active() )
        {
            renderOutline( fadeInProgress );
            
            DrawRect( position.x, position.y, width, height, rectangleColor );
        
        }
        else if ( state.IDLE.active() )
        {            
            DrawRect( position.x, position.y, width, height, selected ? selectedRectangleColor : rectangleColor );
            renderOutline( 1 );
        }
    }
    
    function renderOutline( progress )
    {
        if ( progress >= 1 )
        {
            DrawLine( position.x, position.y, position.x + width, position.y, lineColor );
            DrawLine( position.x + width, position.y, position.x + width, position.y + height + 1, lineColor );
            DrawLine( position.x, position.y + height, position.x + width, position.y + height, lineColor );
            DrawLine( position.x, position.y, position.x, position.y + height, lineColor );
        }
        else
        {
            local u = progress * ( width * 2 + height * 2 );
            if ( u < width )
            {
                DrawLine( position.x, position.y, position.x + u, position.y, lineColor );
            }
            else if ( u < width + height )
            {
                DrawLine( position.x, position.y, position.x + width, position.y, lineColor );
                DrawLine( position.x + width, position.y, position.x + width, position.y + u - width, lineColor );
            }
            else if ( u < width * 2 + height )
            {
                DrawLine( position.x, position.y, position.x + width, position.y, lineColor );
                DrawLine( position.x + width, position.y, position.x + width, position.y + height + 1, lineColor );
                DrawLine( position.x + width - ( u - width - height ), position.y + height, position.x + width, position.y + height, lineColor );
            }
            else
            {
                DrawLine( position.x, position.y, position.x + width, position.y, lineColor );
                DrawLine( position.x + width, position.y, position.x + width, position.y + height + 1, lineColor );
                DrawLine( position.x, position.y + height, position.x + width, position.y + height, lineColor );
                DrawLine( position.x, position.y + height - ( u - width * 2 - height ), position.x, position.y + height, lineColor );
            }
        }
    }
    
    function fadeIn()
    {
        fadeAlpha = 0;
        fadeInProgress = 0;
        state.FADE_IN.set();
    }
}
});