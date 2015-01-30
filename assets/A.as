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


// LEVEL: A2 embedding from levels/A2.oel
[Embed(source = 'levels/A2.oel', mimeType = 'application/octet-stream')] public static const A2Map:Class;


// LEVEL: B embedding from levels/B.oel
[Embed(source = 'levels/B.oel', mimeType = 'application/octet-stream')] public static const BMap:Class;


// LEVEL: B2 embedding from levels/B2.oel
[Embed(source = 'levels/B2.oel', mimeType = 'application/octet-stream')] public static const B2Map:Class;


// LEVEL: C embedding from levels/C.oel
[Embed(source = 'levels/C.oel', mimeType = 'application/octet-stream')] public static const CMap:Class;


// LEVEL: C2 embedding from levels/C2.oel
[Embed(source = 'levels/C2.oel', mimeType = 'application/octet-stream')] public static const C2Map:Class;


// LEVEL: D embedding from levels/D.oel
[Embed(source = 'levels/D.oel', mimeType = 'application/octet-stream')] public static const DMap:Class;


// LEVEL: D2 embedding from levels/D2.oel
[Embed(source = 'levels/D2.oel', mimeType = 'application/octet-stream')] public static const D2Map:Class;


// LEVEL: E embedding from levels/E.oel
[Embed(source = 'levels/E.oel', mimeType = 'application/octet-stream')] public static const EMap:Class;


// LEVEL: E2 embedding from levels/E2.oel
[Embed(source = 'levels/E2.oel', mimeType = 'application/octet-stream')] public static const E2Map:Class;


// LEVEL: F embedding from levels/F.oel
[Embed(source = 'levels/F.oel', mimeType = 'application/octet-stream')] public static const FMap:Class;


// LEVEL: F2 embedding from levels/F2.oel
[Embed(source = 'levels/F2.oel', mimeType = 'application/octet-stream')] public static const F2Map:Class;


// LEVEL: G embedding from levels/G.oel
[Embed(source = 'levels/G.oel', mimeType = 'application/octet-stream')] public static const GMap:Class;


// LEVEL: G2 embedding from levels/G2.oel
[Embed(source = 'levels/G2.oel', mimeType = 'application/octet-stream')] public static const G2Map:Class;


// SOUND: Footstep1 embedding from sounds/footstep1.mp3
[Embed(source = 'sounds/footstep1.mp3')] public static const Footstep1:Class;
public static const Footstep1Sound:Sfx = new Sfx(Footstep1);


// VECTOR: 
public static const LevelsList:Vector.<Class> = new <Class>[AMap,A2Map,BMap,B2Map,CMap,C2Map,DMap,D2Map,EMap,E2Map,FMap,F2Map,GMap,G2Map];


// VECTOR: 
public static const SoundsList:Vector.<Class> = new <Class>[Footstep1];
public static const LEVELS:Object = {"A" : AMap,
"A2" : A2Map,
"B" : BMap,
"B2" : B2Map,
"C" : CMap,
"C2" : C2Map,
"D" : DMap,
"D2" : D2Map,
"E" : EMap,
"E2" : E2Map,
"F" : FMap,
"F2" : F2Map,
"G" : GMap,
"G2" : G2Map};
public static const SOUNDS:Object = {"Footstep1" : Footstep1Sound};
public static const TILES:Object = {"CollisionTiles" : CollisionTiles,
"LevelTiles" : LevelTiles};}
}