package rooms
{
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import assets.A;
	
	import entities.EdgeOfScreen;
	import entities.Player;
	import entities.Timer;
	import entities.loadable.RotatingPlatform;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import volticpunk.V;
	import volticpunk.components.Delayer;
	import volticpunk.entities.util.Delayer;
	import volticpunk.util.StringManipulation;
	import volticpunk.util.XMLUtil;
	import volticpunk.worlds.CollisionLayer;
	import volticpunk.worlds.LookupDictionary;
	import volticpunk.worlds.Room;
	import volticpunk.worlds.TileLayer;
	
	public class Level extends Room
	{
		private var tilesetDict: Dictionary;
		private var levelCode: String;
		private var timer: Timer;
		
		[Embed(source = '/assets/levels/meebles.oep', mimeType = 'application/octet-stream')] public static const Project:Class;
		
		public function Level(levelCode: String)
		{
			super();
			
			this.levelCode = levelCode;
			extractTilesetInfo(XMLUtil.loadXml(Project));
		}
		
		/**
		 * Read the project file and build a map of tilset names to file names 
		 * @param projectXml
		 * 
		 */		
		private function extractTilesetInfo(projectXml: XML): void
		{
			tilesetDict = new Dictionary();
			
			for each (var n: XML in projectXml.Tilesets.Tileset) 
			{
				var name: String = n.Name;
				var file: String = n.FilePath;
				// Strip off the file location
				file = file.replace("..\\", "");
				file = file.replace(".png", "");
				file = StringManipulation.formatFilename(file);
				
				tilesetDict[name] = file;
			}
		}
		
		/**
		 * Retrieve the tileset for the given name.
		 * @param s Tileset name
		 * 
		 */		
		private function getTileset(s: String): Class
		{
			var tileset: Class = A.TILES[tilesetDict[s]];
			
			if (tileset == null)
			{
				throw new Error("You seem to be using an unknown tileset, " +
					"try rebuilding assets. Tilesets must have 'tile' " +
					"in their name. Alternatively, this could be due to " +
					"the level you're loading missing a layer");
			}
			
			return tileset;
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.M))
			{
				Meebles.toggleMute();
			}
			
			if (Input.pressed(Key.Q))
			{
				V.changeRoom( new Menu() );
			}
			
			if (Input.pressed(Key.R))
			{
				reset();
			}

//			if (Input.mousePressed)
//			{
//				Meebles.getPlayer().x = FP.camera.x + Input.mouseX;
//				Meebles.getPlayer().y = FP.camera.y + Input.mouseY;
//			}
		}
		
		public function nextLevel(): void
		{
			V.changeRoom( new Level( C.LETTERS[C.LETTERS.indexOf(levelCode) + 1] ) );	
		}
		
		public function reset(): void
		{
			V.changeRoom(new Level( C.LETTERS[C.LETTERS.indexOf(levelCode)]));
		}
		
		public function getCode(): String
		{
			return levelCode;
		}
		
		public function getTimer(): Timer
		{
			return timer;
		}
		
		public function startLevel(e: Entity = null): void
		{
			Meebles.getPlayer().unpause();
			timer.start();
		}
		
		override public function begin(): void
		{
			super.begin();
			
			disableDarknessOverlay();
			var map: XML;
			
			var count: int = 0;
			
			map = XMLUtil.loadXml(A.LEVELS[levelCode]);
			
			levelWidth = map.@width;
			levelHeight = map.@height;
			
			var collisionLayer: CollisionLayer = new CollisionLayer(map, A.CollisionTiles, map.Collision);
			var e: Entity;
			
			// Extend the collision map to stop the player getting inside the terrain. 
			for (var i: int = 0; i < levelWidth / C.GRID; i++)
			{
				for (var j: int = 1; j < 10; j++)
				{
					if ( collisionLayer.getTilemap().getTile(i, 0) )
					{
						e = new Entity( i * C.GRID, -j * C.GRID, null, new Hitbox(C.GRID, C.GRID) );
						e.type = "level";
						add( e );
					}
				}
			}
			
			add( collisionLayer );
			add( new TileLayer(map, getTileset(map.Ground.@tileset), map.Ground, C.LAYER_GROUND) );
			var e: Entity = add( new Entity(-1, 0, null, new Hitbox(1, 240)));
			
			e.type = C.DEFAULT_COLLISION_TYPE;
			
			add( new EdgeOfScreen() );
			
			var lookupDictionary: LookupDictionary = new MeeblesLookupDictionary();
			var madePlayer: Boolean = false;
			
			//Load Entities
			for each (var n:XML in map.Entities.*) 
			{
				lookupDictionary.create(n, this);
				if (n.name() == "PlayerStart")
				{
					madePlayer = true;
				}
			}
			
			if (!madePlayer)
			{
				var p: Entity = add( new Player(128, 64) );
				V.getRoom().cam.follow(p);
			}
			
			add( new volticpunk.entities.util.Delayer(0.4, startLevel) );
			
			timer = new Timer(320 - 140, 0); 
			timer.stop();
			add( timer );
		}
	}
}