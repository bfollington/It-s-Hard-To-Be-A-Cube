package assets
{
import net.flashpunk.graphics.Image;
import net.flashpunk.Sfx;

public class A
{


// IMAGE: Collider embedding from collider.png
[Embed(source = 'collider.png')] public static const Collider:Class;
public static const ColliderImage:Image = new Image(Collider);


// IMAGE: CollisionTiles embedding from collision_tiles.png
[Embed(source = 'collision_tiles.png')] public static const CollisionTiles:Class;
public static const CollisionTilesImage:Image = new Image(CollisionTiles);


// IMAGE: FallingPlatform embedding from falling_platform.png
[Embed(source = 'falling_platform.png')] public static const FallingPlatform:Class;
public static const FallingPlatformImage:Image = new Image(FallingPlatform);


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


// IMAGE: TetrisL embedding from tetris_l.png
[Embed(source = 'tetris_l.png')] public static const TetrisL:Class;
public static const TetrisLImage:Image = new Image(TetrisL);


// IMAGE: TetrisLAlt embedding from tetris_l_alt.png
[Embed(source = 'tetris_l_alt.png')] public static const TetrisLAlt:Class;
public static const TetrisLAltImage:Image = new Image(TetrisLAlt);


// IMAGE: TetrisLong embedding from tetris_long.png
[Embed(source = 'tetris_long.png')] public static const TetrisLong:Class;
public static const TetrisLongImage:Image = new Image(TetrisLong);


// IMAGE: TetrisT embedding from tetris_t.png
[Embed(source = 'tetris_t.png')] public static const TetrisT:Class;
public static const TetrisTImage:Image = new Image(TetrisT);


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


// LEVEL: H embedding from levels/H.oel
[Embed(source = 'levels/H.oel', mimeType = 'application/octet-stream')] public static const HMap:Class;


// LEVEL: H2 embedding from levels/H2.oel
[Embed(source = 'levels/H2.oel', mimeType = 'application/octet-stream')] public static const H2Map:Class;


// LEVEL: I embedding from levels/I.oel
[Embed(source = 'levels/I.oel', mimeType = 'application/octet-stream')] public static const IMap:Class;


// LEVEL: I2 embedding from levels/I2.oel
[Embed(source = 'levels/I2.oel', mimeType = 'application/octet-stream')] public static const I2Map:Class;


// LEVEL: J embedding from levels/J.oel
[Embed(source = 'levels/J.oel', mimeType = 'application/octet-stream')] public static const JMap:Class;


// SOUND: DASH embedding from sounds/DASH.mp3
[Embed(source = 'sounds/DASH.mp3')] public static const DASH:Class;
public static const DASHSound:Sfx = new Sfx(DASH);


// SOUND: DIE embedding from sounds/DIE.mp3
[Embed(source = 'sounds/DIE.mp3')] public static const DIE:Class;
public static const DIESound:Sfx = new Sfx(DIE);


// SOUND: JUMP embedding from sounds/JUMP.mp3
[Embed(source = 'sounds/JUMP.mp3')] public static const JUMP:Class;
public static const JUMPSound:Sfx = new Sfx(JUMP);


// SOUND: LAND embedding from sounds/LAND.mp3
[Embed(source = 'sounds/LAND.mp3')] public static const LAND:Class;
public static const LANDSound:Sfx = new Sfx(LAND);


// SOUND: Track1 embedding from sounds/music/track_1.mp3
[Embed(source = 'sounds/music/track_1.mp3')] public static const Track1:Class;
public static const Track1Sound:Sfx = new Sfx(Track1);


// SOUND: Track2 embedding from sounds/music/track_2.mp3
[Embed(source = 'sounds/music/track_2.mp3')] public static const Track2:Class;
public static const Track2Sound:Sfx = new Sfx(Track2);


// SOUND: Track3 embedding from sounds/music/track_3.mp3
[Embed(source = 'sounds/music/track_3.mp3')] public static const Track3:Class;
public static const Track3Sound:Sfx = new Sfx(Track3);


// SOUND: Track4 embedding from sounds/music/track_4.mp3
[Embed(source = 'sounds/music/track_4.mp3')] public static const Track4:Class;
public static const Track4Sound:Sfx = new Sfx(Track4);


// VECTOR: 
public static const LevelsList:Vector.<Class> = new <Class>[AMap,A2Map,BMap,B2Map,CMap,C2Map,DMap,D2Map,EMap,E2Map,FMap,F2Map,GMap,G2Map,HMap,H2Map,IMap,I2Map,JMap];


// VECTOR: 
public static const SoundsList:Vector.<Class> = new <Class>[DASH,DIE,JUMP,LAND];


// VECTOR: 
public static const SoundsMusicList:Vector.<Class> = new <Class>[Track1,Track2,Track3,Track4];
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
"G2" : G2Map,
"H" : HMap,
"H2" : H2Map,
"I" : IMap,
"I2" : I2Map,
"J" : JMap};
public static const SOUNDS:Object = {"DASH" : DASHSound,
"DIE" : DIESound,
"JUMP" : JUMPSound,
"LAND" : LANDSound,
"Track1" : Track1Sound,
"Track2" : Track2Sound,
"Track3" : Track3Sound,
"Track4" : Track4Sound};
public static const TILES:Object = {"CollisionTiles" : CollisionTiles,
"LevelTiles" : LevelTiles};}
}