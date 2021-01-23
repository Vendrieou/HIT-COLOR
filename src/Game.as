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
		private var removeKnife:Boolean = false;
		
		private var KnifeAmountText:TextField;

		private var knifeAmount:int = 4;
		private var knifeDefaultIndex:int = 0;

		
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
			for (var i:int = 0; i < knifeAmount; i++) 
			{
				knife = new Image(assetsManager.getTexture("knife"));
				knife.pivotY = knife.height;
				knife.height = 120;
				knife.width = 80;
				knife.x = 450;
				knife.y = 600;
				knifeDefault.push(knife);
				addChild(knifeDefault[i])
			}
			knifeDefaultIndex = knifeDefault.length - 1;



			// === knife animate
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
			
			s.pivotX = s.width >> 1;
			s.pivotY = s.height >> 1;
			s.x = (stage.stageWidth - s.width >> 1) + (s.width >> 1);
			s.y = 100;
			addChild(s);
			
			s.addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
			
			GameOverText = new TextField((this.stage.width / 2), (this.stage.height / 2));
			addChild(GameOverText);
			
			KnifeAmountText = new TextField((this.stage.width / 2), (this.stage.height / 2) + 50);
			addChild(KnifeAmountText);			
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:EnterFrameEvent):void
		{
			KnifeAmountText.text = "Knife Amount:" + knifeAmount.toString();

			if (hit == true && addKnife == true && knifeDefault[knifeDefaultIndex] != null)
			{
				knifeDefault[knifeDefaultIndex].y -= speedUp;
				
				if (knifeDefault[knifeDefaultIndex].y >= 601)
				{
					hit = false;
				}
			}
			
			if (s.bounds.intersects(knifeDefault[knifeDefaultIndex].bounds) == true)
			{
						removeChild(knifeDefault[knifeDefaultIndex]);
						removeKnife = true;
					if (addKnife == false) return;
					if(removeKnife == true)
					{
						if (knifeDefaultIndex > 0){
							knifeDefaultIndex -= 1;
							knifeAmount -= 1;
						}
						else {
							removeChild(knifeDefault[0]);
							KnifeAmountText.text = "Knife Amount: 0";
							GameOverText.text = "Game Over";
							this.stage.starling.stop();
						}

						addChild(knifeDefault[knifeDefaultIndex]);
						hit = false;
					}
			}
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
			}
		}
		

	
	}

}