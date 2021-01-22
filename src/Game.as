package
{
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import starling.assets.AssetManager;
	
	import starling.display.Canvas;
	import starling.display.Image;
	//import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	//import starling.text.TextField;
	//
	//import starling.rendering.VertexData;
	//import starling.rendering.IndexData;
	//import starling.display.Mesh;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	import starling.core.Starling;
	
	import starling.textures.Texture;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Game extends Sprite
	{
		private var q:Quad;
		private var s:Sprite;
		private var r:Number = 0;
		private var g:Number = 0;
		private var b:Number = 0;
		private var rDest:Number;
		private var gDest:Number;
		private var bDest:Number;
		private var assetsManager:AssetManager;
		
		private var wood:Image;
		private var knife:Image;
		private var knife1:Image;
		private var speedUp:int;
		private var GameOverText:TextField;
		private var hit:Boolean = false;
		private var _rotationInDegrees:Number = 0;
		
		private var canvas : Canvas = new Canvas();
		
		[Embed(source="../bin/image/wood.png")]
		public static const woodClass:Class;
		
		[Embed(source="../bin/image/knife.png")]
		public static const knifeClass:Class;

		public function Game()
		{
			var appDir:File = File.applicationDirectory;
			//SET ASSETS MANAGER
			assetsManager = new AssetManager();
			assetsManager.enqueue(appDir.resolvePath("image"));
			assetsManager.loadQueue(startGame);
		}
		
		private function startGame():void
		{
			var bmpWood:Bitmap = new woodClass();
			var texWood:Texture = Texture.fromBitmap(bmpWood);
			wood = new Image(texWood);		
			wood.width = 200;
			wood.height = 200;
			
			s = new Sprite();
			s.addChild(wood);
			
			s.pivotX = s.width >> 1;
			s.pivotY = s.height >> 1;
			s.x = (stage.stageWidth - s.width >> 1 ) + (s.width >> 1);
			s.y = 100;
			
			
			var hitKnife: Array = [1, 2, 3];
			hitKnife.pop();
			var currentAngle : int = 0;
			var startAngle : int = 2 * Math.PI;

			//for (var i:String  in hitKnife)
			//{
				var bmpKnife:Bitmap = new knifeClass();
				var texKnife:Texture = Texture.fromBitmap(bmpKnife);
				knife = new Image(texKnife);
				knife.pivotY = knife.height;
				knife.height = 120;
				knife.width = 80;
				knife.x = 100;
				knife.y = 250;
				s.addChild(knife);
			//}
			addChild(s);
			s.addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onAdded);

		}
		
		private function onAdded(e:EnterFrameEvent):void
		{
			var bmpKnife1:Bitmap = new knifeClass();
			var texKnife1:Texture = Texture.fromBitmap(bmpKnife1);
			knife1 = new Image(texKnife1);
			knife1.pivotY = knife.height;
			knife1.height = 120;
			knife1.width = 80;
			knife1.x = 490;
			knife1.y = 450;
				trace(knife1.y)
			// game throw knife
			if (hit == true)
			{
				knife1.y -= speedUp;
				if (knife1.y >= 601)
				{
					hit = false;
				}
				trace(knife.y);

			}
			addChild(knife1);

		}
		private function onFrame(e:EnterFrameEvent):void
		{
			(e.currentTarget as DisplayObject).rotation += 0.8 * Math.PI / 90;
		}
		private function pressKeyboard(e:KeyboardEvent):void
		{
			if (hit == true) return;
			if (e.keyCode == Keyboard.UP)
			{
				hit = true;
				speedUp = 20;
			}
		}
		
		//public function get rotationInDegrees():Number { return _rotationInDegrees;}
		//public function set rotationInDegrees(value:Number):void
		//{
			//_rotationInDegrees = value;
			//s.rotation = deg2rad(_rotationInDegrees);
		//}
	
		////private var startAngle = 2 * Math.PI;
		////private var endAngle = Math.PI * 2; //Welcome to my knife hit
		////
		////private var currentAngle = 0; //Level-1- Normal game
		////
		//////private var rectheight = Canvas.height - 90; //Level-2- Pre-fixed Knifes_rem
		////
		////private var knife_moving = 0; // level-3-Inverse rotating target
		////
		////private var knifes_remaining = 10; //level-4-Mirroring target on knife hit
		////
		////private var hit = 0; //Further levels to be added
		////
		////private var level = 1;
		////private var flag = 0;
		////private var hit_knifes = [];
		//
		////private var canvas : Canvas = new Canvas();
		//
		//
		////private var lastFrame:int = 0;
		////private var thisFrame:int;
		////private var pixelsPerSecond:Number = 200;
		////private var circle:Shape;
		////private var percentToMove:Number;
		//
		//
		//private var GameOverText:TextField;
		//private var hit:Boolean = false;
		//private var speedUp:int;
		//private var assetsManager:AssetManager;
		//private var knife:Image;
		//
		//
		//public function Game()
		//{
		//var appDir:File = File.applicationDirectory;
		////SET ASSETS MANAGER
		//
		//assetsManager = new AssetManager();
		//assetsManager.enqueue(appDir.resolvePath("image"));
		//
		//assetsManager.loadQueue(startGame);
		//}
		//
		//private function startGame():void
		//{
		////create knife
		//knife = new Image(assetsManager.getTexture("knife"));
		//knife.pivotY = knife.height;
		//knife.height = 120;
		//knife.width = 80;
		//knife.x = 450;
		//knife.y = 600;
		//addChild(knife);
		//
		//GameOverText = new TextField((this.stage.width / 2), (this.stage.height / 2));
		//addChild(GameOverText);
		//
		//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
		////this.stage.addEventListener(KeyboardEvent.KEY_UP, upKeyboard);
		//this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		//}
		//
		//private var _clock:DisplayObject;
		//private var _clockRotation:Number = 45;
		//
		//private function tryRotateClock(rotation:Number)
		//{
		//_clockRotation += rotation;
		//if (_clockRotation < -2*Math.PI) _clockRotation = -2*Math.PI; // starling use radians
		//if (_clockRotation > +2*Math.PI) _clockRotation = +2*Math.PI; // instead degrees
		//_clock.rotation = _clockRotation;
		//}
		//
		//private function onUserRotateClock(e:Event):void
		//{
		//var delta:Number = 10; // calculate delta
		//tryRotateClock(delta)
		//}
		//
		//private function enterFrame(e:EnterFrameEvent):void
		//{
		//
		//var canvas:Canvas = new Canvas();
		//canvas.beginFill(0xff0000);
		//canvas.drawCircle(490, 100, 90);
		//canvas.endFill();
		//
		//canvas.beginFill(0xa5a5a5);
		//canvas.drawCircle(490, 100, 60);
		//canvas.endFill();
		//
		//addChild(canvas);
		//
		//if (hit == true)
		//{
		//knife.y -= speedUp;
		//
		//if (knife.y >= 601)
		//{
		//hit = false;
		//}
		//}
		//
		//if (canvas.bounds.intersects(knife.bounds) == true || canvas.y >= 650){
		//GameOverText.text = "Game Over";
		//this.stage.starling.stop();
		//}
		//}
		//
		//private function pressKeyboard(e:KeyboardEvent):void
		//{
		//if (hit == true) return;
		//if (e.keyCode == Keyboard.UP)
		//{
		//hit = true;
		//speedUp = 20;
		//}
		//}
	
	}

}