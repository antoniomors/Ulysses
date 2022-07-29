//
//  StartScene.swift
//  Ulysses
//
//  Created by Antonio Amoroso on 17/02/22.
//

import Foundation
import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    var playButton: SKSpriteNode?
    var gameScene: SKScene!
    var Label: SKLabelNode?
    
    override func didMove(to view: SKView) {
     
        
             

        
        
        
        self.playButton = self.childNode(withName: "Button") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                    let pos = touch.location(in: self)
                    let node = self.atPoint(pos)

                    if node.name == "startButton" {
                        let transition = SKTransition.fade(withDuration: 1)
                        gameScene = SKScene(fileNamed: "GameScene")
                        gameScene.scaleMode = .aspectFit
                        self.view?.presentScene(gameScene, transition: transition)
                        print("touch")
                        debugPrint("tapped")
                    }
            
                }
        }


override func update(_ currentTime: TimeInterval) {
        
    }
    

}

