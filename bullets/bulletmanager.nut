RequireScript( "/data/bullets/bulletgroup" );

namespace("bullets", function()
{
class BulletManager
{
	bulletGroups = null;
	
	constructor()
	{
		bulletGroups = {};
	}
	
	function addGroup( groupId )
	{
		bulletGroups[ groupId ] <- bullets.BulletGroup();
	}
	
	function removeGroup( groupId )
	{
		delete bulletGroups[ groupId ];
	}
	
	function addBullet( groupId, setup )
	{
        bulletGroups[ groupId ].addBullet( setup );
	}
	
	function render()
	{
		foreach( group in bulletGroups )
		{
            group.render();
		}
	}
    
    function update( t )
    {
        foreach( group in bulletGroups )
		{
            group.update( t );
		}
    }
}
});