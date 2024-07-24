//
//  FIveViewController.swift
//  progress
//
//  Created by STDC_20 on 23/07/2024.
//

import UIKit

class FiveViewController: UIViewController {
    
    @IBOutlet var mySwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
                   print("Switch is ON")
                   // Perform actions when switch is turned on
               } else {
                   print("Switch is OFF")
                   // Perform actions when switch is turned off
               }
    }
        
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSixViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSixViewController" {
        }
    }
    
    @IBAction func unwindToFiveViewController(segue: UIStoryboardSegue) {
        if segue.source is SixViewController {
            
        }
    }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

