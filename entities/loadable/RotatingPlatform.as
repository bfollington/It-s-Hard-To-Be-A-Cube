package entities.loadable
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import assets.A;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Ease;
	
	import volticpunk.components.Delayer;
	import volticpunk.components.Repeater;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	import volticpunk.util.ImageUtil;
	
	public class RotatingPlatform extends VEntity
	{
		private var sourceCollisionMask: BitmapData;
		private var normalImagePos: Point;
		private var repeater: Repeater;
		private var angle: Number = 0;
		private var transformed: BitmapData;
		private var dim: Number;
		
		public static function create(n:XML, world:World): void
		{
			var e: RotatingPlatform = new RotatingPlatform(n.@x, n.@y, Number(n.@time), n.@type);
			world.add(e);
		}
		
		public function RotatingPlatform(x:Number=0, y:Number=0, time: Number = 2, typeCode: String = "|__")
		{
			super(x, y, null, null );
			
			var typeCodes: Array = ["|__", "__|", "_=_", "____"];
			var images: Array = [A.TetrisL, A.TetrisLAlt, A.TetrisT, A.TetrisLong];
			var shape: int = typeCodes.indexOf(typeCode);
			
			graphic = new Image(images[shape]);
			
			ImageUtil.centerPivotPoint(getImage());
			normalImagePos = new Point(getImage().x, getImage().y);
			
			type = "rotating_platform";
			
			addComponent( repeater =  new Repeater(time, rotate) );
			addComponent( new Tweener(finishedRotating) );
			
			sourceCollisionMask = FP.getBitmap(images[shape]);
			dim = Math.max(sourceCollisionMask.width, sourceCollisionMask.height);
			transformed = new BitmapData(dim, dim, true, 0x00000000);
			mask = new Pixelmask(transformed);
			
			// Initial image config
			rotateBy(0);
		}
		
		override public function added():void
		{
			super.added();
		}
		
		private function rotateBy(deg: Number): void
		{
			var pm: Pixelmask = mask as Pixelmask;
			var data: BitmapData = sourceCollisionMask;
			
			var widthDiff: Number = (dim - data.width) / 2;
			var heightDiff: Number = (dim - data.height) / 2;
			
			var matrix: Matrix = new Matrix();
			matrix.translate(-data.width / 2, -data.height / 2);
			matrix.rotate(deg * Math.PI / 180);
			matrix.translate(data.width / 2 + widthDiff, data.height / 2 + heightDiff);
			
			transformed.draw(data, matrix);
			(mask as Pixelmask).data = transformed;
			(mask as Pixelmask).x = -widthDiff;
			(mask as Pixelmask).y = -heightDiff;
		}
		
		private function rotate(): void
		{
			type = "deadly";
			getTweener().tween( graphic, {angle: (graphic as Image).angle + 90 }, 0.4, Ease.bounceOut);
			angle += 90;
		}
		
		override public function update():void
		{
			super.update();
			rotateBy(-angle);
			
			if (getTweener().isActive())
			{
				getImage().color = 0xFF0000;
			} else {
				getImage().color = 0xFFFFFF;
			}
			
			if (repeater.getExpirationPercent() > 0.75)
			{
				getImage().x = normalImagePos.x + Math.random() * 2 * repeater.getExpirationPercent();
				getImage().y = normalImagePos.y + Math.random() * 2 * repeater.getExpirationPercent();
				
				if (!getTweener().isActive())
				{
					getImage().angle = angle + ((Math.random() * 5) - 2.5) * repeater.getExpirationPercent();
				}
				
				getImage().color = 0xFF8888;
				
			} else {
				if (!getTweener().isActive())
				{
					getImage().angle = angle;
				}
				
				getImage().x = normalImagePos.x;
				getImage().y = normalImagePos.y;
			}
		}
		
		private function finishedRotating(): void
		{
			type = "rotating_platform";
		}
	}
}