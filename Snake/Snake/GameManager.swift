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
    
    var nextTime: Double?
    var timeExtension: Double = 1
    
    init(scene: GameScene)
    {
        self.scene = scene
    }
    
    func initGame()
    {
        scene.playerPosition.append((10, 10))
        scene.playerPosition.append((10, 11))
        scene.playerPosition.append((10, 12))
        renderChange()
        
    }
    
    func update(time: Double)
    {
        if nextTime == nil
        {
            nextTime = time + timeExtension
        }
        else
        {
            if time >= nextTime!
            {
               nextTime = time + timeExtension
                print(time)
            }
        }
    }
    
    func renderChange()
    {
        for (node, x, y) in scene.gameArray
        {
            if contains(a: scene.playerPosition, v: (x, y))
            {
                node.fillColor = SKColor.orange
            }
            else
            {
                node.fillColor = SKColor.clear
            }
        }
    }
    
    func contains(a: [(Int, Int)], v: (Int, Int)) -> Bool
    {
        let (c1, c2) = v
        for (v1, v2) in a
        {
            if v1 == c1 && v2 == c2
            {
                return true
            }
        }
        return false
    }
}
