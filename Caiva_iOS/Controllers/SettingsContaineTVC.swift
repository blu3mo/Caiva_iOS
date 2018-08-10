//
//  SettingsContaineViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/08.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
import AlertHelperKit

class SettingsContaineViewController: UITableViewController {
    
    @IBOutlet weak var voiceTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let voiceTypeUD = UserDefaults.standard.integer(forKey: "voiceType")
        if voiceTypeUD == 0 {
            voiceTypeLabel.text = "Male"
        } else {
            voiceTypeLabel.text = "Female"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                showVoiceSelectAlert()
            }
        case 1:
            if indexPath.row == 0 {
                
            }
        default:
            return
        }
    }
    
    func showVoiceSelectAlert() {
        let params = Parameters(
            cancelButton: "Cancel",
            destructiveButtons: [],
            otherButtons: ["Male", "Female"],
            sender: self,
            arrowDirection: .up
        )
        AlertHelperKit().showActionSheet(self, parameters: params, handler: { (index) in
            if index == 1 {
                UserDefaults.standard.set(0, forKey: "voiceType")
                self.voiceTypeLabel.text = "Male"
            } else if index == 2 {
                UserDefaults.standard.set(1, forKey: "voiceType")
                self.voiceTypeLabel.text = "Female"
            }
        })
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
