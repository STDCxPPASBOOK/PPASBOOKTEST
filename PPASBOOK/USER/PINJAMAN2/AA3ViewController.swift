//
//  AA3ViewController.swift
//  progress
//
//  Created by STDC_20 on 23/07/2024.
//

import UIKit

class AA3ViewController: UIViewController {
    
    @IBOutlet var mySwitch: UISwitch!
    
    @IBOutlet var nextButton: UIButton!
    

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
        performSegue(withIdentifier: "goToAA2ViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAA2ViewController" {
            
        }
    }
    
    @IBAction func unwindToAA3ViewController(segue: UIStoryboardSegue) {
        if segue.source is AA2ViewController {
            
        }
    }
}
    
