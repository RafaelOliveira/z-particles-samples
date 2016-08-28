package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import particles.ParticleSystem;
import particles.loaders.ParticleLoader;

class Project {
	var particleSystem:ParticleSystem;
	var fps:FramesPerSecond;
	
    public function new() : Void {
        Assets.loadEverything(assetsLoaded);
    }
	
	function assetsLoaded():Void {
		particleSystem = ParticleLoader.load(Assets.blobs.fire_plist, Assets.blobs.fire_plistName, Assets.images.fire);		
		fps = new FramesPerSecond();
		
		particleSystem.emit(System.windowWidth() / 2, (System.windowHeight() / 2) + 50);
		
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}
	
	function update():Void {
		particleSystem.update();
		fps.update();
	}
	
	function render(framebuffer:Framebuffer):Void {
		framebuffer.g2.font = Assets.fonts.Intro;
		framebuffer.g2.fontSize = 28; 
		
		framebuffer.g2.begin();
		
		particleSystem.render(framebuffer.g2);
		
		framebuffer.g2.color = Color.White;
		framebuffer.g2.drawString("FPS: " + fps.fps, 20, 20);
		
		framebuffer.g2.end();
		
		fps.calcFrames();
	}
}
