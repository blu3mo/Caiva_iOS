//
//  ScreenSessionViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/07.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
import VisualEffectView

class ScreenSessionViewController: UIViewController {
    
    var startTime = Date()
    
    var lastCardUUID: UUIDString = ""
    
    var timer = Timer()
    var gradientTimerCount = 0
    var gradientTimerLimit = 0
    
    @IBOutlet var bgView: GradientView!
    @IBOutlet weak var bgViewCopy: GradientView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var blurViewContainer: VisualEffectView!
    
    var mustStopAudio = false
    
    let cardset: Cardset = Cardset.currentCardset!
    //@IBOutlet weak var blurView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgViewCopy.isHidden = false
        
        setBlur()
        
        playSession()
    }
    
    func setBlur() {
        blurViewContainer.blurRadius = 30
    }
    
    func playSession() {
        let didSpoke = SpeechHelper.shared.speakLoop(loopData: SessionService.createAudioResource(from: cardset), voiceType: .standardFemale, eachPrepare: {cardUUID in
            let playingCard = self.cardset.cards.filter{$0.uuid == cardUUID}.first!
            if playingCard.uuid != self.lastCardUUID {
                self.lastCardUUID = playingCard.uuid
                
                self.questionLabel.text = playingCard.front
                self.answerLabel.text = playingCard.back
                
                RealmHelper.setDegree(on: playingCard, value: playingCard.degree + 0.01)
                
                let usingGradient = Gradients.colors[playingCard.colorID]
                self.changeBG(new: usingGradient)
                
                self.setBlur()
                self.scheduledTimerWithTimeInterval(limit: 60)
                //playingCard.front.count * 2)
            } else {
            }
            
        }, completion: {
            //self.performSegue(withIdentifier: "endSession", sender: nil)
            if !(self.mustStopAudio) {
                self.playSession()
            }
        })
    }
    
    func changeBG(new: (UIColor?, UIColor?)) {
        bgViewCopy.topColor = new.0!
        bgViewCopy.bottomColor = new.1!
        bgViewCopy.alpha = 0.0
        bgViewCopy.isHidden = false
//        bgViewCopy.setNeedsLayout()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bgViewCopy.alpha = 1.0
        }, completion: { _ in
            self.bgViewCopy.isHidden = true
            self.bgView.topColor = new.0!
            self.bgView.bottomColor = new.1!
        })
    }
    
    func scheduledTimerWithTimeInterval(limit: Int){
        gradientTimerCount = 0
        gradientTimerLimit = limit
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.07, target: self, selector: #selector(self.decreaseBlur), userInfo: nil, repeats: true)
    }
    
    @objc func decreaseBlur() {
        if gradientTimerCount >= gradientTimerLimit {
            if timer.isValid {
                timer.invalidate()
            }
            return
        }
        blurViewContainer.blurRadius -= 0.5
        gradientTimerCount += 1
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        mustStopAudio = true
        SpeechHelper.shared.stopSpeakLoop()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endSession" {
            let nextVC = segue.destination as! SessionResultViewController
            nextVC.timeString = Util.getTimeText(from: Int(Date().timeIntervalSince(startTime)))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
