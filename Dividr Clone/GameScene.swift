//
//  GameScene.swift
//  Dividr Clone
//
//  Created by Chris Brown on 1/13/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var leftPiece: SKSpriteNode!
    var rightPiece: SKSpriteNode!
    var initialPiecePosition: CGPoint!
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force / maximumPossibleForce
            
            leftPiece.position.x = normalizedForce * (self.size.width / -2 + 50)
            rightPiece.position.x = normalizedForce * (self.size.width / 2 - 50)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftPiece.position = initialPiecePosition
        rightPiece.position = initialPiecePosition
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        addPieces()
    }
    
    func addRandomRow() {
        let random = Int(arc4random_uniform(6))
        
        switch random {
        case 0:
            addRow(type: .OneSmall)
        case 1:
            addRow(type: .OneMedium)
        case 2:
            addRow(type: .OneLarge)
        case 3:
            addRow(type: .TwoSmall)
        case 4:
            addRow(type: .TwoMedium)
        case 5:
            addRow(type: .ThreeSmall)
        default:
            break
        }
    }
    
    func updateWithTimeSinceLastUpdate(_ timeSinceLastUpdate: TimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
        }
        
        lastUpdateTimeInterval = currentTime
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PIECE" {
            showGameOver()
        }
    }
    
    func showGameOver() {
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: SKTransition.fade(withDuration: 0.5))
    }
    
}
