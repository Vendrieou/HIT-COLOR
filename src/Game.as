package
{
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import starling.assets.AssetManager;
	
	//import starling.display.Canvas;
	import starling.display.Image;
	//import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	//import starling.events.KeyboardEvent;
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

		public function Game()
		{
			var appDir:File = File.applicationDirectory;
			//SET ASSETS MANAGER

			assetsManager = new AssetManager();
			assetsManager.enqueue(appDir.resolvePath("image"));

			assetsManager.loadQueue(startGame);
			//addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function startGame():void
		{
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onAdded);
		}
		
		private function onAdded(e:EnterFrameEvent):void
		{
			
			resetColors();
			//knife = new Image(assetsManager.getTexture("knife"));
			
			wood = new Image(assetsManager.getTexture("wood"));
			wood.width = 200;
			wood.height = 200;
			//q = new Quad(200, 200);
			s = new Sprite();
			//var legend:TextField = new TextField(120, 20, "Hello Starling!");
			
			//legend.style.=
			s.addChild(wood);
			//s.addChild(legend);
			//s.pivotX = 10;
			//s.pivotY = 10;
			s.pivotX = s.width >> 1;
			s.pivotY = s.height >> 1;
		
			s.x = (this.stage.width * Math.PI / 180);
			s.y = (this.stage.height * Math.PI / 180);
			
			//s.x = (stage.stageWidth - s.width >> 1) + (s.width >> 1);
			//s.y = (stage.stageHeight - s.height >> 1) + (s.height >> 1);
			addChild(s);
			
			r -= (r - rDest) * .01;
			g -= (g - gDest) * .01;
			b -= (b - bDest) * .01;
			var color:uint = r << 16 | g << 8 | b;
			//q.color = color;
			// when reaching the color, pick another one
			if (Math.abs(r - rDest) < 1 && Math.abs(g - gDest) < 1 && Math.abs(b - bDest)) resetColors();
			(e.currentTarget as DisplayObject).rotation += 0.3 * Math.PI / 90;
			//(e.currentTarget as DisplayObject).width  = 200;
			//(e.currentTarget as DisplayObject).height = 200;
			//s.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		//private function onFrame(e:EnterFrameEvent):void
		//{
			//r -= (r - rDest) * .01;
			//g -= (g - gDest) * .01;
			//b -= (b - bDest) * .01;
			//var color:uint = r << 16 | g << 8 | b;
			//q.color = color;
			//// when reaching the color, pick another one
			//if (Math.abs(r - rDest) < 1 && Math.abs(g - gDest) < 1 && Math.abs(b - bDest)) resetColors();
			//(e.currentTarget as DisplayObject).rotation += .03;
		//}
		
		private function resetColors():void
		{
			rDest = Math.random() * 255;
			gDest = Math.random() * 255;
			bDest = Math.random() * 255;
		}
	
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