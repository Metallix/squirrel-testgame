RequireScript("/common/scripts/game");
RequireScript("/common/scripts/cache");
RequireScript("/data/error");
RequireScript("/data/assert");
RequireScript("/data/namespace");
RequireScript("/data/state");
RequireScript("/data/core/context");
RequireScript("/data/game/gamecontext");


function Game::init(args) {
    
    Game.setWindowMode( 640, 480, false);
	Game.setFrameRate( 60 );

	local context = game.GameContext();
	context.build();
}