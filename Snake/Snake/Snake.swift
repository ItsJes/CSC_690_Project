//
//  Snake.swift
//  Snake
//
//  Created by Jessica Sendejo on 5/6/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import Foundation
import SpriteKit

class Snake: SKSpriteNode, SKPhysicsContactDelegate {

    
    init() {
        let mainSnakeTexture = SKTexture(imageNamed: "snakeHead_1")
        super.init(texture: mainSnakeTexture, color: .clear, size: mainSnakeTexture.size())
    }
 
    /*
    func Snake()
    {
        let textureAtlas = SKTextureAtlas(named: "SnakeSprite")
        let frames = ["snakeHead_1", "snakeBody_1", "snakeTail"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
    }
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
