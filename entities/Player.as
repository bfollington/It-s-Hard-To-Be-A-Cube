package entities
{
	import flash.geom.Point;
	
	import assets.A;
	
	import entities.particles.Smoke;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	
	import rooms.Level;
	
	import volticpunk.V;
	import volticpunk.components.Delayer;
	import volticpunk.components.PlatformerMovement;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	import volticpunk.entities.util.Delayer;
	import volticpunk.util.ImageUtil;
	import volticpunk.util.NumberUtil;
	
	public class Player extends VEntity
	{
		private var move: PlatformerMovement;
		private var direction: int = C.RIGHT;
		private var canDash: Boolean = true;
		private var dashedLastFrame: Boolean = false;
		private var dashedUpLastFrame: Boolean = false;
		private var delayer: volticpunk.components.Delayer;
		
		private const DASH: Number = 64;
		private var xDashed: Boolean = false;
		private var yDashed: Boolean = false;
		private var xToMove: Number = 0;
		private var yToMove: Number = 0;
		
		private var dead: Boolean = false;
		private var jumping: Boolean = false;
		private var easyJump: Number = 0;
		private var hasPressedJump: Boolean = false;
		
		private var paused: Boolean = true;
		
		public function Player(x:Number=0, y:Number=0)
		{
			super(x, y, A.PlayerImage, new Hitbox(16, 14, 0, 2) );
			
			ImageUtil.setPivotPoint(getImage(), new Point( getImage().width / 2, getImage().height / 2) );
			
			move = new PlatformerMovement(null, null, new Point(2, 5), false);
			move.setLandingCallback(landed);
			
			addComponent(move, "move");
			addComponent(new Tweener(null, true));
			var tweener: Tweener = addComponent(new Tweener(null, true), "spin_back_tween") as Tweener;
			tweener.setCallback( resetAngle );
			
			delayer = addComponent( new volticpunk.components.Delayer(42, resetDash, false, true) ) as volticpunk.components.Delayer;
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
		
		override public function added():void
		{
			super.added();
		}
		
		private function landed(): void
		{
			getImage().scaleY = 0.6;
			getImage().angle = 0;
			getImage().y += 4;
			jumping = false;
			
			for (var i: int = 0; i < 5; i ++)
			{
				addSmoke();
			}
			
			A.LANDSound.play(Meebles.getVolume());
			
			if (!getTweener().isActive()) getTweener().tween(getImage(), {scaleY: 1, y: getImage().y - 4}, 18, Ease.bounceOut);
		}
		
		private function dash(): void
		{
			dashedLastFrame = true;
			canDash = false;
			delayer.unpause();
			
			xDashed = false;
			yDashed = false;
			xToMove = 0;
			yToMove = 0;
			
			
			var anyKey: Boolean = Input.check("Left") || Input.check("Right") || Input.check("Up") || Input.check("Down");
			
			if (Input.check("Up"))
			{
				yToMove = -DASH;
				dashedUpLastFrame = true;
				yDashed = true;
			} else if (Input.check("Down"))
			{
				yToMove = DASH;
				yDashed = true;
			} else if (Input.check("Left") || (!anyKey && move.velocity.x < 0) || (!anyKey && direction == C.LEFT) )
			{
				xToMove = -DASH;
				xDashed = true;
			} else if (Input.check("Right") || (!anyKey && move.velocity.x > 0) || (!anyKey && direction == C.RIGHT) )
			{
				xToMove = DASH;	
				xDashed = true;
			} 
			
			jumping = true;
			move.onGround = false;
			addSmoke();
			addSmoke();
			addSmoke();
			A.DASHSound.play(Meebles.getVolume());
		}
		
		public function pause(): void
		{
			paused = true;
		}
		
		public function unpause(): void
		{
			paused = false;
		}
		
		private function addSmoke(): void
		{
			var e: Smoke = (room.create(Smoke) as Smoke)
			e.init(x, y + 8);
		}
		
		public function kill(): void
		{
			if (!dead)
			{
				visible = false;
				move.freezeMovement = true;
				
				addSmoke();
				addSmoke();
				addSmoke();
				addSmoke();
				addSmoke();
				
				V.getRoom().add( new volticpunk.entities.util.Delayer(1, (V.getRoom() as Level).reset) );
				dead = true;
				A.DIESound.play(Meebles.getVolume());
			}
		}
		
		private function dashing(): void
		{
			dashedLastFrame = true;
			move.velocity.y = 0;
			move.velocity.x = 0;
			
			for (var i: int = 0; i < 8; i++)
			{
				if (xToMove != 0)
				{
					if (collideTypes(C.COLLISION_TYPES, x + NumberUtil.sign(xToMove), y))
					{
						xToMove = 0;
						break;	
					}
					x += NumberUtil.sign(xToMove);
					xToMove -= NumberUtil.sign(xToMove);
				}
				
				if (yToMove != 0)
				{
					if (collideTypes(C.COLLISION_TYPES, x, y + NumberUtil.sign(yToMove)))
					{
						if (yToMove > 0)
						{
							move.onGround = true;
						}
						
						yToMove = 0;
						break;
					}
					
					if (NumberUtil.sign(yToMove) < 0)
					{
						dashedUpLastFrame = true;
					}
					
					y += NumberUtil.sign(yToMove);
					yToMove -= NumberUtil.sign(yToMove);
				}
			}
		}
		
		public function isDashing(): Boolean
		{
			return (xToMove != 0 || yToMove != 0);
		}
		
		public function isDead(): Boolean
		{
			return dead;
		}
		
		override public function update():void
		{
			super.update();
			
			if (dead) return;
			
			if (!paused)
			{
				if (collide("deadly", x, y))
				{
					kill();
				}
				
				if (collideTypes(C.COLLISION_TYPES, x, y))
				{
					kill();
				}
				
				if (isDashing())
				{
					dashing();
				}
				
				if (!isDashing() && dashedLastFrame)
				{
					dashedLastFrame = false;
					jumping = false;
					move.velocity.x = 0;
					
					if (!dashedUpLastFrame)
					{
						move.velocity.y = 0;
					} else {
						move.velocity.y = -2;
						dashedUpLastFrame = false;
					}
					
					// move.resetFallDistance();
				}
				
				getImage().angle -= move.velocity.x * 9;
				if (move.velocity.x != 0 && move.onGround)
				{
					if (Math.random() < 0.1)
					{
						addSmoke();
					}
				}
				
				if (Input.check("Left"))
				{
					move.acceleration.x = -0.5;	
					direction = C.LEFT;
				} else if (Input.check("Right"))
				{
					move.acceleration.x = 0.5;	
					direction = C.RIGHT;
				} else {
					move.acceleration.x = 0;
				}
				
				if (y > 0)
				{
					if (Input.pressed("Dash") && canDash && !isDashing())
					{
						dash();
					}
				}
				
				if (!Input.check("Left") && !Input.check("Right") && !Input.check("Jump"))
				{
					var tweener: Tweener = lookup("spin_back_tween") as Tweener;
					if (!tweener.isActive()) tweener.tween(getImage(), {angle: getImage().angle - getImage().angle % 90}, 6);
				}
				
				if (Input.check("Jump") && y > 0)
				{	
					
					if (!hasPressedJump && !collideTypes(C.COLLISION_TYPES, x, y - 3) && ( collideTypes(C.COLLISION_TYPES, x, y + 5) || ( !jumping && easyJump > 0 ) ))
					{
						move.velocity.y = -4;	
						A.JUMPSound.play(Meebles.getVolume());
						jumping = true;
					}
					
					hasPressedJump = true;
				} else {
					hasPressedJump = false;
				}
				
				if (move.onGround)
				{
					easyJump = 0.08;
				} else {
					easyJump -= FP.elapsed;
				}
			}
			
			if (y > room.levelHeight - 16)
			{
				kill();
			}
			
			if (x > room.levelWidth)
			{
				var saveKey: String = (room as Level).getCode() + "_best_time";
				var oldTime: Number = Number( Data.readString(saveKey, "0") );
				var time: Number = Meebles.getTimer().getTime();
				var timeString: String = time.toFixed(2).toString();
				var newBestTime: Boolean = false;
				
				if (time < oldTime || oldTime == 0)
				{
					Data.writeString(saveKey, timeString);
					Data.save("meebles");
					trace("NEW BEST TIME!!!");
					newBestTime = true;
				}
				
				V.getRoom().add( new EndOfLevelPopup(116, 80, newBestTime, oldTime, time) );
				getPlatformMovement().freezeMovement = true;
				(room as Level).getTimer().stop();
				dead = true;
			}
		}
	}
}