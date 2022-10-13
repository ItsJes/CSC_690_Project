//
//  SnakeAnimation.swift
//  Snake
//
//  Created by Jessica Sendejo on 5/5/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeAnimation: SKSpriteNode {
    
    init() {
        let snakeTexture = SKTexture(imageNamed: "snake_1")
        super.init(texture: snakeTexture, color: .clear, size: snakeTexture.size())
    }
    
    
    func beginAnimation() {
        let textureAtlas = SKTextureAtlas(named: "Snake")
        let frames = ["snake_1", "snake_2", "snake_3", "snake_4"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
        let animate = SKAction.animate(with: frames, timePerFrame: 0.15)
        let forever = SKAction.repeatForever(animate)
        self.run(forever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
