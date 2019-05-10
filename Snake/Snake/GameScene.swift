//
//  GameScene.swift
//  Snake
//
//  Created by Jessica Sendejo on 4/18/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate 
{
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var currentScore: SKLabelNode!
    var gameGB: SKShapeNode!
    
    var playerPosition: [(Int, Int)] = []
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    let snakeAnimation = SnakeAnimation()
    let playButton = PlayButton()
    let background = GrassBackground()
   // let snake = Snake()
    
    let snakeHead = SKSpriteNode(imageNamed: "snakeHead_1")
    let snakeBody = SKSpriteNode(imageNamed: "snakeBody_1")
    let snakeTail = SKSpriteNode(imageNamed: "snakeTail")
    
    var game: GameManager!
    
    override func didMove(to view: SKView)
    {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGameView()
        snakeAnimation.beginAnimation()
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        game.update(time: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode
            {
                if node.name == "play_button"
                {
                    startGame()
                }
            }
        }
    }
    
    private func startGame()
    {
        print("start game")
        
        gameLogo.run(SKAction.fadeOut(withDuration: 0.4))
        {
            self.gameLogo.isHidden = true
        }
        
        snakeAnimation.run(SKAction.fadeOut(withDuration: 0.4))
        {
            self.snakeAnimation.isHidden = true
        }
        
        playButton.run(SKAction.scale(to: 0, duration: 0.3))
        {
            self.playButton.isHidden = true
            
        }
        
        bestScore.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.bestScore.isHidden = false
        }
        
        currentScore.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.currentScore.isHidden = false
        }
        
        snakeHead.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.snakeHead.isHidden = false
        }
        
        snakeBody.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.snakeBody.isHidden = false
        }
        
        snakeTail.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.snakeTail.isHidden = false
        }
        
        background.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.background.isHidden = false
        }
        
        
 
        /*
        gameGB.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.gameGB.isHidden = false
        }
        */
        self.game.initGame()
        
        
        /*
        self.bestScore.setScale(0)
        self.bestScore.run(SKAction.scale(to: 1, duration: 0.6))
        
        self.currentScore.isHidden = false
        self.currentScore.setScale(0)
        self.currentScore.run(SKAction.scale(to: 1, duration: 0.6))
        
        self.gameGB.isHidden = false
        self.gameGB.setScale(0)
        self.gameGB.run(SKAction.scale(to: 1, duration: 0.6))
        */

    }
    
    private func initializeMenu()
    {
        
        self.snakeHead.isHidden = true
        self.snakeBody.isHidden = true
        self.snakeTail.isHidden = true
 
        self.background.isHidden = true
 
        //creates game title
        gameLogo = SKLabelNode(fontNamed: "Chalkduster")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (self.frame.midY + 200))
        gameLogo.fontSize = 80
        gameLogo.text = "SNAKE"
        gameLogo.fontColor = SKColor.orange
        self.addChild(gameLogo)
        
        snakeAnimation.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        snakeAnimation.size = CGSize(width: 200, height: 200)
        addChild(snakeAnimation)
        
        //creats play button
        playButton.name = "play_button"
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 150)
        playButton.size = CGSize(width: 150, height: 150)
        self.addChild(playButton)        
        
    }
    
    // this function sets the game board and scores
    private func initializeGameView()
    {
        currentScore = SKLabelNode(fontNamed: "ChalkDuster")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 50)
        currentScore.fontSize = 30
        self.currentScore.alpha = 0.0
        currentScore.text = "Score: 0"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        
        bestScore = SKLabelNode(fontNamed: "ChalkDuster")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 25)
        bestScore.fontSize = 30
        self.bestScore.alpha = 0.0
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        
        background.zPosition = -1
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        addChild(background)
        
        self.physicsBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0,dy: -9.8)
        
        if let grid = Grid(blockSize: 40.0, rows: 20, cols: 20) {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            addChild(grid)
            
            snakeHead.physicsBody = SKPhysicsBody(rectangleOf: snakeHead.frame.size)
            snakeHead.physicsBody!.isDynamic = false
           // snakeHead.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
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
            
            grid.addChild(snakeHead)
            grid.addChild(snakeBody)
            grid.addChild(snakeTail)
            
            let myJoint1 = SKPhysicsJointFixed.joint(withBodyA: snakeHead.physicsBody!, bodyB: snakeBody.physicsBody!, anchor: anchorPoint)
            let myJoint2 = SKPhysicsJointFixed.joint(withBodyA: snakeBody.physicsBody!, bodyB: snakeTail.physicsBody!, anchor: anchorPoint)
            
            self.physicsWorld.add(myJoint1)
            self.physicsWorld.add(myJoint2)
        }
        
        /*
        // Setup physics body to the scene (borders)
        self.physicsBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        
        // Change gravity settings of the physics world
        self.physicsWorld.gravity = CGVector(dx: 0,dy: -9.8)
        
        // Head object properties
        snakeHead.physicsBody = SKPhysicsBody(rectangleOf: snakeHead.frame.size)
        snakeHead.physicsBody!.isDynamic = false
        snakeHead.size = CGSize(width: 50, height: 50)
        snakeHead.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        // Body object properties
        snakeBody.physicsBody = SKPhysicsBody(rectangleOf: snakeBody.frame.size)
        snakeBody.physicsBody!.isDynamic = true
        snakeBody.size = CGSize(width: 50, height: 50)
        snakeBody.anchorPoint = CGPoint.zero
        snakeBody.position = CGPoint(x: self.frame.midX - 75, y: self.frame.midY - 25)
        
        // Tail object Properties
        snakeTail.physicsBody = SKPhysicsBody(rectangleOf: snakeBody.frame.size)
        snakeTail.physicsBody!.isDynamic = true
        snakeTail.size = CGSize(width: 50, height: 50)
        snakeTail.anchorPoint = CGPoint.zero
        snakeTail.position = CGPoint(x: self.frame.midX - 125, y: self.frame.midY - 25)
        
        self.addChild(snakeHead)
        self.addChild(snakeBody)
        self.addChild(snakeTail)
        
        let myJoint1 = SKPhysicsJointFixed.joint(withBodyA: snakeHead.physicsBody!, bodyB: snakeBody.physicsBody!, anchor: anchorPoint)
        let myJoint2 = SKPhysicsJointFixed.joint(withBodyA: snakeBody.physicsBody!, bodyB: snakeTail.physicsBody!, anchor: anchorPoint)
        
        self.physicsWorld.add(myJoint1)
        self.physicsWorld.add(myJoint2)
 */
    }
        
        /*
        let width = 550
        let height = 1100
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        
        gameGB = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameGB.fillColor = SKColor.clear
        gameGB.zPosition = 2
        self.gameGB.alpha = 0.0
        self.addChild(gameGB)
        
        createGameBoard(width: width, height: height)
 
    }
    
    // this function creates the game board using array
    private func createGameBoard(width: Int, height: Int)
    {
        let cellWidth: CGFloat = 27.5
        let numRows = 40
        let numCols = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2) - (cellWidth / 2)
        
        for i in 0...numRows - 1
        {
            for j in 0...numCols - 1
            {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.clear
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                gameArray.append((node: cellNode, x: i, y: j))
                gameGB.addChild(cellNode)
                
                x += cellWidth
                
            }
            
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
        
    }
 */
}
