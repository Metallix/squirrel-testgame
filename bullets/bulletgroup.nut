RequireScript( "/data/bullets/bullet" );

namespace("bullets", function()
{
class BulletGroup
{
	bullets = null;
	numBullets = null;
	freeBulletIndex = null;
	
	constructor()
	{
		bullets = [];
		numBullets = 0;
		freeBulletIndex = 0;
	}
	
	function addBullet( setup )
	{
        if ( freeBulletIndex == numBullets )
		{
			
            bullets.push( ::bullets.Bullet() );
			numBullets++;
		}
		bullets[ freeBulletIndex ].setup( freeBulletIndex, setup );
		freeBulletIndex++;
	}
	
	function removeBullet( bullet )
	{
		freeBulletIndex--;
		if ( bullet.cacheIndex < freeBulletIndex )
		{
			local store = bullets[ freeBulletIndex ];
			bullets[ freeBulletIndex ] = bullets[ bullet.cacheIndex ];
			bullets[ bullet.cacheIndex ] = store;
			store.cacheIndex = bullet.cacheIndex;
		}
	}
	
    function update( t )
    {
        local bullet;
		for ( local index = 0; index < freeBulletIndex; index++ )
		{
			bullet = bullets[ index ];
            bullet.update( t );
            if ( bullet.lifetime <= 0 )
            {
                removeBullet( bullet );
            }
		}
    }
    
	function render()
	{
        local bullet;
		for ( local index = 0; index < freeBulletIndex; index++ )
		{
			bullet = bullets[ index ];
			bullet.render();
		}
	}
}
});