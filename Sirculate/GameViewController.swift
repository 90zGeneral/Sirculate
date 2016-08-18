//
//  GameViewController.swift
//  Sirculate
//
//  Created by Roydon Jeffrey on 8/6/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //Update the scores
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var CurrentScoreLabel: UILabel!
    
    @IBOutlet var gameButtonLabel: UIButton!
    
    @IBOutlet var replayLabel: UIButton!
    
    //Determines how the position of the ball
    @IBOutlet var fallingBall: UIImageView!
    
    //To increment the score
    var highScore = 0
    var currentScore = 0
    
    var isBallFalling = false
    
    //Holds the different colors for the ball animation and random selection
    var ballColorsArray = ["redBall", "greenBall", "blueBall", "yellowBall"]
    
    //Controls the rate of the falling ball
    var timer = NSTimer()
    
    //Restart the game after round ends
    @IBAction func replay(sender: AnyObject) {
        
        currentScore = 0
        
        let randomBallColor = Int(arc4random_uniform(UInt32(ballColorsArray.count)))
        fallingBall.image = UIImage(named: ballColorsArray[randomBallColor])
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    //Getting the button to rotate and match falling ball color
    @IBAction func gameButton(sender: AnyObject) {
        
//        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
//        rotateAnimation.fromValue = 0.0
//        rotateAnimation.toValue = CGFloat(M_PI)
//        
//        let duration = 0.5
//        rotateAnimation.duration = duration
//        gameButtonLabel.layer.addAnimation(rotateAnimation, forKey: nil)
        
        UIView.animateWithDuration(0.05, animations: ({
            self.gameButtonLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        }))
    }
    
    func update() {
        
        fallingBall.center = CGPointMake(fallingBall.center.x, fallingBall.center.y + 1)
        
        if fallingBall.center.y == 565 {
            fallingBall.center.y = -15
            let randomBallColor = Int(arc4random_uniform(UInt32(ballColorsArray.count)))
            fallingBall.image = UIImage(named: ballColorsArray[randomBallColor])
            replayLabel.hidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let randomBallColor = Int(arc4random_uniform(UInt32(ballColorsArray.count)))
        fallingBall.image = UIImage(named: ballColorsArray[randomBallColor])
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        replayLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
