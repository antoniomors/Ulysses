import AVKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let velocityMultiplier: CGFloat = 0.12
    // musica [per stoppare musica backgroundSound.run(SKAction.stop())
    //         per playare musica backgroundSound.run(SKAction.play())]
    var backgroundMusic: SKAudioNode!
    var bossMusic: SKAudioNode!
    
    // Nodes
    var player : SKNode?
    var ciclope : SKNode?
    var cam : SKCameraNode?
    var background : SKSpriteNode?
    var background2 : SKSpriteNode?
    var bottone: SKNode?
    
    
      //items -> ogni 3 un cuore
       var uva1: SKSpriteNode!
       var uva2: SKSpriteNode!
       var uva3: SKSpriteNode!
       var uva4: SKSpriteNode!
       var uva5: SKSpriteNode!
    var uva6: SKSpriteNode!
    
    //items formaggi -> ogni 3 un cuore
        var formaggio1: SKSpriteNode!
        var formaggio2 : SKSpriteNode!
        var formaggio3 : SKSpriteNode!
        var formaggio4 : SKSpriteNode!
        var formaggio5 : SKSpriteNode!
        var formaggio6 : SKSpriteNode!
    //Boolean
        var rewardIsNotTouched = true
    
    // score + tabella visibile
    let scoreLabel = SKLabelNode()
        var score = 0

    
    // movimenti
    var su: SKSpriteNode!
    var giu: SKSpriteNode!
    var sinistra: SKSpriteNode!
    var destra: SKSpriteNode!
    
    var enemy: SKSpriteNode!
    
    // per hit
    var isHit = false
    //per attivare bossfight
    var bossFight = false
    
    var heartsArray = [SKSpriteNode]()

    let heartContainer = SKSpriteNode()
    
 
//    var isMoving: Bool = false
    
    //movimento con textures(aka quann se move)
    var moveUp: SKAction? = SKAction(named: "moveUp")
    var moveLeft: SKAction? = SKAction(named: "moveLeft")
    var moveDown: SKAction? = SKAction(named: "moveDown")
    var moveRight: SKAction? = SKAction(named: "moveRight")
    var forbici1: SKAction? = SKAction(named: "forbici")
    var cecato: SKAction? = SKAction(named: "cecato")
    var colpito3: SKAction? = SKAction(named: "colpito3")
    
    func winGame() {
        
        var popup1 = SKLabelNode(text: "YOU COMPLETED THE DEMO")
        popup1.fontName = "kongtext"
        popup1.fontSize = 60
        popup1.position = CGPoint(x: 2285, y: 3108)
        addChild(popup1)
        
    }
    
   
    
    // movimento Boss
    func moveEnemy() {
        
        
        let moveEnemyAction = SKAction.move(to: CGPoint(x: player!.position.x, y: player!.position.y), duration: 0.5)
        moveEnemyAction.speed = 0.2
        
        enemy.run(moveEnemyAction)
        
//        debugPrint("funziona")
    }
    
    
    // FUNZIONE GAME OVER
    func gameOver() {
        var popup = SKLabelNode(text: "GAME OVER")
        popup.position = CGPoint(x: 0, y: 0)
        popup.fontName = "kongtext"
        popup.fontSize = 50
        
        var forbici = SKSpriteNode(imageNamed: "forbic4")
        forbici.position = CGPoint(x: 70, y: -200)
        forbici.setScale(5)
        forbici.zPosition = 5
            
        
        addChild(popup)
        popup.run(SKAction.fadeOut(withDuration: 5.0))
        addChild(forbici)
        forbici.run(SKAction.fadeOut(withDuration: 5.0))
        forbici.run(forbici1!)
        
                
    }
    
    
    
    //did move
    override func didMove(to view: SKView) {

//        setupJoystick()
        
        // fisicità mondo
        physicsWorld.contactDelegate = self

        // bottone pausa
        bottone = childNode(withName: "pausa") as? SKSpriteNode
        bottone?.position = CGPoint(x: 229, y: 332)

        bottone?.zPosition = 5
        
        
        player = childNode(withName: "Player") as? SKSpriteNode
        ciclope = childNode(withName: "Polifemo") as? SKSpriteNode
        
        background = childNode(withName: "pavimento") as? SKSpriteNode
        background?.zPosition = -1.0
        
        background2 = childNode(withName: "pavimento2") as? SKSpriteNode
        background2?.zPosition = -1.0
        
        enemy = childNode(withName: "boss") as? SKSpriteNode

    //items
        uva1 = SKSpriteNode(imageNamed: "uva1")
        uva2 = SKSpriteNode(imageNamed: "uva2")
        uva3 = SKSpriteNode(imageNamed: "uva3")
        uva4 = SKSpriteNode(imageNamed: "uva4")
        uva5 = SKSpriteNode(imageNamed: "uva5")
        uva6 = SKSpriteNode(imageNamed: "uva6")
        formaggio1 = SKSpriteNode(imageNamed: "Formaggio2")
        formaggio2 = SKSpriteNode(imageNamed: "Formaggio2")
        formaggio3 = SKSpriteNode(imageNamed: "Formaggio2")
        formaggio4 = SKSpriteNode(imageNamed: "Formaggio2")
        formaggio5 = SKSpriteNode(imageNamed: "Formaggio2")
        formaggio6 = SKSpriteNode(imageNamed: "Formaggio2")
        
        let itemArray = [uva1, uva2, uva3, uva4, uva5, uva6,formaggio1,formaggio2, formaggio3, formaggio4, formaggio5, formaggio6]

        
        scoreLabel.position = CGPoint(x: 140, y: 410)
        
        scoreLabel.zPosition = 1

        scoreLabel.fontColor = #colorLiteral(red: 0.9539349675, green: 0.9919989705, blue: 0.9593419433, alpha: 1)
        scoreLabel.fontSize = 24
        scoreLabel.fontName = "kongtext"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.text = "Score"
        cam?.addChild(scoreLabel)
        

        
        
        
        

        
        
        //musica
        if let musicURL = Bundle.main.url(forResource: "pen", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    
        
        
        
        
        // camera
        cam = childNode(withName: "camera") as? SKCameraNode
    
        self.camera = cam
    
        
        // frecce
        su = SKSpriteNode(imageNamed: "su")
        giu = SKSpriteNode(imageNamed: "giu")
        sinistra = SKSpriteNode(imageNamed: "sinistra")
        destra = SKSpriteNode(imageNamed: "destra")
        
        
        
        
        //          hearts
                heartContainer.position = CGPoint(x: -300, y: 610)
                heartContainer.zPosition = 5
                heartContainer.setScale(3.5)
        
        //        in that way the heart container will follow always the camera

        cam?.addChild(heartContainer)
        
                fillHearts(count: 3)
        
        
        } // fine did move

     // funzioni pausa e play gioco
    func pauseGame() {
        scene?.view?.isPaused = true
    }
    func playGame() {
        scene?.view?.isPaused = false
    }
    
    func removeItem() {
        let itemArray = [uva1, uva2, uva3, uva4, uva5, uva6, formaggio1, formaggio2, formaggio3, formaggio4, formaggio5, formaggio6]
        for ite in itemArray {
            let node = ite
            node?.removeFromParent()
            
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)

          if (node.name == "su") {
              player?.run(moveUp!)
          } else if (node.name == "giu") {
              player?.run(moveDown!)
          } else if (node.name == "sinistra") {
              player?.run(moveLeft!)
          } else if (node.name == "destra") {
              player?.run(moveRight!)
          }
        }
        
        print(player?.position.x, player?.position.y)
        
      }

    

    // touch move [quando le dita si muovono sullo schermo
     func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent)
      {
     
               }
    

override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    player?.removeAllActions()
    
    }
    
override func update(_ currentTime: CFTimeInterval)
    {
//        su.position = .init(x: player!.position.x - 50, y: player!.position.y - 300)
        
        /* Called before each frame is rendered */
        cam?.position = player!.position
    
        
        if bossFight == true {
        moveEnemy()
        }

        
//        da vedere posizione joystick
//        analogJoystick.position = .init(x: player!.position.x, y: player!.position.y - 500)


        
    }
    
}// fine scena



//MARK Collision

extension GameScene: SKPhysicsContactDelegate {
        
  

    struct Collision {

        enum Masks: Int{

            case killing, player1, reward, win, boss, arco

            var bitmask : UInt32 { return 1 << self.rawValue }

        }

        

        let masks: (first : UInt32, second : UInt32)

        

        func matches (_ first : Masks, _ second: Masks) -> Bool {

            return(first.bitmask==masks.first && second.bitmask==masks.second) || (first.bitmask==masks.second && second.bitmask==masks.first)

        }

    }

    

    

//    è la prima funzione ad essere chiamata quando c'è collisione

    func didBegin(_ contact: SKPhysicsContact) {

        var bossColpi = 0
        var colpoBoss = false
        
            if bossColpi == 3 {
                colpoBoss = true
            
            }
          
        
        
        let collision = Collision(masks: (first: contact.bodyA.categoryBitMask, second: contact.bodyB.categoryBitMask))

        

        if collision.matches(.player1, .killing){

            print("--- PLAYER AND KILLING -> DIE")

//            let die = SKAction.move(to: CGPoint(x: 5.832 , y: -352), duration: 0.0
//            player?.run(die)
    
            loseHeart()
            isHit = true
            

        }

        if collision.matches(.player1, .reward) {
            
            if contact.bodyA.node?.name == "uva"{
//                          contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                    contact.bodyA.node?.removeFromParent()
                          debugPrint("cazzi")
                      }
                      else if contact.bodyB.node?.name == "uva"{
//                          contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                                       contact.bodyB.node?.removeFromParent()

                          debugPrint("mazzi")
                      }

                      

            if contact.bodyA.node?.name == "Formaggio2" {
                          contact.bodyA.node?.physicsBody?.categoryBitMask = 0
          //                contact.bodyA.node?.removeFromParent().              Qui funziona che si prova se è body a o body b quindi si commenta e scommenta a piacimento
                          debugPrint("cazzi")
                      }
                      else if contact.bodyB.node?.name == "Formaggio2" {
                          contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                                        contact.bodyB.node?.removeFromParent()
          }


            if rewardIsNotTouched{
                           removeItem()
                           rewardTouch()
                           rewardIsNotTouched = false
                       }
                       removeItem()
                       debugPrint("touched")
                   
                  

            
            debugPrint("touched")
        }
          
            
            
      //   esempio azione penelope:
      //   player?.run(SKAction.resize(byWidth: 300, height: 300, duration: 0.1))
            
            
       
        

        if collision.matches(.player1, .killing) {

            print("--- PLAYER AND KILLING -> SCISSORS")

            if contact.bodyA.node?.name == "trap", let PecoraFronte = contact.bodyA.node {

                print("---- running scissors 1")



            }

            

            if contact.bodyB.node?.name == "trap", let PecoraFronte = contact.bodyB.node {

                print("---- running scissors 2")
                

            }

        }

        if collision.matches(.player1, .win) {

            

            
            bossFight = true
            print("--- PLAYER WINS")
            moveEnemy()
            
//            winGame()

            }
        if collision.matches(.player1, .boss) {
            loseHeart()
            isHit = true
        }
        if collision.matches(.player1, .arco) {
            
            
            enemy.run(cecato!)
          
            
        }
            
    }
}// fine did begin





extension GameScene {

        func fillHearts(count: Int){

            for index in 1...count{

                let heart = SKSpriteNode(imageNamed: "cuore")

                let xPosition = heart.size.width*CGFloat(index-1)

                heart.position = CGPoint(x: xPosition, y: 0)

                heartsArray.append(heart)

                heartContainer.addChild(heart)

            }

        }

        func loseHeart(){

            if isHit == true{

                let lastElement = heartsArray.count - 1

                if heartsArray.indices.contains(lastElement - 1){

                    let lastHeart = heartsArray[lastElement]

                    lastHeart.removeFromParent()

                    heartsArray.remove(at: lastElement)

                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false){

                        (timer) in

                        self.isHit = false

                    }

                }

                

                else{
                    gameOver()
                    dying()

                }

                isInvincible()
            }

        }

        

        

        func isInvincible(){

            player?.physicsBody?.categoryBitMask = 0

            Timer.scheduledTimer(withTimeInterval: 2, repeats: false){

                (timer) in

                self.player?.physicsBody?.categoryBitMask = 2

            }

        }

        

        func dying(){

            let dieAction = SKAction.move(to: CGPoint(x: -15, y: -355), duration: 0.1)

            player?.run(dieAction)

            self.removeAllActions()

            fillHearts(count: 3)
bossFight = false
        }

        

    }


struct ScreenSize {
  static let width        = UIScreen.main.bounds.size.width
  static let height       = UIScreen.main.bounds.size.height
  static let maxLength    = max(ScreenSize.width, ScreenSize.height)
  static let minLength    = min(ScreenSize.width, ScreenSize.height)
  static let size         = CGSize(width: ScreenSize.width, height: ScreenSize.height)
}

extension GameScene {
    func rewardTouch() {
        score += 1
        scoreLabel.text = String(score)
        }

}

