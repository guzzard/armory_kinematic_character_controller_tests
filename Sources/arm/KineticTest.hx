package arm;

import armory.trait.physics.KinematicCharacterController;
import armory.trait.physics.bullet.KinematicCharacterController.ControllerShape;
import iron.system.Input;
import iron.math.Vec4;

class KineticTest extends iron.Trait {

	var controller:KinematicCharacterController;
	var keyboard:Keyboard = Input.getKeyboard();
	var initComplete:Bool = false;
	var speed:Float = 0.08;
	var jumpV:Vec4 = new Vec4(0.0, 0.0, 8.0);

	public function new() {
		super();
		iron.Scene.active.notifyOnInit(init);
		notifyOnUpdate(update);
	}

	function init(){
		object.addTrait(new KinematicCharacterController(75.0, ControllerShape.Capsule));
		controller = object.getTrait(KinematicCharacterController);
		initComplete = true;
	}

	function update(){
		if(initComplete){
			var move = Vec4.zero();

			if(keyboard.down("up")){
				move.y += 1;
			}

			if(keyboard.down("down")){
				move.y -= 1;
			}

			if(keyboard.down("left")){
				move.x -= 1;
			}

			if(keyboard.down("right")){
				move.x += 1;
			}

			if(keyboard.started("space")){
				if(controller.onGround()){
					#if js
					controller.jump();
					#elseif cpp
					controller.jump(jumpV);
					#end
				}
			}

			move.mult(speed);
			controller.setWalkDirection(move);
		}
	}
}
