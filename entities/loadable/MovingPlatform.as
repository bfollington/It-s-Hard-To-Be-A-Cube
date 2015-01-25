package entities.loadable
{
	import flash.geom.Point;
	
	import assets.A;
	
	import entities.Player;
	import entities.Spike;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	
	public class MovingPlatform extends VEntity
	{
		private var speed: Number = 64;
		private var target: Point;
		private var targetIndex: int = 0;
		private var nodes: Vector.<Point>;
		private var active: Boolean;
		private var needsPlayer: Boolean;
		private var lastPos: Point;
		private var repeat: Boolean;
		
		public static function create(n: XML, world: World): void
		{
			var nodeList:Vector.<Point> = new Vector.<Point>();
			
			nodeList.push(new Point(n.@x, n.@y));
			
			for each (var t:XML in n.node)
			{
				nodeList.push(new Point(t.@x, t.@y));
			}
			
			var platform: MovingPlatform = new MovingPlatform(n.@x, n.@y, nodeList, n.@active == "True", n.@needsPlayerToMove == "True", n.@speed);
			world.add(platform);
		}
		
		public function MovingPlatform(x:Number, y:Number, nodes: Vector.<Point>, active: Boolean = false, needsPlayer: Boolean = true, speed: Number = 64, repeat: Boolean = false)
		{
			super(x, y, A.MovingPlatformImage, new Hitbox(32, 16));
			
			this.nodes = nodes;
			target = nodes[targetIndex];
			
			this.active = active;
			this.needsPlayer = needsPlayer;
			this.repeat = repeat;
			this.speed = speed;
			addComponent( new Tweener() );
			getTweener().setCallback(moveToNode);
			moveToNode();
			if (!active) getTweener().pause();
			lastPos = new Point(x, y);
			
			type = "moving_platform";
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (!active)
			{
				getTweener().pause();
			} else {
				getTweener().unpause();
			}
			
			var player: Player = collide("player", x, y - 2) as Player;
			
			if (player)
			{
				var newX: Number = x + (player.x - lastPos.x);
				var newY: Number = y + (player.y - lastPos.y); 
				
				if (!player.collideTypes(C.COLLISION_TYPES, newX, newY))
				{
					player.x = newX;
					player.y = newY;
				}
				
				
				active = true;
			} else {
				if (needsPlayer)
				{
					active = false;
				}
			}
			
			lastPos.x = x;
			lastPos.y = y;
		}
		
		private function moveToNode(): void
		{
			targetIndex++;
			
			if (targetIndex >= nodes.length)
			{
				if (repeat)
				{
					targetIndex = 0;	
				} else {
					return;
				}
				
			}
			
			target = nodes[targetIndex];
			var distance: Number = distanceToPoint(target.x, target.y);
			
			
			getTweener().tween(this, {x: target.x, y: target.y}, distance / speed);
		}
	}
}