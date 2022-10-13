//
//  GrassBackground.swift
//  Snake
//
//  Created by Jessica Sendejo on 5/6/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import Foundation
import SpriteKit

class GrassBackground: SKSpriteNode {
    
    init() {
        let grassTexture = SKTexture(imageNamed: "grass_1")
        super.init(texture: grassTexture, color: .clear, size: grassTexture.size())
    }
    
    
    func playButtonImage() {
        let textureAtlas = SKTextureAtlas(named: "Grass")
        let frames = ["grass_1"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
