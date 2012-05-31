function DrawTexturedQuad( texture, tx1, ty1, tx2, ty2, tx3, ty3, tx4, ty4, x1, y1, x2, y2, x3, y3, x4, y4 )
{
	DrawTexturedTriangle( texture, tx1, ty1, tx2, ty2, tx4, ty4, x1, y1, x2, y2, x4, y4 );
	DrawTexturedTriangle( texture, tx2, ty2, tx3, ty3, tx4, ty4, x2, y2, x3, y3, x4, y4 );
}