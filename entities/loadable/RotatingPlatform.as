package entities.loadable
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import volticpunk.entities.VEntity;
	
	public class RotatingPlatform extends VEntity
	{
		public function RotatingPlatform(x:Number=0, y:Number=0)
		{
			super(x, y, Image.createRect(32, 16, 0xFFFF0000), new Hitbox(32, 16));
		}
	}
}