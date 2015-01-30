package entities.loadable
{
	import assets.A;
	
	import entities.Player;
	
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.components.Delayer;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	
	public class FallingPlatform extends VEntity
	{
		private var timer: Number;
		
		public static function create(n:XML, world:World): void
		{
			var e: FallingPlatform = new FallingPlatform(n.@x, n.@y, n.@timer);
			world.add(e);
		}
		
		public function FallingPlatform(x:Number=0, y:Number=0, timer: Number = 0.5)
		{
			super(x, y, new Image(A.FallingPlatform), new Hitbox(16, 16) );
			this.timer = timer;
			type = C.DEFAULT_COLLISION_TYPE;
			addComponent( new Tweener() );
		}
		
		private function startFall(): void
		{
			addComponent( new Delayer(timer, fall) );
			getTweener().tween(this.graphic, {alpha: 0}, timer);
		}
		
		override public function update():void
		{
			super.update();
			var player: Player = collide("player", x, y - 1) as Player;
			
			if (player)
			{
				startFall();	
			}
		}
		
		private function fall(e: Entity): void
		{
			room.remove(this);
		}
	}
}