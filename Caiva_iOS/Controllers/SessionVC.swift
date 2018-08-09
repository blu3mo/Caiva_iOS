//
//  SessionViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/03.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class SessionViewController: UIViewController {
    
    @IBOutlet weak var soundVisual: UIView!
    
    var startTime = Date()
    
    var timer = Timer()
    
    var records: [Float] = []
    
    var mustStopAudio = false
    
    //let lipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    let cardset: Cardset = Cardset.currentCardset!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTime = Date()
        playSession()
//        let didSpoke = SpeechHelper.shared.speakLoop(loopData: SessionService.createAudioResource(from: cardset), voiceType: .standardFemale, completion: {
//            self.performSegue(withIdentifier: "endSession", sender: nil)
//        })
//        if !(didSpoke) {
//            self.performSegue(withIdentifier: "endSession", sender: nil)
//        }
        
        scheduledTimerWithTimeInterval()
        
//        SpeechHelper.shared.speak(text: "hello hellohello", voiceType: .waveNetMale, completion: {
//            SpeechHelper.shared.speak(text: "aaaaaaaa", voiceType: .waveNetMale, completion: {})
//        })
        // Do any additional setup after loading the view.
    }
    
    func playSession() {
        let didSpoke = SpeechHelper.shared.speakLoop(loopData: SessionService.createAudioResource(from: cardset), voiceType: .standardFemale, eachPrepare: {cardUUID in
            let playedCard = self.cardset.cards.filter{$0.uuid == cardUUID}.first!
            RealmHelper.setDegree(on: playedCard, value: playedCard.degree + 0.005)
        }, completion: {
            //self.performSegue(withIdentifier: "endSession", sender: nil)
            if !(self.mustStopAudio) {
                self.playSession()
            }
        })
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(self.updateSoundVisual), userInfo: nil, repeats: true)
    }
    
    @objc func updateSoundVisual() {
        if let player = SpeechHelper.shared.player {
            player.updateMeters()
            let averageValue = ((player.averagePower(forChannel: 0) + 120) / 120 + 1)
            print(averageValue)
            var realValue = averageValue
            if records.count != 0 {
                let allValue = averageValue * Float(records.count + 1)
                realValue = allValue - records.reduce(0.0, +)
            }
            records.append(realValue)
            print(records)
            
            if realValue <= 1 { realValue = 1 }
            
            UIView.animate(withDuration: 0.15, animations: {
            self.soundVisual.transform = CGAffineTransform(scaleX: CGFloat(realValue * 3 ), y: CGFloat(realValue * 3 ))
            })
            print(realValue)
            print("----------")
        } else {
            records = []
        }
    }
    
    @IBAction func testButtonTapped() {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endSession" {
            let nextVC = segue.destination as! SessionResultViewController
            nextVC.timeString = Util.getTimeText(from: Int(Date().timeIntervalSince(startTime)))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mustStopAudio = true
        SpeechHelper.shared.stopSpeakLoop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
