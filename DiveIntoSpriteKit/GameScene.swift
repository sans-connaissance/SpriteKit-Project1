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
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "player-motorbike")
    var touchingPlayer = false
    
    var gameTimer: Timer?
    
    
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
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.categoryBitMask = 1
        
        player.position.x = -400
        player.zPosition = 1
        addChild(player)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        //report on physical contact (also requires class protocol SKPhysicsContactDelegate above
        physicsWorld.contactDelegate = self
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
    
    func createEnemy() {
        let sprite = SKSpriteNode(imageNamed: "barrel")
        sprite.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite.name = "enemy"
        sprite.zPosition = 1
        
        //assigns size of the physics body detector -- determined by the sprite/image itself
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -250, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
        //contactTestBitMask set to 1 means that it will collide with physics bodies of categoryBitMask = 1
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        
        
        let sprite2 = SKSpriteNode(imageNamed: "car")
        sprite2.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite2.name = "car"
        sprite2.zPosition = 1
        
        //assigns size of the physics body detector -- determined by the sprite/image itself
        sprite2.physicsBody = SKPhysicsBody(texture: sprite2.texture!, size: sprite2.size)
        sprite2.physicsBody?.velocity = CGVector(dx: -250, dy: 0)
        sprite2.physicsBody?.linearDamping = 0
        sprite2.physicsBody?.contactTestBitMask = 1
        sprite2.physicsBody?.categoryBitMask = 0
        
        if sprite.position.y > 200 {
            addChild(sprite)
            
        } else {
        
        addChild(sprite2)
        }

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerHit(nodeB)
        } else {
            playerHit(nodeA)
        }
    }
    
    func playerHit(_ node: SKNode) {
        player.removeFromParent()
    }
    
}

