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
		private var s:Sprite;
		private var wood:Image;
		
		[Embed(source="../bin/image/wood.png")]
		public static const woodClass:Class;
		
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
			addChild(knife);
			
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
			addChild(s);

			s.addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
		
			GameOverText = new TextField((this.stage.width / 2), (this.stage.height / 2));
			addChild(GameOverText);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:EnterFrameEvent):void
		{
				
			if (hit == true)
			{
				knife.y -= speedUp;
				
				if (knife.y >= 601)
				{
					hit = false;
				}
			}
			if (s.bounds.intersects(knife.bounds) == true)
			{
				
				hitKnife.push(knife);
				
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
				speedUp = 20;
			}
		}
	
	}

}