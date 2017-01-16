//
//  GameOverScene.swift
//  Dividr Clone
//
//  Created by Chris Brown on 1/13/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        
        let message = "Game Over"
        let label = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        
        label.text = message
        label.fontSize = 64
        label.fontColor = SKColor.white
        label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        addChild(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Why does this present the GameScene offset?
//        let gameScene = GameScene(size: self.size)
//        self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 0.5))
        
        let gameScene = SKScene(fileNamed: "GameScene")
        gameScene?.scaleMode = .aspectFill
        self.view?.presentScene(gameScene!, transition: SKTransition.fade(withDuration: 0.5))
    }
}
