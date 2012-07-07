RequireScript( "/data/core/properties/position" );
RequireScript( "/data/core/properties/rotation" );
RequireScript( "/data/game/entityfactory" );
RequireScript( "/data/seagame/property/creaturebase" );
RequireScript( "/data/seagame/property/energysphere" );
RequireScript( "/data/game/properties/lazycameraproperty" );
RequireScript( "/data/game/properties/focuscameraproperty" );

namespace( "seagame", function()
{
class SeaEntityFactory extends game.EntityFactory
{
    blueprints =
    {
        PlayerCreature =
        [
            seagame.CreatureBase
            core.Position
            core.Rotation
        ]
        EnergySphere =
        [
            seagame.EnergySphere
            core.Position
        ]
        DynamicCamera = 
        [
            game.LazyCameraProperty
            game.FocusCameraProperty
        ]
    };
}
});