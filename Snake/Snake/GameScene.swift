//
//  GameScene.swift
//  Snake
//
//  Created by Jessica Sendejo on 4/18/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var currentScore: SKLabelNode!
    var playButton: SKShapeNode!
    var gameGB: SKShapeNode!
    
    var playerPosition: [(Int, Int)] = []
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    var game: GameManager!
    
    override func didMove(to view: SKView)
    {
        initializeMenu()
        game = GameManager()
        
        initializeGameView()
        
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
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
        
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5))
        {
            self.gameLogo.isHidden = true
        }
        playButton.run(SKAction.scale(to: 0, duration: 0.3))
        {
            self.playButton.isHidden = true
        }
        
        bestScore = SKLabelNode(fontNamed: "ChalkDuster")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 25)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        
        self.currentScore.isHidden = false
        self.gameGB.isHidden = false
        
    }
    
    private func initializeMenu()
    {
        //creates game title
        gameLogo = SKLabelNode(fontNamed: "Chalkduster")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 600)
        gameLogo.fontSize = 80
        gameLogo.text = "SNAKE"
        gameLogo.fontColor = SKColor.cyan
        self.addChild(gameLogo)
        
        
        //creats play button
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.darkGray
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
        
    }
    
    private func initializeGameView()
    {
        currentScore = SKLabelNode(fontNamed: "ChalkDuster")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 75)
        currentScore.fontSize = 40
        self.currentScore.isHidden = true
        currentScore.text = "Score: 0"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        
        let width = 550
        let height = 1100
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        
        gameGB = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameGB.fillColor = SKColor.gray
        gameGB.zPosition = 2
        self.gameGB.isHidden = true
        self.addChild(gameGB)
        
        createGameBoard(width: width, height: height)
    }
    
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
                cellNode.strokeColor = SKColor.black
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
}
