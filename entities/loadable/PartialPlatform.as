package entities.loadable
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.entities.VEntity;
	
	public class PartialPlatform extends VEntity
	{
		public static function create(n:XML, world:World): void
		{
			var e: PartialPlatform = new PartialPlatform(n.@x, n.@y);
			world.add(e);
		}
		
		public function PartialPlatform(x:Number=0, y:Number=0)
		{
			super(x, y, Image.createRect(16, 16), new Hitbox(16, 16));
			
			this.type = "level";
		}
		
		override public function update():void
		{
			if (Meebles.getPlayer().isDashing())
			{
				this.collidable = false;
			} else {
				this.collidable = true;
			}
		}
	}
}