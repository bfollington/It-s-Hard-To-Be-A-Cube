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


// IMAGE: MovingPlatform embedding from moving_platform.png
[Embed(source = 'moving_platform.png')] public static const MovingPlatform:Class;
public static const MovingPlatformImage:Image = new Image(MovingPlatform);


// IMAGE: Player embedding from player.png
[Embed(source = 'player.png')] public static const Player:Class;
public static const PlayerImage:Image = new Image(Player);


// IMAGE: Spike embedding from spike.png
[Embed(source = 'spike.png')] public static const Spike:Class;
public static const SpikeImage:Image = new Image(Spike);


// LEVEL: A embedding from levels/A.oel
[Embed(source = 'levels/A.oel', mimeType = 'application/octet-stream')] public static const AMap:Class;


// LEVEL: B embedding from levels/B.oel
[Embed(source = 'levels/B.oel', mimeType = 'application/octet-stream')] public static const BMap:Class;


// LEVEL: C embedding from levels/C.oel
[Embed(source = 'levels/C.oel', mimeType = 'application/octet-stream')] public static const CMap:Class;


// LEVEL: D embedding from levels/D.oel
[Embed(source = 'levels/D.oel', mimeType = 'application/octet-stream')] public static const DMap:Class;


// LEVEL: E embedding from levels/E.oel
[Embed(source = 'levels/E.oel', mimeType = 'application/octet-stream')] public static const EMap:Class;


// SOUND: Footstep1 embedding from sounds/footstep1.mp3
[Embed(source = 'sounds/footstep1.mp3')] public static const Footstep1:Class;
public static const Footstep1Sound:Sfx = new Sfx(Footstep1);


// VECTOR: 
public static const LevelsList:Vector.<Class> = new <Class>[AMap,BMap,CMap,DMap,EMap];


// VECTOR: 
public static const SoundsList:Vector.<Class> = new <Class>[Footstep1];
public static const LEVELS:Object = {"A" : AMap,
"B" : BMap,
"C" : CMap,
"D" : DMap,
"E" : EMap};
public static const SOUNDS:Object = {"Footstep1" : Footstep1Sound};
public static const TILES:Object = {"CollisionTiles" : CollisionTiles,
"LevelTiles" : LevelTiles};}
}