package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.input.Mouse;
import particles.ParticleSystem;
import particles.loaders.ParticleLoader;

class Project {	
	var particleSystem:Array<ParticleSystem>;
	
	var centerX:Float;
	var centerY:Float;
		
	var prevButton:Button;
	var nextButton:Button;
	
	var index:Int;
	var indexInfo:String;
	var idxInfoX:Float;
	var idxInfoY:Float;
	
	var fps:FramesPerSecond;
	
    public function new() : Void {
        Assets.loadEverything(assetsLoaded);
    }
	
	function assetsLoaded():Void {
		centerX = System.windowWidth() / 2;
		centerY = System.windowHeight() / 2;
		index = 0;
		
		particleSystem = new Array<ParticleSystem>();
		particleSystem.push(ParticleLoader.load(Assets.blobs.bubbles_json, Assets.blobs.bubbles_jsonName, Assets.images.bubbles));
		particleSystem.push(ParticleLoader.load(Assets.blobs.dust_plist, Assets.blobs.dust_plistName, Assets.images.dust));
		particleSystem.push(ParticleLoader.load(Assets.blobs.fire_plist, Assets.blobs.fire_plistName, Assets.images.fire));
		particleSystem.push(ParticleLoader.load(Assets.blobs.fountain_lap, Assets.blobs.fountain_lapName, Assets.images.fountain));
		particleSystem.push(ParticleLoader.load(Assets.blobs.frosty_blood_plist, Assets.blobs.frosty_blood_plistName, Assets.images.frosty_blood));
		particleSystem.push(ParticleLoader.load(Assets.blobs.heart_pex, Assets.blobs.heart_pexName, Assets.images.heart));
		particleSystem.push(ParticleLoader.load(Assets.blobs.hyperflash_plist, Assets.blobs.hyperflash_plistName, Assets.images.hyperflash));
		particleSystem.push(ParticleLoader.load(Assets.blobs.iris_plist, Assets.blobs.iris_plistName, Assets.images.iris));
		particleSystem.push(ParticleLoader.load(Assets.blobs.line_of_fire_plist, Assets.blobs.line_of_fire_plistName, Assets.images.line_of_fire));
		particleSystem.push(ParticleLoader.load(Assets.blobs.sun_plist, Assets.blobs.sun_plistName, Assets.images.sun));
		particleSystem.push(ParticleLoader.load(Assets.blobs.trippy_plist, Assets.blobs.trippy_plistName, Assets.images.trippy));
		
		prevButton = new Button(20, 20, "Prev");
		nextButton = new Button(220, 20, "Next");
		
		updateIndexInfo();
		Mouse.get().notify(onMouseDown, null, null, null);		
		fps = new FramesPerSecond();
		
		emit(centerX, centerY);
		
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}
	
	function onMouseDown(button: Int, mouseX: Int, mouseY: Int):Void {
		if (prevButton.click(mouseX, mouseY)) {
			particleSystem[index].stop();
			index--;
			if (index == -1)
				index = particleSystem.length - 1;
			
			updateIndexInfo();
			emit(centerX, centerY);
		}
		else if (nextButton.click(mouseX, mouseY)) {
			particleSystem[index].stop();
			index++;
			if (index == particleSystem.length)
				index = 0;
			
			updateIndexInfo();
			emit(centerX, centerY);
		}
		else
			emit(mouseX, mouseY);
	}
	
	function emit(posX:Float, posY:Float):Void {
		particleSystem[index].emit(posX, posY);
	}
	
	function updateIndexInfo():Void	{
		indexInfo = '${index + 1}:${particleSystem.length}';
		var indeInfoSize = Assets.fonts.Intro.width(28,indexInfo);
		
		idxInfoX = 170 - (indeInfoSize / 2);
		idxInfoY = 20;
	}
	
	function update():Void {
		particleSystem[index].update();
		
		fps.update();
	}
	
	function render(framebuffer:Framebuffer):Void {
		framebuffer.g2.font = Assets.fonts.Intro;
		framebuffer.g2.fontSize = 28; 
		
		framebuffer.g2.begin(true, Color.Black);		
		
		particleSystem[index].render(framebuffer.g2);
		
		prevButton.render(framebuffer.g2);
		nextButton.render(framebuffer.g2);
		
		framebuffer.g2.color = Color.White;
		framebuffer.g2.drawString(indexInfo, idxInfoX, idxInfoY);
		framebuffer.g2.drawString("Click to emit", 79, 55);
		framebuffer.g2.drawString("FPS: " + fps.fps, 700, 20);
		
		framebuffer.g2.end();
		
		fps.calcFrames();
	}
}
