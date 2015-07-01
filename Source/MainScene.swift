import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    
    weak var myPhysicsNode:CCPhysicsNode!
    
    
    var sizes:[CCSprite] = []
    
    
    
    
    func didLoadFromCCB() {
        self.userInteractionEnabled = true
        myPhysicsNode.collisionDelegate = self
        myPhysicsNode.debugDraw = true
        
        sizes.append(CCBReader.load("BlueBallOne") as! CCSprite)
        sizes.append(CCBReader.load("BlueBallTwo") as! CCSprite)
        sizes.append(CCBReader.load("BlueBallThree") as! CCSprite)
        sizes.append(CCBReader.load("BlueBallFour") as! CCSprite)
        sizes.append(CCBReader.load("BlueBallFive") as! CCSprite)
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var temporaryRedBall = CCBReader.load("RedBall") as! CCSprite
        temporaryRedBall.position = touch.locationInWorld()
        temporaryRedBall.scaleX = Float(0.25)
        temporaryRedBall.scaleY = Float(0.25)
        
    
        myPhysicsNode.addChild(temporaryRedBall)
        println("clicked at: \(touch.locationInWorld())")
        
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
    
    
//    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, redBall aRedBall: CCNode!, blueBall aBlueBall: CCNode!) -> ObjCBool {
//        
////        switch aBlueBall.boundingBox().width:
////        case 130.5 {
////            currentSize = 5
////        }
////        case 104.4 {
////            currentSize = 4
////        }
////        case 78.3 {
////        currentSize = 3
////        }
////
////        case 52.2 {
////        currentSize = 2
////        }
////
////        case 26.1 {
////        currentSize = 1
////        }
////        default {
////            aBlueBall.removeFromParent
////        }
//
//        
//        
//        
//        
//        return true
//    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, redBall aRedBall: CCNode!, blueBall aBlueBall: CCNode!) -> ObjCBool {
        println("collision detected")
        var newX = aBlueBall.scaleX - 0.1
        var newY = aBlueBall.scaleY - 0.1
        
        if newX > 0.0 && newY > 0.0 {
            aBlueBall.scaleX = newX
            aBlueBall.scaleY = newY
            
            //aBlueBall.physicsBody.shapeList.rescaleShape()
            
            
            myPhysicsNode.space.addPostStepBlock({() -> Void in
                self.scaleCircle(aBlueBall, scaleValue: -0.1)
            }, key: aBlueBall)
            
            
        } else if newX <= 0 && newY <= 0 {
            aBlueBall.removeFromParent()
            println("blueBall removed")
        }
        
        aRedBall.removeFromParent()
        
        return true
    }
    
    
}
//bn