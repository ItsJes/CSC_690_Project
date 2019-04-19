//
//  GameManager.swift
//  Snake
//
//  Created by Jessica Sendejo on 4/18/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import SpriteKit

class GameManager
{
    var scene: GameScene!
    
    init(scene: GameScene)
    {
        self.scene = scene
    }
    
    func initGame()
    {
        scene.playerPosition.append((10, 10))
        scene.playerPosition.append((10, 11))
        scene.playerPosition.append((10, 12))
    }
    
}
