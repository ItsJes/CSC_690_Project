//
//  PlayButton.swift
//  Snake
//
//  Created by Jessica Sendejo on 5/6/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import Foundation
import SpriteKit

class PlayButton: SKSpriteNode {
    
    init() {
        let buttonTexture = SKTexture(imageNamed: "playButton_1")
        super.init(texture: buttonTexture, color: .clear, size: buttonTexture.size())
    }
    
    
    func playButtonImage() {
        let textureAtlas = SKTextureAtlas(named: "PlayButton")
        let frames = ["playButton_1"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
