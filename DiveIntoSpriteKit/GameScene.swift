//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import GameplayKit
import SpriteKit

@objcMembers
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        // this method is called when your game scene is ready to run
        
        let background = SKSpriteNode(imageNamed: "road.jpg")
        background.zPosition = -1
        addChild(background)
        
        if let particles = SKEmitterNode(fileNamed: "Mud") {
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user touches the screen
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user stops touching the screen
    }

    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
}

