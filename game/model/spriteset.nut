RequireScript( "/data/core/utils/math/matrix33" );

namespace( "model" ,function()
{
class SpriteSet
{
	
	modes = null;
	currentMode = 0;
	currentFrame = 0;
	time = 0;
    rotation = 0;
    position = Vec2( 0, 0 );
    pivot = Vec2( 0, 0 );
	
	windowWidth = GetWindowWidth();
	windowHeight = GetWindowHeight();
    
    matrix = null;
    frameWidth = 0;
    frameHeight = 0;
    
    p1 = null;
    p2 = null;
    p3 = null;
    p4 = null;
	
	constructor()
	{
		modes = [];
        matrix = math.Matrix33();
        updateMatrix();
	}
	
    function setPosition( position )
    {
        this.position = position;
        updateMatrix();
    }
    
    function setRotation( rotation )
    {
        this.rotation = rotation * Math.PI / 180;
        updateMatrix();
    }
    
    function setPivot( pivot )
    {
        this.pivot = pivot;
        updateMatrix();
    }
    
    function updateMatrix()
    {
        matrix.identity()
            .translate( position.x, position.y )
            .rotate( rotation )
            .translate( -pivot.x, -pivot.y )
            
    }
    
	function createFromImage( image, frameWidth, frameHeight )
	{
		this.frameWidth = frameWidth;
        this.frameHeight = frameHeight;
        local currentFrame = null;
		local x = 0;
		local y = 0;
		local currentMode = null;
		while( y < image.height )
		{
			currentMode = [];
			this.modes.push( currentMode );
			x = 0;
			while( x < image.width )
			{
				currentMode.push( Texture.FromCanvas( image.cloneSection( Rect( x, y, frameWidth, frameHeight ) ) ) );
				x+=frameWidth;
			}
			y+=frameHeight;
		}
	}
	
	function reset()
	{
		currentFrame = 0;
		time = 0;
	}
	
	function animate()
	{
		currentFrame = ( time / 150 ) % modes[ currentMode ].len();
	}
	
	function render( t, m )
	{
		time += t;
        
        local w = frameWidth;
		local h = frameHeight;
        p1 = Vec2( 0, 0 ).transform( m * matrix );
        p2 = Vec2( w, 0 ).transform( m * matrix );
        p3 = Vec2( w, h ).transform( m * matrix );
        p4 = Vec2( 0, h ).transform( m * matrix );
        
		drawFrame( modes[ currentMode ][ currentFrame ] );
	}
	
	function drawFrame( texture )
	{
		local w = texture.width;
		local h = texture.height;
		if ( position.x > -w && position.x < windowWidth && position.y > -h && position.y < windowHeight )
		{
			drawFramePart( texture, 0, 0, w, h );
		}
	}
	
	function drawFramePart( texture, tx, ty, w, h )
	{       
        DrawTexturedTriangle(
			texture,
			tx    , ty,
			tx + w, ty,
			tx    , ty + h,
			p1.x  , p1.y,
			p2.x  , p2.y,
			p4.x  , p4.y );
		DrawTexturedTriangle(
			texture,
			tx + w, ty,
			tx + w, ty + h,
			tx    , ty + h,
			p2.x  , p2.y,
			p3.x  , p3.y,
			p4.x  , p4.y );
	}
}
});