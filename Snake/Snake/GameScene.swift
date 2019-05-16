//
//  GameScene.swift
//  Snake
//
//  Created by Jessica Sendejo on 4/18/19.
//  Copyright © 2019 Jessica Sendejo. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

let snakeHead = SKSpriteNode(imageNamed: "snakeHead_1")
let snakeBody = SKSpriteNode(imageNamed: "snakeBody_1")
let snakeTail = SKSpriteNode(imageNamed: "snakeTail")


class GameScene: SKScene, SKPhysicsContactDelegate 
{
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var currentScore: SKLabelNode!
    var gameGB: SKShapeNode!
    var theRotation: CGFloat = 0
    var offset: CGFloat = 0
    var lastTouch: CGPoint? = nil
    var nextEncounterSpawnPosition = CGFloat(150)
    
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    
     var xVelocity: CGFloat = 0
    
    var playerPosition: [(Int, Int)] = []
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    let snakeAnimation = SnakeAnimation()
    let playButton = PlayButton()
    let background = GrassBackground()
    
    let rotate = UIRotationGestureRecognizer()
    let tap = UITapGestureRecognizer()
    
    var game: GameManager!
    
    let apple = SKSpriteNode(imageNamed: "apple")
    
    override func didMove(to view: SKView)
    {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGameView()
        snakeAnimation.beginAnimation()
        addSwipe()
        
        rotate.addTarget(self, action: #selector(GameScene.rotatedView(_:)))
        self.view!.addGestureRecognizer(rotate)

        
    }
    
    func randomFood() {
        //supposed to pick random point within the screen width
        
        let xPos = randomBetweenNumbers(firstNum: 0, secondNum: frame.width )
        
        apple.position = CGPoint(x: xPos, y: 0)
        apple.setScale(0.10)
        apple.physicsBody = SKPhysicsBody(circleOfRadius: apple.size.width/2)
        apple.zPosition = 2
        apple.alpha = 1
        apple.physicsBody?.affectedByGravity = false
        apple.physicsBody?.categoryBitMask = 0
        apple.physicsBody?.contactTestBitMask = 0
        addChild(apple)
    }
    
    func CollisionWithSnake(apple: SKSpriteNode, snakeHead: SKSpriteNode){
        apple.removeFromParent()
        snakeHead.removeFromParent()
    }
 
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    @objc func rotatedView(_ sender: UIRotationGestureRecognizer)
    {
        if(sender.state == .began)
        {
            print("We Bigin")
        }
        
        if(sender.state == .changed)
        {
            print("We Rotated")
            
            theRotation = CGFloat(sender.rotation) + self.offset
            theRotation *= -1
            
            snakeHead.zRotation = theRotation
            snakeTail.zRotation = theRotation
            snakeBody.zRotation = theRotation
        }
        
        if(sender.state == .ended)
        {
            print("We ended")
            self.offset = theRotation * -1
        }
        
        
    }
    /*
    @objc func tappedView()
    {
        let force: CGFloat = 5
        print("we tapped")
        
        let xVect: CGFloat = force * sin(theRotation) * -10
        let yVect: CGFloat = force * cos(theRotation) * 10
        
        let theVect: CGVector = CGVector(dx: xVect, dy: yVect)
        
        snakeHead.physicsBody?.applyImpulse(theVect)
        snakeBody.physicsBody?.applyImpulse(theVect)
        snakeTail.physicsBody?.applyImpulse(theVect)
    }
    */
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
            
        }
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer) {
        if let gesture = gesture as? UISwipeGestureRecognizer
        {
            switch gesture.direction
            {
            case .up:
                print("swiped up")
            case .left:
                print("swiped left")
            case .right:
                print("swiped right")
            case .down:
                print("swiped down")
            default:
                print("Not a gesture")
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        game.update(time: currentTime)
        if let touch = lastTouch {
            let impulseVector = CGVector(dx: touch.x - snakeHead.position.x,dy: 0)
            // If myShip starts moving too fast or too slow, you can multiply impulseVector by a constant or clamp its range
            snakeHead.physicsBody?.applyImpulse(impulseVector)
            snakeBody.physicsBody?.applyImpulse(impulseVector)
            
        }
       // self.apple.removeFromParent()
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
        
        
        for touch in touches
        {
            let location = touch.location(in: self)
            
            snakeHead.position.x = location.x
            snakeHead.position.y = location.y
            
            print("x: \(snakeHead.position.x), y: \(snakeHead.position.y)")
            
            let move = SKAction.applyForce(CGVector(dx: location.x, dy: location.y), duration: 0.2)
            self.run(move)
            
        }
       
 
    }
    
    
    /*
    func movement(){
        let animate = SKAction.move()
        let forever = SKAction.repeatForever(animate)
        self.run(forever)
    }
    */
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
            snakeHead.isHidden = false
        }
        
        snakeBody.run(SKAction.fadeIn(withDuration: 1.0))
        {
            snakeBody.isHidden = false
        }
        
        snakeTail.run(SKAction.fadeIn(withDuration: 1.0))
        {
            snakeTail.isHidden = false
        }
        
        background.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.background.isHidden = false
        }
        
        apple.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.apple.isHidden = false
        }
        
 
        /*
        gameGB.run(SKAction.fadeIn(withDuration: 1.0))
        {
            self.gameGB.isHidden = false
        }
        */
        self.game.initGame()
        

    }
    
    private func initializeMenu()
    {
 
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
        background.isHidden = true
        addChild(background)
        
        apple.isHidden = true
        
        let wait = SKAction.wait(forDuration: 5, withRange: 3)
        let spawn = SKAction.run {
            self.randomFood()
            print("Apple Spawned")
            //self.apple.removeFromParent()
           // print("Removed from Parent")
        }
        let spawning = SKAction.sequence([wait,spawn])
        self.run(SKAction.repeat((spawning), count: 1), withKey: "SpawnStop")
 
    }
}
        


