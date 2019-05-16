//
//  GameManager.swift
//  Snake
//
//  Created by Jessica Sendejo on 4/18/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import SpriteKit

var arraySprites: [SKSpriteNode] = [SKSpriteNode]()

class GameManager
{
    let grid = Grid()
    var scene: GameScene!
    
    var nextTime: Double?
    var timeExtension: Double = 1
    
    init(scene: GameScene)
    {
        self.scene = scene
    }
    
    func initGame()
    {
        makeSnake()

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
    
    func makeSnake()
    {
        if let grid = Grid(blockSize: 40.0, rows: 20, cols: 20) {
            grid.position = CGPoint (x: scene.frame.midX, y: scene.frame.midY)
            scene.addChild(grid)
            
            arraySprites.append(snakeHead)
            arraySprites.append(snakeBody)
            arraySprites.append(snakeTail)
            
            snakeHead.physicsBody = SKPhysicsBody(rectangleOf: snakeHead.frame.size)
            snakeHead.physicsBody!.isDynamic = false
            //snakeHead.position = CGPoint(x: .frame.midX + 50, y: self.frame.midY)
            snakeHead.setScale(0.2)
            snakeHead.position = grid.gridPosition(row: 10, col: 10)
            snakeHead.anchorPoint = CGPoint.zero
            
            snakeBody.physicsBody = SKPhysicsBody(rectangleOf: snakeBody.frame.size)
            snakeBody.physicsBody!.isDynamic = true
            snakeBody.setScale(0.2)
            snakeBody.position = grid.gridPosition(row: 10, col: 9)
            snakeBody.anchorPoint = CGPoint.zero
            
            snakeTail.physicsBody = SKPhysicsBody(rectangleOf: snakeTail.frame.size)
            snakeTail.physicsBody!.isDynamic = true
            snakeTail.setScale(0.2)
            snakeTail.position = grid.gridPosition(row: 10, col: 8)
            snakeTail.anchorPoint = CGPoint.zero
            
            snakeHead.isHidden = true
            snakeBody.isHidden = true
            snakeTail.isHidden = true
            
            grid.addChild(snakeHead)
            grid.addChild(snakeBody)
            grid.addChild(snakeTail)
            
            let myJoint1 = SKPhysicsJointFixed.joint(withBodyA: snakeHead.physicsBody!, bodyB: snakeBody.physicsBody!, anchor: CGPoint.zero)
            let myJoint2 = SKPhysicsJointFixed.joint(withBodyA: snakeBody.physicsBody!, bodyB: snakeTail.physicsBody!, anchor: CGPoint.zero)
            
            scene.physicsWorld.add(myJoint1)
            scene.physicsWorld.add(myJoint2)
            
        }
    }
    
}
