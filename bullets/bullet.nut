namespace("bullets", function()
{
class BulletSetup
{
	position = null;
	velocity = null;
	acceleration = null;
	texture = null;
    lifetime = null;
}	

class Bullet
{
	cacheIndex = null;
	
	position = null;
	velocity = null;
	acceleration = null;
	texture = null;
    lifetime = null;
	
	function setup( cacheIndex, bulletSetup )
	{
		this.cacheIndex = cacheIndex;
		
		texture = bulletSetup.texture;
		position = bulletSetup.position;
		velocity = bulletSetup.velocity;
		acceleration = bulletSetup.acceleration;
        lifetime = bulletSetup.lifetime;
	}
	
    function update( t )
    {
        velocity += acceleration;
        position += velocity;
        lifetime -= t;
    }
    
	function render()
	{
		DrawImage( texture, position.x, position.y );
	}
}
});