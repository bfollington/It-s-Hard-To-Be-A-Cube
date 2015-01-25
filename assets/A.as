package assets
{
import net.flashpunk.graphics.Image;
import net.flashpunk.Sfx;

public class A
{


// IMAGE: CollisionTiles embedding from collision_tiles.png
[Embed(source = 'collision_tiles.png')] public static const CollisionTiles:Class;
public static const CollisionTilesImage:Image = new Image(CollisionTiles);


// IMAGE: LevelTiles embedding from level_tiles.png
[Embed(source = 'level_tiles.png')] public static const LevelTiles:Class;
public static const LevelTilesImage:Image = new Image(LevelTiles);


// LEVEL: Test embedding from levels/test.oel
[Embed(source = 'levels/test.oel', mimeType = 'application/octet-stream')] public static const TestMap:Class;


// SOUND: Footstep1 embedding from sounds/footstep1.mp3
[Embed(source = 'sounds/footstep1.mp3')] public static const Footstep1:Class;
public static const Footstep1Sound:Sfx = new Sfx(Footstep1);


// VECTOR: 
public static const LevelsList:Vector.<Class> = new <Class>[TestMap];


// VECTOR: 
public static const SoundsList:Vector.<Class> = new <Class>[Footstep1];
public static const LEVELS:Object = {"Test" : TestMap};
public static const SOUNDS:Object = {"Footstep1" : Footstep1Sound};
public static const TILES:Object = {"CollisionTiles" : CollisionTiles,
"LevelTiles" : LevelTiles};}
}