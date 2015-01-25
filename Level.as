package
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import assets.A;
	
	import entities.Player;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import volticpunk.V;
	import volticpunk.util.StringManipulation;
	import volticpunk.worlds.CollisionLayer;
	import volticpunk.worlds.LookupDictionary;
	import volticpunk.worlds.Room;
	import volticpunk.worlds.TileLayer;
	
	public class Level extends Room
	{
		private var tilesetDict: Dictionary;
		private var levelNumber: int;
		
		[Embed(source = '/assets/levels/meebles.oep', mimeType = 'application/octet-stream')] public static const Project:Class;
		
		public function Level(levelNumber: int = 0)
		{
			super();
			
			this.levelNumber = levelNumber;
			extractTilesetInfo(loadXml(Project));
		}
		
		private function loadXml(c: Class): XML
		{
			var bytes:ByteArray = new c();
			return new XML(bytes.readUTFBytes(bytes.length));
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
			
			if (Input.pressed(Key.SHIFT))
			{
				V.changeRoom( new Level(levelNumber + 1) );	
			}
		}
		
		public function reset(): void
		{
			V.changeRoom(new Level(levelNumber));
		}
		
		override public function begin(): void
		{
			super.begin();
			
			disableDarknessOverlay();
			var map: XML;
			
			var count: int = 0;
			for (var i:String in A.LEVELS)
			{
				if (count == this.levelNumber)
				{
					map = loadXml(A.LEVELS[i]);
					trace(i);
					break;
				}
				
				count++;
			}
			
			levelWidth = map.@width;
			levelHeight = map.@height;
			
			add( new CollisionLayer(map, A.CollisionTiles, map.Collision) );
			add( new TileLayer(map, getTileset(map.Ground.@tileset), map.Ground, C.LAYER_GROUND) );
			
			var lookupDictionary: LookupDictionary = new MeeblesLookupDictionary();
			
			//Load Entities
			for each (var n:XML in map.Entities.*) 
			{
				lookupDictionary.create(n, this);
			}
			
			var e: Entity = add( new Player(128, 64, A.PlayerImage, new Hitbox(16, 16)) );
			
			cam.follow(e);
			FP.console.watch(cam.x);
		}
	}
}