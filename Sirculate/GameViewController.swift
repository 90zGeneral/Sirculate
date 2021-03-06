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
    var gameButtonPosition = 0
    var randomBallColor: Int = 0
    
    //Holds the different colors for the ball animation and random selection
    var ballColorsArray = ["blueBall", "yellowBall", "redBall", "greenBall"]
    
    //Controls the rate of the falling ball
    var timer = NSTimer()
    
    //Restart the game after round ends
    @IBAction func replay(sender: AnyObject) {
        fallingBall.center.y = -15
        currentScore = 0
        CurrentScoreLabel.text = "\(currentScore)"
        fallingBall.hidden = false
        gameButtonLabel.enabled = true
        replayLabel.hidden = true
        randomBallColor = Int(arc4random_uniform(UInt32(ballColorsArray.count)))
        fallingBall.image = UIImage(named: ballColorsArray[randomBallColor])
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func update() {
        
        fallingBall.center = CGPointMake(fallingBall.center.x, fallingBall.center.y + 1)
        
        if fallingBall.center.y == 323 {
            if gameButtonPosition == randomBallColor {
                currentScore += 1
                CurrentScoreLabel.text = "\(currentScore)"
                fallingBall.center.y = -15
                randomBallColor = Int(arc4random_uniform(UInt32(ballColorsArray.count)))
                fallingBall.image = UIImage(named: ballColorsArray[randomBallColor])
            }else {
                replayLabel.hidden = false
                gameButtonLabel.enabled = false
                fallingBall.hidden = true
                timer.invalidate()
                
                NSUserDefaults.standardUserDefaults().setObject(highScore, forKey: "highScoreUpdate")
                var newHighScore = NSUserDefaults.standardUserDefaults().objectForKey("highScoreUpdate")! as! Int
                
                if currentScore > newHighScore {
                    newHighScore = currentScore
                    highScore = currentScore
                    highScoreLabel.text = "\(newHighScore)"
                }
            }
        }
    }
    
    //Getting the button to rotate and match falling ball color
    @IBAction func gameButton(sender: AnyObject) {
        
        UIView.animateWithDuration(0.05) {
            self.gameButtonLabel.transform = CGAffineTransformRotate(self.gameButtonLabel.transform, CGFloat(M_PI_2))
            if self.gameButtonPosition < 3 {
                self.gameButtonPosition += 1
            }else {
                self.gameButtonPosition = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        randomBallColor = Int(arc4random_uniform(UInt32(ballColorsArray.count)))
        fallingBall.image = UIImage(named: ballColorsArray[randomBallColor])
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
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
