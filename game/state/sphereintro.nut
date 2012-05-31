RequireScript( "/data/game/state/gamestate" );
RequireScript( "/data/game/message/addtriggeractivator" );
RequireScript( "/data/game/message/addtriggercallback" );
RequireScript( "/data/game/message/setsphereintroprogress" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/game/model/spriteset" );
RequireScript( "/data/game/properties/playerinput" );
RequireScript( "/data/mapengine/message/startmapengine" );

namespace( "state", function()
{
class SphereIntro extends GameState
{
	</ Inject = "MessageDispatcher" />
	dispatch = null;
	</ Inject = "renderManager" />
	renderManager = null;
	</ Inject = "updateManager" />
	updateManager = null;
	</ Inject = "gameEntityFactory" />
	gameEntityFactory = null;
	
	logo = null;
	namida = null;
	trigger = null;
	progressTime = 0;
	progressStep = 0;
	testlist = null;
	
	function onBecomeActive()
	{
		testlist = [];
		
		//addTestPlayer();
		//addTestPlayer();
		//addTestPlayer();
		//addTestPlayer();
		//addTestPlayer();
		
		logo = gameEntityFactory.createEntity( "SphereIntro" );
		
		// namida = gameEntityFactory.createEntity( "Player" );
		// local spriteset = model.SpriteSet();
		// spriteset.createFromImage( Canvas.FromFile( "/data/resources/image/namida.png"), 32, 64 );
		// namida[ game.SetSpriteset( spriteset ) ];
		
		// trigger = gameEntityFactory.createEntity( "Trigger" );
		// spriteset = model.SpriteSet();
		// spriteset.createFromImage( Canvas.FromFile( "/data/resources/image/trigger.png"), 32, 32 );
		// trigger[ game.SetSpriteset( spriteset ) ];
		// trigger[ game.AddTriggerActivator( namida ) ];
		// trigger[ game.AddTriggerCallback( game.TRIGGER_UPDATE, handleTrigger.bindenv(this) ) ];
		
		// renderManager.addEntity( logo );
		// renderManager.addEntity( namida );
	 	// updateManager.addEntity( namida );
	 	// renderManager.addEntity( trigger );
	 	// updateManager.addEntity( trigger );
		
		dispatch( message.StartMapEngine() );
	}
	
	function addTestPlayer()
	{
		local e = null;
		local s = null;
		e = gameEntityFactory.createEntity( "Player" );
		s = model.SpriteSet();
		s.createFromImage( Cache.canvas( "/data/resources/image/namida.png"), 32, 64 );
		e[ game.SetSpriteset( s ) ];
		testlist.push( e );
		renderManager.addEntity( e );
 		updateManager.addEntity( e );
 		e[ message.SetMapPosition( Math.randf() * GetWindowWidth(), Math.randf() * GetWindowHeight(), 0 ) ];
	}
	
	function onResignActive()
	{
		renderManager.removeEntity( logo );
		renderManager.removeEntity( namida );
		updateManager.removeEntity( namida );
		renderManager.removeEntity( trigger );
		updateManager.removeEntity( trigger );
	}
	
	function update( t )
	{
		if ( Kbd.g.pressed )
		{
			addTestPlayer();
		}
		
		updateProgress( t );
	}
	
	function updateProgress( t )
	{
		progressTime += t;
		switch ( progressStep )
		{
			case 0: if ( progressTime > 3000 ) logo[ message.SetSphereIntroProgress( ++progressStep ) ]; break;
			case 1: if ( progressTime > 6000 ) logo[ message.SetSphereIntroProgress( ++progressStep ) ]; break;
			case 2: if ( progressTime > 9000 ) logo[ message.SetSphereIntroProgress( ++progressStep ) ]; break;
			case 3:
			{ 
				if ( Kbd.space.pressed )
				{
					logo[ message.SetSphereIntroProgress( ++progressStep ) ];
					gotoNextState();
				}
				break;
			}
		}
	}
	
	function gotoNextState()
	{
	}
	
	function handleTrigger( entity )
	{
	}
}
});