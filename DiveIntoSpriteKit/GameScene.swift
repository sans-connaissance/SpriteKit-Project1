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
    
    let player = SKSpriteNode(imageNamed: "player-motorbike")
    var touchingPlayer = false
    
    
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
        
        player.position.x = -400
        player.zPosition = 1
        addChild(player)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user touches the screen
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        if tappedNodes.contains(player) {
            touchingPlayer = true
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard touchingPlayer else { return }
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        player.position = location
        
        
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user stops touching the screen
        touchingPlayer = false
        
    }

    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
}

