package entities
{
	import flash.geom.Point;
	
	import assets.A;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.components.Delayer;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	import volticpunk.util.ImageUtil;
	import volticpunk.worlds.Room;
	
	public class Spike extends VEntity
	{
		private var speed: Number;
		private var delayer: Delayer;
		private var movement: Point;
		
		public static function create(n: XML, world: World): void
		{
			var spike: Spike = new Spike(n.@x, n.@y, n.@compass_direction, n.@speed);
			world.add(spike);
		}
		
		public function Spike(x:Number=0, y:Number=0, compassDirection: String="north", speed: Number = 2)
		{
			super(x, y, new Image(A.Spike), new Hitbox(8, 8, 4, 4) );
			type = "spike";
			
			var rotations: Object = {
				"north" : 0,
				"east" : 270,
				"south" : 180,
				"west" : 90
			};
			
			var horizontal: Object = {
				"north" : 0,
				"east" : -16,
				"south" : 0,
				"west" : 16
			};
			
			var vertical: Object = {
				"north" : 16,
				"east" : 0,
				"south" : -16,
				"west" : 0
			};
			
			this.speed = Math.abs(speed);
			layer = C.LAYER_BACKGROUND;
			movement = new Point(horizontal[compassDirection], vertical[compassDirection]);
			
			delayer = new Delayer(this.speed, toggle, false);
			if (speed < 0)
			{
				delayer.forceTime(speed);
			}
			
			if (speed != 0) addComponent(delayer);
			
			addComponent(new Tweener());
			
			ImageUtil.setPivotPoint(getImage(), new Point(8, 8));
			getImage().angle = rotations[compassDirection];
		}
		
		private function toggle(parent: Entity): void
		{
			delayer.reset(false);
			
			getTweener().tween(parent, {x: parent.x + movement.x, y: parent.y + movement.y}, 0.5);
			movement.x = -movement.x;
			movement.y = -movement.y;
		}
		
		override public function update():void
		{
			super.update();
			
			var player: Player = collide("player", x, y) as Player;
			
			if (player && !player.isDashing())
			{
				player.kill();
			}
		}
	}
}