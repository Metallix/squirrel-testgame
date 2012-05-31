RequireScript( "/data/core/entity" );
RequireScript( "/data/core/properties/position" );
RequireScript( "/data/core/properties/rotation" );
RequireScript( "/data/core/properties/inputtest" );
RequireScript( "/data/core/properties/image" );
RequireScript( "/data/core/properties/dispatcher" );
RequireScript( "/data/game/properties/sphereintrorenderer" );
RequireScript( "/data/game/properties/playerinput" );
RequireScript( "/data/game/properties/spritesetcontroller" );
RequireScript( "/data/game/properties/triggercontroller" );
RequireScript( "/data/game/properties/mechamovement" );
RequireScript( "/data/game/properties/mecharangeweaponslot" );
RequireScript( "/data/game/properties/battleentity" );
RequireScript( "/data/game/properties/lazycameraproperty" );
RequireScript( "/data/game/properties/focuscameraproperty" );

RequireScript( "/data/bullets/properties/bulletrenderer" );

namespace( "game", function()
{
class EntityFactory
{
	blueprints =
	{
        SphereIntro =
		[
			properties.SphereIntroRenderer
		]
		PlayerShip =
		[
			core.Position
            core.Rotation
            game.BattleEntity
            //game.MechaMovement
            //game.MechaRangeWeaponSlot
            game.SpritesetController
		]
        EnemyShip =
		[
			core.Position
			//core.InputTest,
			core.Image
		]
		Player =
		[
			core.Position
			game.SpritesetController
		]
        BattleCamera = 
        [
            game.LazyCameraProperty,
            game.FocusCameraProperty
        ]
		Trigger = 
		[
			core.Position
			game.TriggerController
		]
		Bullets =
		[
			bullets.BulletRenderer
		]
	};
	
	function createEntity( name )
	{
		local entity = null;
		if ( name in blueprints )
		{
			entity = core.Entity();
			foreach( property in blueprints[ name ] )
			{
				entity.addProperty( property() );
			}
		}
        else error( "Tried to create entity of unknown name." );
		return entity;
	}
}
});