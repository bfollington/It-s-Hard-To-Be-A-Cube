package entities.loadable
{
	import flash.geom.Point;
	
	import entities.Player;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.V;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	
	public class RoofFaller extends VEntity
	{
		private var fall: Boolean = false;
		private var initialY: Number;
		private var speed: int;
		private var shouldRespond: Boolean = true;
		
		public static function create(n:XML, world:World): void
		{
			var e: RoofFaller = new RoofFaller(n.@x, n.@y, n.@speed);
			world.add(e);
		}
		
		public function RoofFaller(x:Number=0, y:Number=0, speed:int = 3)
		{
			super(x, y, Image.createCircle(8), new Hitbox(10, 10, 3, 3));
			this.initialY = y;
			this.speed = speed;
			var tweener: Tweener = addComponent( new Tweener() ) as Tweener;
			tweener.setCallback(backOnRoof);
		}
		
		private function backOnRoof(): void
		{
			active = true;
		}
		
		private function kill(): void
		{	
			var tweener: Tweener = lookup("tweener") as Tweener;
			tweener.tween(this, {y: initialY}, 0.5);
			shouldRespond = false;
			fall = false;
		}
		
		override public function update():void
		{
			super.update();
			
			if (shouldRespond)
			{
				
				if (Meebles.getPlayer().x - 5 < (x + 8) && Meebles.getPlayer().x + 5 > (x + 8) )
				{
					fall = true;
				}
				
				if (speed == 0)
				{
					y += 3;	
				}
				
				if (fall && speed > 0)
				{
					y += speed;
				}
				
				var player: Player = collide("player", x, y) as Player;
				if (player && !player.isDead())
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