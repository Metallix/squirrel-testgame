function error( msg )
{
    local level = 1;
    local infos = null;
    
    msg = "Error: " + msg + "\nin\n";
    
    while ( infos = getstackinfos( ++level ) )
    {        
        msg += infos.src + " (" + infos.line + ") : " + infos.func + "\n";
    }
    
    throw msg;
}