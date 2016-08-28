package;

import kha.Assets;
import kha.Color;
import kha.graphics2.Graphics;

class Button
{
	var x:Float;
	var y:Float;
	var tx:Float;
	var ty:Float;
	var text:String;
	
	public function new(x:Float, y:Float, text:String):Void 
	{
		this.x = x;
		this.y = y;
		this.text = text;
		
		tx = x + 50 - (Assets.fonts.Intro.width(28, text) / 2);
		ty = y + 13 - (Assets.fonts.Intro.height(28) / 2);
	}
	
	public function click(px:Float, py:Float):Bool
	{
		if (px > x && px < (x + 100) && py > y && py < (y + 26))
			return true;
		else
			return false;
	}
	
	public function render(g:Graphics):Void
	{
		g.color = 0xfffab91e;
		g.fillRect(x, y, 100, 26);
		g.color = Color.Black;
		g.drawString(text, tx, ty);
	}
}