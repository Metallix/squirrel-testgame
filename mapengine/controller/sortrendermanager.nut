RequireScript("/data/mapengine/message/getrenderinfo");
RequireScript("/data/mapengine/properties/mapentity");
RequireScript("/data/core/message/render");

namespace( "controller", function()
{
class SortRenderManager
{
	getRenderInfo = message.GetRenderInfo();
	renderTreeRoot = null;
	renderMessage = null;
	
	constructor()
	{
		renderMessage = core.Render( 0 );
	}

	function addEntity( entity )
	{
		entity.addProperty( properties.MapEntity() );
		addEntityToTree( entity, getValue( entity ) );
	}
	
	function render( t )
	{
		validateRenderTree();
		renderMessage.time = t;
		if ( renderTreeRoot ) renderNode( renderTreeRoot );
	}
	
	function renderNode( n )
	{
		if ( n.before ) renderNode( n.before );
		n.entity[ renderMessage ];
		if ( n.after ) renderNode( n.after );
	}
	
	
	function validateRenderTree()
	{
		local n = renderTreeRoot;
		local list = [];
		
		while( n && hasChanged( n.entity ) )
		{
			list.push( n.entity );
			n = removeNode( n );
		}
		
		if ( n )
		{
			getInvalidNodes( n, list );
		}

		foreach ( e in list )
		{
			addEntityToTree( e, getValue( e ) );
		}
	}
	
	function getInvalidNodes( n, list )
	{
		while ( n )
		{
			if( n.before && hasChanged( n.before.entity ) )
			{
				list.push( n.before.entity );
				n.before = removeNode( n.before );
			}
			else if( n.after && hasChanged( n.after.entity ) )
			{
				list.push( n.after.entity );
				n.after = removeNode( n.after );
			}
			else
			{
				if ( n.before ) getInvalidNodes( n.before, list );
				if ( n.after ) getInvalidNodes( n.after, list );
				n = null;
			}
		}
	}
	
	function removeNode( c )
	{
		local o = null;
		local n = null;
		if ( c.before )
		{
			o = c.before;
			n = o;
			while( n.after )
			{
				n = n.after;
			}
			n.after = c.after;
		}
		else if ( c.after )
		{
			o = c.after;
			n = o;
			while( n.before )
			{
				n = n.before;
			}
			n.before = c.before;
		}
		return o;
	}
	
	function addEntityToTree( e, ri )
	{
		if ( !renderTreeRoot )
		{
			renderTreeRoot = controller.RenderTreeNode();
			renderTreeRoot.entity = e;
			renderTreeRoot.renderIndex = ri;
		}
		else
		{
			local n = renderTreeRoot;
			local c = null;
			while( !c )
			{
				if ( n.renderIndex > ri )
				{
					if ( !n.before )
					{
						c = n.before = controller.RenderTreeNode();
					}
					n = n.before;
				}
				else
				{
					if ( !n.after )
					{
						c = n.after = controller.RenderTreeNode();
					}
					n = n.after;
				}
			}
			c.entity = e;
			c.renderIndex = ri;
		}
	}
	
	function hasChanged( entity )
	{
		return false;
	}
	
	function getValue( entity )
	{
		return 0;
	}
}

class RenderTreeNode
{
	entity = null;
	renderIndex = null;
	before = null;
	after = null;
}
});