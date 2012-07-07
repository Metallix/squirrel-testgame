RequireScript("/common/scripts/game");
RequireScript("/common/scripts/cache");
RequireScript("/data/error");
RequireScript("/data/assert");
RequireScript("/data/namespace");
RequireScript("/data/state");
RequireScript("/data/core/context");
RequireScript("/data/seagame/context/seagamecontext");


function Game::init(args) {
    
    Game.setWindowMode( 640, 480, false);
	Game.setFrameRate( 60 );

	local context = seagame.SeaGameContext();
	context.build();
}