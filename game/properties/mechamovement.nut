RequireScript( "/data/core/properties/contextproperty" );
RequireScript( "/data/core/properties/position" );
RequireScript( "/data/core/message/getposition" );
RequireScript( "/data/core/message/setposition" );
RequireScript( "/data/core/message/setrotation" );
RequireScript( "/data/core/message/update" );
RequireScript( "/data/core/message/renderdebug" );
RequireScript( "/data/game/message/setmechatarget" );
RequireScript( "/data/game/message/firemecharangeweapon" );


namespace( "game", function()
{

enum MECHA_MOVEMENT_STATE
{
    NORMAL,
    SPEED_STEP,
    ATTACK,
    SPEED_ATTACK
}

class MechaMovementSettings
{
    normalSpeed = 0.3;
    approachSpeed = 0.5;
    speedStepDelay = 200;
    speedStepDistance = 200;
    speedStepActiveTime = 100.0;
    
    maxInfightDistance = 100;
    maxSpeedAttackDistance = 500;
    minTargetDistance = 50;
}

class MechaMovement extends core.ContextProperty
{
    </ Inject = "sharedData" />
    sharedData = null;
    
    
    settings = MechaMovementSettings();
    state = MECHA_MOVEMENT_STATE.NORMAL;
    
    gotInput = false;
    gotLeft = false;
    gotRight = false;
    leftPressed = false;
    rightPressed = false;
    attackPressed = false;
    directionHandler = {};
    
    target = null;
    targetVector = Vec2( 0, 0 );
    tangentVector = Vec2( 0, 0 );
    targetPosition = null;
    targetDistance = null;
    
    speedStepTriggerTimerLeft = 0;
    speedStepTriggerTimerRight = 0;
    speedStepActiveTimer = 0;
    speedAttackTimer = 0;
    
    speedStepStart = Vec2( 0, 0 );
    speedStepVector = Vec2( 0, 0 );
    
    
    mechaPosition = null;
    
    constructor()
    {
        directionHandler[ Kbd.left ] <- null;
        directionHandler[ Kbd.right ] <- null;
        directionHandler[ Kbd.up ] <- null;
        directionHandler[ Kbd.down ] <- null;
    }
    
    function checkInput( t )
    {
        if ( MECHA_MOVEMENT_STATE.NORMAL == state )
        {
            if ( target )
            {
                gotInput = false;
                gotLeft = false;
                gotRight = false;
                
                handleDirectionKey( Kbd.left, targetPosition.y, mechaPosition.y, t );
                handleDirectionKey( Kbd.right, mechaPosition.y, targetPosition.y, t );
                handleDirectionKey( Kbd.down, targetPosition.x, mechaPosition.x, t );
                handleDirectionKey( Kbd.up, mechaPosition.x, targetPosition.x, t );
                
                if ( Kbd.space.pressed )
                {
                    moveToTarget( t );
                }
                if ( Kbd.ctrl.pressed )
                {
                    moveFromTarget( t );
                }
                if ( Kbd.alt.pressed )
                {
                    attackTarget( !attackPressed );
                    attackPressed = true;
                }
                else
                {
                    attackPressed = false;
                }
                leftPressed = gotLeft;
                rightPressed = gotRight;
            }
            
            
            /*
            if ( Kbd.left.pressed )
            {
                leftPressed = true;
                speedStepTriggerTimerRight = 0;
                steerLeft();
            }
            else
            {
                if ( leftPressed )
                {
                    leftPressed = false;
                    speedStepTriggerTimerLeft = settings.speedStepDelay;
                }
            }
            
            if ( Kbd.right.pressed )
            {
                rightPressed = true;
                speedStepTriggerTimerLeft = 0;
                steerRight();
            }
            else
            {
                if ( rightPressed )
                {
                    rightPressed = false;
                    speedStepTriggerTimerRight = settings.speedStepDelay;
                }
            }
            
            if ( Kbd.space.pressed )
            {
                attackTarget( !attackPressed );
                attackPressed = true;
            }
            else
            {
                if ( attackPressed )
                {
                    attackPressed = false;
                }
            }*/
        }
        // if ( Kbd.ctrl.pressed )
        // {
            // moveFromTarget();
        // }
    }
    
    function handleDirectionKey( key, compareValueA, compareValueB, t )
    {
        if ( key.pressed )
        {
            if ( !directionHandler[ key ] )
            {
                if ( compareValueA > compareValueB )
                {
                    directionHandler[ key ] = handleLeft.bindenv(this);
                }
                else
                {
                    directionHandler[ key ] = handleRight.bindenv(this);
                }
            }
            directionHandler[ key ]( t );
        }
        else
        {
            directionHandler[ key ] = null;
        }
    }
    
    function handleLeft( t )
    {
        if ( !gotInput )
        {
            gotInput = true;
            gotLeft = true;
            steerLeft( t );
        }
    }
    
    function handleRight( t )
    {
        if ( !gotInput )
        {
            gotInput = true;
            gotRight = true;
            steerRight( t );
        }
    }
    
    function steerLeft( t )
    {
        speedStepTriggerTimerRight = 0;
        if ( !leftPressed )
        {
            if ( speedStepTriggerTimerLeft > 0 )
            {
                speedStepTo( mechaPosition - tangentVector * settings.speedStepDistance );
                speedStepTriggerTimerLeft = 0;
            }
            else
            {
                speedStepTriggerTimerLeft = settings.speedStepDelay;
            }
        }
        else
        {
            mechaPosition -= tangentVector * settings.normalSpeed * t;
            entity[ core.SetPosition( mechaPosition.x, mechaPosition.y ) ];
        }
    }
    
    function steerRight( t )
    {
        speedStepTriggerTimerLeft = 0;
        if ( !rightPressed )
        {
            if ( speedStepTriggerTimerRight > 0 )
            {
                speedStepTo( mechaPosition + tangentVector * settings.speedStepDistance );
                speedStepTriggerTimerRight = 0;
            }
            else
            {
                speedStepTriggerTimerRight = settings.speedStepDelay;
            }
        }
        else
        {
            mechaPosition += tangentVector * settings.normalSpeed * t;
            entity[ core.SetPosition( mechaPosition.x, mechaPosition.y ) ];
        }
    }
    
    function speedStepTo( position )
    {
        state = MECHA_MOVEMENT_STATE.SPEED_STEP;
        speedStepStart.x = mechaPosition.x;
        speedStepStart.y = mechaPosition.y;
        speedStepVector.x = position.x - mechaPosition.x;
        speedStepVector.y = position.y - mechaPosition.y;
        speedStepActiveTimer = settings.speedStepActiveTime;
    }
    
    function speedAttack()
    {
        state = MECHA_MOVEMENT_STATE.SPEED_ATTACK;
    }
    
    function infightAttack()
    {
        state = MECHA_MOVEMENT_STATE.ATTACK;
    }
    
    function rangeAttack()
    {
        entity[ game.FireMechaRangeWeapon() ];
    }
    
    function attackTarget( init )
    {
        if ( init && targetDistance < settings.maxInfightDistance )
        {
            // trigger infight weapon
            infightAttack();
        }
        else if ( init && speedAttackTimer > 0 && targetDistance < settings.maxSpeedAttackDistance )
        {
            // trigger speed attack with infight weapon
            speedAttack();
        }
        else
        {
            speedAttackTimer = settings.speedStepDelay;
            rangeAttack();
        }
    }
    
    function moveToTarget( t )
    {
        if ( target && targetDistance > settings.minTargetDistance )
        {
            mechaPosition += targetVector * settings.approachSpeed * t;
            entity[ core.SetPosition( mechaPosition.x, mechaPosition.y ) ];
        }
    }
    
    function moveFromTarget( t )
    {
        mechaPosition -= targetVector * 2 * t;
        entity[ core.SetPosition( mechaPosition.x, mechaPosition.y ) ];
    }
    
    function updateTargetData()
    {
        if ( target )
        {
            targetPosition = target[ core.GetPosition() ][ core.Position ];
            mechaPosition = entity[ core.GetPosition() ][ core.Position ];
            targetVector = targetPosition - mechaPosition;
            targetDistance = targetVector.getLength();
            targetVector.normalize();
            tangentVector.x = targetVector.y;
            tangentVector.y = -targetVector.x;
            
            entity[ core.SetRotation( 270 - targetVector.getAngle() ) ];
        }
    }
    
    function updatePosition( t )
    {
        if ( MECHA_MOVEMENT_STATE.SPEED_STEP == state )
        {
            if ( speedStepActiveTimer <= 0 )
            {
                speedStepActiveTimer = 0;
                state = MECHA_MOVEMENT_STATE.NORMAL;
            }
            mechaPosition = speedStepStart + speedStepVector * (( settings.speedStepActiveTime - speedStepActiveTimer ) / settings.speedStepActiveTime );
            entity[ core.SetPosition( mechaPosition.x, mechaPosition.y ) ];
        }
    }
    
    function updateTimers( t )
    {
        if ( speedStepTriggerTimerLeft > 0 ) speedStepTriggerTimerLeft -= t;
        if ( speedStepTriggerTimerRight > 0 ) speedStepTriggerTimerRight -= t;
        if ( speedStepActiveTimer > 0 ) speedStepActiveTimer -= t;
        if ( speedAttackTimer > 0 ) speedAttackTimer -= t;
    }
}

MechaMovement[ game.SetMechaTarget ] <- function( message )
{
    target = message.target;
}

MechaMovement[ core.Update ] <- function ( message )
{
    updateTimers( message.time );
    updateTargetData();
    checkInput( message.time );
    updatePosition( message.time );
    
    sharedData.time <- message.time;
}

MechaMovement[ core.RenderDebug ] <- function ( message )
{
    if ( target )
    {
        DrawLine( mechaPosition.x, mechaPosition.y, targetPosition.x, targetPosition.y, CreateColor( 255, 0, 0) );
        Game.getSystemFont().drawString( target ? "" + targetDistance : "<NT>", mechaPosition.x, mechaPosition.y );
    }
}

});