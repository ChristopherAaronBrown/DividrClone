//
//  GameElements.swift
//  Dividr Clone
//
//  Created by Chris Brown on 1/13/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Piece: UInt32 = 0x00
    static let Obstacle: UInt32 = 0x01
}

enum ObstacleType: Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType: Int {
    case OneSmall = 0
    case OneMedium = 1
    case OneLarge = 2
    case TwoSmall = 3
    case TwoMedium = 4
    case ThreeSmall = 5
}

extension GameScene {
    func addPieces() {
        leftPiece = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
        leftPiece.position = CGPoint(x: 0, y: self.size.height / -4)
        leftPiece.name = "PIECE"
        leftPiece.physicsBody?.isDynamic = false
        leftPiece.physicsBody = SKPhysicsBody(rectangleOf: leftPiece.size)
        leftPiece.physicsBody?.categoryBitMask = CollisionBitMask.Piece
        leftPiece.physicsBody?.collisionBitMask = 0
        leftPiece.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        addChild(leftPiece)
        
        rightPiece = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
        rightPiece.position = CGPoint(x: 0, y: self.size.height / -4)
        rightPiece.name = "PIECE"
        rightPiece.physicsBody?.isDynamic = false
        rightPiece.physicsBody = SKPhysicsBody(rectangleOf: rightPiece.size)
        rightPiece.physicsBody?.categoryBitMask = CollisionBitMask.Piece
        rightPiece.physicsBody?.collisionBitMask = 0
        rightPiece.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        addChild(rightPiece)
        
        initialPiecePosition = leftPiece.position
    }
    
    func addObstacle(type: ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
        case .Large:
            obstacle.size.width = self.size.width * 0.75
        }
        
        obstacle.position = CGPoint(x: 0, y: (self.size.height / 2) + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
    func addRow(type: RowType) {
        switch type {
        case .OneSmall:
            let obstacle = addObstacle(type: .Small)
            obstacle.position = CGPoint(x: 0, y: obstacle.position.y)
            addMovement(to: obstacle)
            addChild(obstacle)
        case .OneMedium:
            let obstacle = addObstacle(type: .Medium)
            obstacle.position = CGPoint(x: 0, y: obstacle.position.y)
            addMovement(to: obstacle)
            addChild(obstacle)
        case .OneLarge:
            let obstacle = addObstacle(type: .Large)
            obstacle.position = CGPoint(x: 0, y: obstacle.position.y)
            addMovement(to: obstacle)
            addChild(obstacle)
        case .TwoSmall:
            let obstacle1 = addObstacle(type: .Small)
            let obstacle2 = addObstacle(type: .Small)
            obstacle1.position = CGPoint(x: -obstacle1.size.width, y: obstacle1.position.y)
            obstacle2.position = CGPoint(x: obstacle2.size.width, y: obstacle1.position.y)
            addMovement(to: obstacle1)
            addMovement(to: obstacle2)
            addChild(obstacle1)
            addChild(obstacle2)
        case .TwoMedium:
            let obstacle1 = addObstacle(type: .Medium)
            let obstacle2 = addObstacle(type: .Medium)
            obstacle1.position = CGPoint(x: -obstacle1.size.width * (2/3), y: obstacle1.position.y)
            obstacle2.position = CGPoint(x: obstacle2.size.width * (2/3), y: obstacle1.position.y)
            addMovement(to: obstacle1)
            addMovement(to: obstacle2)
            addChild(obstacle1)
            addChild(obstacle2)
        case .ThreeSmall:
            let obstacle1 = addObstacle(type: .Small)
            let obstacle2 = addObstacle(type: .Small)
            let obstacle3 = addObstacle(type: .Small)
            obstacle1.position = CGPoint(x: -obstacle1.size.width * 1.75, y: obstacle1.position.y)
            obstacle2.position = CGPoint(x: 0, y: obstacle1.position.y)
            obstacle3.position = CGPoint(x: obstacle2.size.width * 1.75, y: obstacle1.position.y)
            addMovement(to: obstacle1)
            addMovement(to: obstacle2)
            addMovement(to: obstacle3)
            addChild(obstacle1)
            addChild(obstacle2)
            addChild(obstacle3)
        }
    }
    
    func addMovement(to obstacle: SKSpriteNode) {
        var actions = [SKAction]()
        
        actions.append(SKAction.move(to: CGPoint(x: obstacle.position.x, y: -obstacle.position.y), duration: TimeInterval(3)))
        actions.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actions))
    }
}
