package entities
{
	import flash.geom.Point;
	
	import entities.particles.Smoke;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	
	import volticpunk.V;
	import volticpunk.components.Delayer;
	import volticpunk.components.PlatformerMovement;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	import volticpunk.entities.util.Delayer;
	import volticpunk.util.ImageUtil;
	
	public class Player extends VEntity
	{
		private var move: PlatformerMovement;
		private var direction: int = C.RIGHT;
		private var canDash: Boolean = true;
		private var dashedLastFrame: Boolean = false;
		private var dashedUpLastFrame: Boolean = false;
		private var delayer: volticpunk.components.Delayer;
		
		private var dead: Boolean = false;
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			ImageUtil.setPivotPoint(getImage(), new Point( getImage().width / 2, getImage().height / 2) );
			
			move = new PlatformerMovement();
			move.setLandingCallback(landed);
			
			addComponent(move, "move");
			addComponent(new Tweener());
			var tweener: Tweener = addComponent(new Tweener(), "spin_back_tween") as Tweener;
			tweener.setCallback( resetAngle );
			
			delayer = addComponent( new volticpunk.components.Delayer(0.6, resetDash, false) ) as volticpunk.components.Delayer;
			delayer.pause();
			
			getImage().smooth = false;
			
			type = "player";
		}
		
		private function resetDash(parent: Entity): void
		{
			canDash = true;
			delayer.reset(true);
		}
		
		private function resetAngle(): void
		{
			getImage().angle = 0;
		}
		
		private function landed(): void
		{
			getImage().scaleY = 1.0 - (move.velocity.y / 10.0) ;
			getImage().angle = 0;
			getImage().y += 4;
			
			for (var i: int = 0; i < 5; i ++)
			{
				V.getRoom().add( new Smoke(x, y + 8) );
			}
			
			
			if (!getTweener().isActive()) getTweener().tween(getImage(), {scaleY: 1, y: getImage().y - 4}, 0.3, Ease.bounceOut);
		}
		
		private function dash(): void
		{
			var dash: Number = 50;
			var xDashed: Boolean = false;
			var yDashed: Boolean = false;
			dashedLastFrame = true;
			canDash = false;
			delayer.unpause();
			
			var anyKey: Boolean = Input.check("Left") || Input.check("Right") || Input.check("Up") || Input.check("Down");
			
			if (Input.check("Left") || (!anyKey && move.velocity.x < 0) || (!anyKey && direction == C.LEFT) )
			{
				move.velocity.x = -(dash + 14);
				xDashed = true;
			} else if (Input.check("Right") || (!anyKey && move.velocity.x > 0) || (!anyKey && direction == C.RIGHT) )
			{
				move.velocity.x = dash + 14;	
				xDashed = true;
			}
			
			if (Input.check("Up"))
			{
				move.velocity.y = -dash;
				dashedUpLastFrame = true;
				yDashed = true;
			} else if (Input.check("Down"))
			{
				move.velocity.y = dash;
				yDashed = true;
			}
			
			if (xDashed && !yDashed)
			{
				move.velocity.y = 0;
			}
			
			if (!xDashed && yDashed)
			{
				move.velocity.x = 0;
			}
			
			V.getRoom().add( new Smoke(x, y + 8) );
			V.getRoom().add( new Smoke(x, y + 8) );
			V.getRoom().add( new Smoke(x, y + 8) );
		}
		
		public function kill(): void
		{
			if (!dead)
			{
				visible = false;
				move.freezeMovement = true;
				
				V.getRoom().add( new Smoke(x, y + 8) );
				V.getRoom().add( new Smoke(x, y + 8) );
				V.getRoom().add( new Smoke(x, y + 8) );
				V.getRoom().add( new Smoke(x, y + 8) );
				V.getRoom().add( new Smoke(x, y + 8) );
				
				V.getRoom().add( new volticpunk.entities.util.Delayer(1, (V.getRoom() as Level).reset) );
				dead = true;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (dead) return;
			
			if (collideTypes(C.COLLISION_TYPES, x, y))
			{
				kill();
			}
			
			if (dashedLastFrame)
			{
				dashedLastFrame = false;
				move.velocity.x = 0;
				
				if (!dashedUpLastFrame)
				{
					move.velocity.y = 0;
				} else {
					move.velocity.y = -2;
					dashedUpLastFrame = false;
				}
			}
			
			getImage().angle -= move.velocity.x * 9;
			if (move.velocity.x != 0 && move.onGround)
			{
				if (Math.random() < 0.1)
				{
					V.getRoom().add( new Smoke(x, y + 8) );
				}
			}
			
			// No control above level
			if (y > 0)
			{
				if (Input.check("Left"))
				{
					move.velocity.x = -2;	
					direction = C.LEFT;
				} else if (Input.check("Right"))
				{
					move.velocity.x = 2;	
					direction = C.RIGHT;
				}
				
				if (Input.pressed("Dash") && canDash)
				{
					dash();
				}
				
				if (!Input.check("Left") && !Input.check("Right") && !Input.check("Jump"))
				{
					var tweener: Tweener = lookup("spin_back_tween") as Tweener;
					if (!tweener.isActive()) tweener.tween(getImage(), {angle: getImage().angle - getImage().angle % 90}, 0.1);
				}
				
				if (Input.pressed("Jump") && move.onGround)
				{
					move.velocity.y = -4;	
				}
			}
			
			if (y > room.levelHeight - 16)
			{
				kill();
			}
		}
	}
}