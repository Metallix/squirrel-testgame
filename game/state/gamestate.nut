namespace("state", function()
{
class GameState
{
	function onCreate()
	{
		// override in subclass
	}
    
    function onBecomeActive()
	{
		// override in subclass
	}
	
	function update( t )
	{
		// override in subclass 
	}
	
	function onResignActive()
	{
		// override in subclass
	}
    
    function onDestroy()
	{
		// override in subclass
	}
}
});