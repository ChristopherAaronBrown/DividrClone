//
//  GameViewController.swift
//  Dividr Clone
//
//  Created by Chris Brown on 1/13/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {

    var backgroundMusicPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                
                let backgroundMuiscURL = Bundle.main.url(forResource: "bgMusic", withExtension: "mp3")
                do {
                    try backgroundMusicPlayer = AVAudioPlayer(contentsOf: backgroundMuiscURL!)
                } catch {
                    print("Music unable to be played.")
                }
                
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
