namespace("math", function()
{
class Matrix33
{
    m11 = null; m21 = null; m31 = null;
    m12 = null; m22 = null; m32 = null;
    m13 = null; m23 = null; m33 = null;
    
    constructor( m11 = 0, m21 = 0, m31 = 0, m12 = 0, m22 = 0, m32 = 0, m13 = 0, m23 = 0, m33 = 0 )
    {
        this.m11 = m11;
        this.m21 = m21;
        this.m31 = m31;
        
        this.m12 = m12;
        this.m22 = m22;
        this.m23 = m23;
        
        this.m13 = m13;
        this.m32 = m32;
        this.m33 = m33;
    }
    
    function set( m )
    {
        this.m11 = m.m11;
        this.m21 = m.m21;
        this.m31 = m.m31;
        
        this.m12 = m.m12;
        this.m22 = m.m22;
        this.m23 = m.m23;
        
        this.m13 = m.m13;
        this.m32 = m.m32;
        this.m33 = m.m33;
        
        return this;
    }
    
    function identity()
    {
        m11 = 1; m21 = 0; m31 = 0;
        m12 = 0; m22 = 1; m32 = 0;
        m13 = 0; m23 = 0; m33 = 1;
        return this;
    }
    
    function translate( x = 0, y = 0 )
    {
        return set( this * math.Matrix33(
            1, 0, x,
            0, 1, y,
            0, 0, 1
            ) );
    }
    
    function setTranslation( x = 0, y = 0 )
    {
        m31 = x;
        m32 = y;
    }
    
    function rotate( angle )
    {
        return set( this * math.Matrix33(
              Math.cos( angle ), Math.sin( angle ), 0,
            - Math.sin( angle ), Math.cos( angle ), 0,
                              0,                 0, 1
            ) );
    }
    
    function setRotation( angle )
    {
        m11 = Math.cos( angle );
        m21 = Math.sin( angle );
        m12 = - Math.sin( angle );
        m22 = Math.cos( angle );
    }
    
    function scale( x = 1, y = 1 )
    {
        return set( this * math.Matrix33(
            x, 0, 0,
            0, y, 0,
            0, 0, 1
            ) );
    }
    
    function setScale( x = 1, y = 1, z = 1 )
    {
        m11 = x;
        m22 = y;
        m33 = z;
    }
    
    function shear( x = 0, y = 0 )
    {
        return set( this * math.Matrix33(
            1, x, 0,
            0, 1, 0,
            0, 0, 1
            )
        * math.Matrix33(
            1, 0, 0,
            y, 1, 0,
            0, 0, 1
            ) );
    }
    
    function toString()
    {
        return "" +
            m11 + ", " + m21 + ", " + m31 + "\n" +
            m12 + ", " + m22 + ", " + m32 + "\n" +
            m13 + ", " + m23 + ", " + m33 + "\n";
    }
    
    function _mul( m )
    {
        return math.Matrix33(
            m11 * m.m11 + m21 * m.m12 + m31 * m.m13,
            m11 * m.m21 + m21 * m.m22 + m31 * m.m23,
            m11 * m.m31 + m21 * m.m32 + m31 * m.m33,
            
            m12 * m.m11 + m22 * m.m12 + m32 * m.m13,
            m12 * m.m21 + m22 * m.m22 + m32 * m.m23,
            m12 * m.m31 + m22 * m.m32 + m32 * m.m33
            
            m13 * m.m11 + m23 * m.m12 + m33 * m.m13,
            m13 * m.m21 + m23 * m.m22 + m33 * m.m23,
            m13 * m.m31 + m23 * m.m32 + m33 * m.m33
        );
    }
}

Vec2.transform <- function( matrix )
{
    return Vec2(
        matrix.m11 * x + matrix.m21 * y + matrix.m31,
        matrix.m12 * x + matrix.m22 * y + matrix.m32
    );
}

});