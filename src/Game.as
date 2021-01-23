package
{
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import starling.assets.AssetManager;
	
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	
	import starling.textures.Texture;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Game extends Sprite
	{
		private var GameOverText:TextField;
		private var hit:Boolean = false;
		private var speedUp:int;
		private var assetsManager:AssetManager;
		private var knife:Image;
		private var tempKnife:Image;
		private var s:Sprite;
		private var wood:Image;
		private var currentRotation:int = 0;
		
		[Embed(source = "../bin/image/wood.png")]
		public static const woodClass:Class;
		
		[Embed(source = "../bin/image/knife.png")]
		public static const knifeClass:Class;
		private var knifeRotate:Image;
		private var knifeRotate1:Image;
		private var knifeRotate2:Image;
		private var sKnife:Sprite;
		
		private var knifeDefault:Vector.<Image>  = new Vector.<Image>();
		private var hitKnife:Vector.<Image> = new Vector.<Image>();
		private var addKnife:Boolean = false;

		//private var knife1:Image;
		
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
			//create knife
			knife = new Image(assetsManager.getTexture("knife"));
			knife.pivotY = knife.height;
			knife.height = 120;
			knife.width = 80;
			knife.x = 450;
			knife.y = 600;
			knifeDefault.push(knife);
			addChild(knifeDefault[0]);
			//addChild(knife);

			////var knife1:Image;
			////knife1 = new Image(assetsManager.getTexture("knife"));
			////knife1.pivotY = knife1.height;
			////knife1.height = 120;
			////knife1.width = 80;
			////knife1.x = 100;
			////knife1.y = 250;
			//
			//
			//var knife2:Image;
			//knife2 = new Image(assetsManager.getTexture("knife"));
			//knife2.pivotY = knife2.height;
			//knife2.height = 120;
			//knife2.width = 80;
			//
			//var angleRotation2 : Object = angleToVector2(180 / Math.PI * 100);
			////knife2.x = 100;
			////knife2.y = 250;
			//knife2.x = Math.abs(angleRotation2.x) + 20;
			//knife2.y = Math.abs(angleRotation2.y) + 80;
			//
			////knife2.x = Math.abs(angleRotation.x) > 120 ?  Math.abs(angleRotation.x) + 20 :  Math.abs(angleRotation.x) - 200;
			////knife2.y = Math.abs(angleRotation.y) > 120 ?  Math.abs(angleRotation.y) + 100 :  Math.abs(angleRotation.y) - 10;
			////knife2.rotation = deg2rad(2 * Math.PI * 20);
			////trace(Math.abs(angleRotation.x));
			////trace(Math.abs(angleRotation.y));
			////trace(200 * Math.cos(1) * 1);
			//
			//

			var bmpKnife:Bitmap = new knifeClass();
			var texKnife:Texture = Texture.fromBitmap(bmpKnife);
			knifeRotate = new Image(texKnife);
			knifeRotate.width = 80;
			knifeRotate.height = 120;
			knifeRotate.x = 20;
			knifeRotate.y = 20;
			
			var bmpKnife1:Bitmap = new knifeClass();
			var texKnife1:Texture = Texture.fromBitmap(bmpKnife1);
			knifeRotate1 = new Image(texKnife1);
			knifeRotate1.width = 80;
			knifeRotate1.height = 120;
			knifeRotate1.x = 15;
			knifeRotate1.y = 20;
			knifeRotate1.rotation = 45;
			
			var bmpKnife2:Bitmap = new knifeClass();
			var texKnife2:Texture = Texture.fromBitmap(bmpKnife2);
			knifeRotate2 = new Image(texKnife2);
			knifeRotate2.width = 80;
			knifeRotate2.height = 120;
			//knifeRotate2.x = 10;
			//knifeRotate2.y = -10;
			knifeRotate2.x = 15;
			knifeRotate2.y = -20;
			knifeRotate2.rotation = 90;
			
			sKnife = new Sprite();
			//sKnife.width = 200;
			//sKnife.height = 200;
			sKnife.x = (stage.stageWidth - sKnife.width >> 1) + (sKnife.width >> 1);
			sKnife.y = 100;
			sKnife.addChild(knifeRotate);
			sKnife.addChild(knifeRotate1);
			sKnife.addChild(knifeRotate2);
			addChild(sKnife);
			sKnife.addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
			// === wood
			
			var bmpWood:Bitmap = new woodClass();
			var texWood:Texture = Texture.fromBitmap(bmpWood);
			wood = new Image(texWood);
			wood.width = 200;
			wood.height = 200;
			
			s = new Sprite();
			s.addChild(wood);
			//s.addChild(knifeRotate);
			//s.addChild(knifeRotate1);
			//s.addChild(knifeRotate2);
			//s.addChild(knife1);
			//s.addChild(knife2);
			
			s.pivotX = s.width >> 1;
			s.pivotY = s.height >> 1;
			s.x = (stage.stageWidth - s.width >> 1) + (s.width >> 1);
			s.y = 100;
			addChild(s);
			
			s.addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
			
			GameOverText = new TextField((this.stage.width / 2), (this.stage.height / 2));
			addChild(GameOverText);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function angleToVector2(angle:int):Object
		{
			var xDirection:int = (angle <= 90 || angle >= 270) ? 1 : -1;
			var yDirection:int = angle < 180 ? 1 : -1;
			
			var xAxis:int = 200 * Math.cos(angle) * xDirection;
			var yAxis:int = 200 * Math.sin(angle) * yDirection;
			
			return {x: xAxis, y: yAxis};
		}
		
		private function enterFrame(e:EnterFrameEvent):void
		{
			
			if (hit == true && addKnife == true)
			{
				trace(knifeDefault.length);
				knifeDefault[0].y -= speedUp;
				
				if (knifeDefault[0].y >= 601)
				{
					hit = false;
				}
			}
			
			//if (sKnife.bounds.intersects(knife.bounds) == true)
			if (s.bounds.intersects(knifeDefault[0].bounds) == true)
			{
						removeChild(knifeDefault[0]);
					if (addKnife == false) return;
					if (!removeChild(knifeDefault[0]) == true)
					{
						tempKnife = new Image(assetsManager.getTexture("knife"));
						tempKnife.pivotY = tempKnife.height;
						tempKnife.height = 120;
						tempKnife.width = 80;
						tempKnife.x = 450;
						tempKnife.y = 600;
						addKnife = false;
						hitKnife.push(tempKnife);
						//var knife : Image = tempKnife;
						//addChild(knife);
						knifeDefault[0] = tempKnife;
						addChild(knifeDefault[0]);
						GameOverText.text = hitKnife.length.toString();
					}
				////if (knife.y <= 280){
					//if (sKnife.bounds.intersects(knife.bounds) == false)
					//{
						//knife.visible = false;
						//var tempKnife : Image = new Image(assetsManager.getTexture("knife"));
						//tempKnife.pivotY = tempKnife.height;
						//tempKnife.height = 120;
						//tempKnife.width = 80;
						//tempKnife.x = 450;
						//tempKnife.y = 600;
						//hitKnife.push(tempKnife);
						//knife = tempKnife;
						//GameOverText.text = hitKnife.length.toString();
					//}
						//this.stage.starling.stop();
			}
		
			// if (canvas.bounds.intersects(knife.bounds) == true || canvas.y >= 650)
			// {
			// 	GameOverText.text = "Game Over";
			// 	this.stage.starling.stop();
			// }
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
				addKnife = true;
				speedUp = 20;
				currentRotation = s.rotation;
					//trace(currentRotation);
			}
		}
	
		//private function spwanKnife():void
		//{
		//var newKnife : Image = new Image(assetsManager.getTexture("knife"));
		//newKnife.x = 200;
		//newKnife.pivotY = knife.height;
		//newKnife.height = 120;
		//newKnife.width = 80;
		//newKnife.x = 450;
		//newKnife.y = 600;
		//addChild(newKnife);
		//}
	
	}

}