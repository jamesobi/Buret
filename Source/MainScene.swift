import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    
    weak var myPhysicsNode:CCPhysicsNode!
    
    
    
    
    
    func didLoadFromCCB() {
        self.userInteractionEnabled = true
        myPhysicsNode.collisionDelegate = self
        myPhysicsNode.debugDraw = true
        
        loadLevelOne()
        
        
    }
    
    func loadLevelOne() {
        
        for var yVal = 200; yVal <= 280; yVal += 40 {
            for var xValue = 40; xValue <= 280; xValue += 30 {
                var temporaryBlueBall = CCBReader.load("BlueBall")
                temporaryBlueBall.scaleX = 0.25
                temporaryBlueBall.scaleY = 0.25
                temporaryBlueBall.position = ccp(CGFloat(xValue), CGFloat(yVal))
                myPhysicsNode.addChild(temporaryBlueBall)
            }
        }
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if touch.locationInWorld().y > 290 && touch.locationInWorld().y < 490 {
            var temporaryRedBall = CCBReader.load("RedBall") as! CCSprite
            temporaryRedBall.position = touch.locationInWorld()
            temporaryRedBall.scaleX = Float(0.25)
            temporaryRedBall.scaleY = Float(0.25)
        
    
            myPhysicsNode.addChild(temporaryRedBall)
            println("clicked at: \(touch.locationInWorld())")
        }
        
    }
    
    func scaleCircle(blueCircle:CCNode, scaleValue:Float) {
        println("Scale Box: \(scaleValue)")
        //blueCircle.scale += scaleValue
        
        for shape in blueCircle.physicsBody.chipmunkObjects {
            
            println("Physics Object: \(shape)")
            if shape is ChipmunkCircleShape {
                var newShape = shape as! ChipmunkCircleShape
                //cpCircleShapeSetOffset(shape, box.))
                //cpCircleShapeSetRadius(shape, box.boundingBox().origin)
                
                cpCircleShapeSetRadius(newShape.shape, cpFloat(blueCircle.boundingBox().size.width * CGFloat(0.5)))
                //cpCircleShapeSetOffset(newShape.shape, ccp(blueCircle.anchorPointInPoints.x * CGFloat(1.5), blueCircle.anchorPointInPoints.y * CGFloat(1.5)))
                
                //cpCircleShapeSetOffset(newShape.shape, ccp(0.0,0.0))
                
            }
        }
    }
    
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, redBall aRedBall: CCNode!, blueBall aBlueBall: CCNode!) -> ObjCBool {
//        println("collision detected")
//        var newX = aBlueBall.scaleX - 0.1
//        var newY = aBlueBall.scaleY - 0.1
//        
//        if newX > 0.0 && newY > 0.0 {
//            aBlueBall.scaleX = newX
//            aBlueBall.scaleY = newY
//            
//            //aBlueBall.physicsBody.shapeList.rescaleShape()
//            
//            
//            myPhysicsNode.space.addPostStepBlock({() -> Void in
//                self.scaleCircle(aBlueBall, scaleValue: -0.1)
//            }, key: aBlueBall)
//            
//            
//        } else if newX <= 0 && newY <= 0 {
//            aBlueBall.removeFromParent()
//            println("blueBall removed")
//        }
        
        
        if let realRedBall = aRedBall {
            aRedBall.removeFromParent()
            if let realBlueBall = aBlueBall {
                aBlueBall.removeFromParent()
            }
        }
        
        return true
    }
    
    
}
//bn