package entities.loadable
{
	import flash.geom.Point;
	
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
		private var speed: Number = 70;
		private var target: Point;
		private var targetIndex: int = 0;
		private var nodes: Vector.<Point>;
		private var active: Boolean;
		private var needsPlayer: Boolean;
		private var lastPos: Point;
		
		public static function create(n: XML, world: World): void
		{
			var nodeList:Vector.<Point> = new Vector.<Point>();
			
			for each (var t:XML in n.node)
			{
				nodeList.push(new Point(t.@x, t.@y));
			}
			
			var platform: MovingPlatform = new MovingPlatform(n.@x, n.@y, nodeList, n.@active == "True", n.@needsPlayerToMove == "True");
			world.add(platform);
		}
		
		public function MovingPlatform(x:Number, y:Number, nodes: Vector.<Point>, active: Boolean = false, needsPlayer: Boolean = true)
		{
			super(x, y, Image.createRect(32, 16), new Hitbox(32, 16));
			
			this.nodes = nodes;
			target = nodes[targetIndex];
			
			this.active = active;
			this.needsPlayer = needsPlayer;
			addComponent( new Tweener() );
			getTweener().setCallback(moveToNode);
			moveToNode();
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
				player.x = x + (player.x - lastPos.x);
				player.y = y - player.height; 
				
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
				targetIndex = 0;
			}
			
			target = nodes[targetIndex];
			var distance: Number = distanceToPoint(target.x, target.y);
			
			
			getTweener().tween(this, {x: target.x, y: target.y}, distance / speed);
		}
	}
}