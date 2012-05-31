RequireScript("/data/core/utils/debuglog");

class State
{
    currentState = null;
    states = null;
    
    constructor( states )
    {
        this.states = {};
        foreach ( idx, val in states )
        {
            this.states[ idx ] <- { idx = idx, val = val, stateObject = this };
        }
    }
    
    function _get( idx )
    {
        if ( states[ idx ] )
        {
            return { set = set.bindenv( states[ idx ] ), active = active.bindenv( states[ idx ] ) }
        }
        else throw null;
    }
    
    function set()
    {
        this.stateObject.currentState = this.idx;
    }
    
    function active()
    {
        return this.idx == this.stateObject.currentState;
    }
}