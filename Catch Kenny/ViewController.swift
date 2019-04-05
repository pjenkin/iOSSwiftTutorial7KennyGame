//
//  ViewController.swift
//  Catch Kenny
//
//  Created by Peter Jenkin on 05/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var extraKennyOops: UIImageView!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var highscoreValueLabel: UILabel!
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = Int()
    var kennyImageArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        
        
        // creating timer
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)

        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        
        // creating array of images
        kennyImageArray.append(kenny1)
        kennyImageArray.append(kenny2)
        kennyImageArray.append(kenny3)
        kennyImageArray.append(kenny4)
        kennyImageArray.append(kenny5)
        kennyImageArray.append(kenny6)
        kennyImageArray.append(kenny7)
        kennyImageArray.append(kenny8)
        kennyImageArray.append(kenny9)
        
        // oops
        extraKennyOops.isHidden = true
        // oops
        
        hideKenny() // initially hide all images but 1, even before hide timer's action
        
        // check for any high score set already
        let highscore = UserDefaults.standard.object(forKey: "highscore")
        
        if let newScore = highscore as? Int
        {
            highscoreValueLabel.text = String(newScore)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func increaseScores ()      // a selector function (on click image)
    {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func countDown()
    {
        counter -= 1
        timeLabel.text = "\(counter)"
        
        
        if counter == 0
        {
            timer.invalidate()
            hideTimer.invalidate()
            
            // checking high scores here
            
            if self.score > Int(highscoreValueLabel.text!)!  // NB '!'!
            {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highscoreValueLabel.text = String(self.score)
            }
            
            // alert creation
            
            
            
            
            let alert = UIAlertController(title: "Time", message: "Time's up!", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: {
                (UIAlertAction) in
                
                self.score = 0  // in handler block so refer back out to ViewController class
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
            })      // NB using handler this time
            
            alert.addAction(replay)
            // handle replay interaction with 'replay' action handler code 
            // for 'replay' button next to 'ok' button
            
            self.present(alert, animated: true, completion: nil)
        }
    }

    /// hide all kennys but 1
    func hideKenny()
    {
        for kenny in kennyImageArray
        {
            kenny.isHidden = true
        }
    
        let randomNumber = Int(arc4random_uniform(UInt32(kennyImageArray.count - 1)))
    
        kennyImageArray[randomNumber].isHidden = false   // un-hide 1 randomly selected image
}


}

