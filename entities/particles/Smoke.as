package entities.particles
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	import volticpunk.components.LifespanComponent;
	import volticpunk.entities.VEntity;
	import volticpunk.util.ImageUtil;
	
	public class Smoke extends VEntity
	{
		private var velocity: Point;
		private var spin: Number;
		private var lifespan: LifespanComponent;
		
		public function Smoke(x: Number = 0, y: Number = 0)
		{
			super(x, y, Image.createRect(8, 8, 0xFF999999));
			
			ImageUtil.setPivotPoint(graphic as Image, new Point(4, 4));
			init(x, y);
			lifespan = addComponent( new LifespanComponent(1, false, done) ) as LifespanComponent;
		}
		
		override public function added():void
		{
			super.added();
			
			lifespan.reset();
		}
		
		public function init(x, y): void
		{
			this.x = x;
			this.y = y;
			(graphic as Image).angle = 0;
			(graphic as Image).scale = 1;
			
			velocity = new Point(Math.random() * 1 - 0.5, Math.random() * -0.5);
			spin = Math.random() * 10 - 5;
			
			layer = C.LAYER_BACKGROUND;
		}
		
		private function done(e: Entity): void
		{			
			room.recycle(this);
		}
		
		override public function update():void
		{
			super.update();
			
			x += velocity.x;
			y += velocity.y;
			(graphic as Image).angle += spin;
			(graphic as Image).scale = lifespan.getRemainingPercent();
		}
	}
}