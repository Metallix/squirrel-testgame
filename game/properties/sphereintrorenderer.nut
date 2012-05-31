RequireScript( "/data/core/property" );
RequireScript( "/data/core/message/render" );
RequireScript( "/data/game/message/setsphereintroprogress" );

namespace( "properties", function()
{
class SphereIntroRenderer extends core.Property
{
	color = null;
	scale = 0;
	scaleDecrease = 0.0;
	phase = 0.3;
	speed = 0.01;
	progress = null;
	
	sphere = null;
	
	generateParticles = null;
	particles = null;
	
	introProgress = 0;
	
	constructor()
	{
		color = CreateColor(255,0,255);
		progress = 0;
	}

	function renderSegments( time )
	{
		scale -= time * scaleDecrease;
		if ( scale <= 0 )
		{
			scale = 0;
		}
		
		progress += time;
		local prevVal = 0;
		local currVal = 0;
		for ( local index = 1; index < 160; index ++ )
		{
			currVal = Math.sin( progress * speed + index * phase ) * scale * Math.sin( 3.14 * index / 160 );
			DrawLine( 160 + ( index - 1 ) * 2, 240 + prevVal, 160 + index * 2, 240 + currVal, color );
			prevVal = currVal;
		}
	}
	
	function renderSphereText()
	{
		renderCenteredText("Sphere 2.0");
	}
	
	function renderTechDemoText()
	{
		renderCenteredText("Tech Demo");
	}
	
	function renderPressButtonText()
	{
		renderCenteredText("Press Space");
	}
	
	function renderCenteredText( text ) 
	{
		local font = Game.getSystemFont();
		font.drawString(320 - font.getStringWidth(text) / 2, 250, text);
	}
}

SphereIntroRenderer[ core.Render ] <- function( message )
{
	switch ( introProgress )
	{
		case 1: renderSphereText(); break;
		case 2: renderTechDemoText(); break;
		case 3: renderPressButtonText(); break;
	}
	renderSegments( message.time );
}

SphereIntroRenderer[ message.SetSphereIntroProgress ] <- function( message )
{
	introProgress = message.progress;
}
});