package entities.loadable
{
	import flash.geom.Point;
	
	import entities.Player;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.V;
	import volticpunk.entities.VEntity;
	
	public class RoofFaller extends VEntity
	{
		private var fall: Boolean = false;
		
		public static function create(n:XML, world:World): void
		{
			var e: RoofFaller = new RoofFaller(n.@x, n.@y);
			world.add(e);
		}
		
		public function RoofFaller(x:Number=0, y:Number=0)
		{
			super(x, y, Image.createCircle(8), new Hitbox(16, 16));
		}
		
		private function kill(): void
		{
			V.getRoom().remove(this);
		}
		
		override public function update():void
		{
			super.update();
			
			if (Meebles.getPlayer().x - 2 < x && Meebles.getPlayer().x + 2 > x)
			{
				fall = true;
			}
			
			if (fall)
			{
				y += 3;
				
				var player: Player = collide("player", x, y) as Player;
				if (player)
				{
					player.kill();
					kill();
				}
				
				if (collideTypes(C.COLLISION_TYPES, x, y))
				{
					kill();
				}
			}
		}
	}
}