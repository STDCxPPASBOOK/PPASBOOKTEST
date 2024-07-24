//
//  OneViewController.swift
//  progress
//
//  Created by STDC_20 on 23/07/2024.
//

import UIKit

class OneViewController: UIViewController {

    @IBOutlet var bookingNow: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bookingClicked(_ sender: UIButton) {
    }
    
    @IBAction func unwindToOneViewController(segue: UIStoryboardSegue) {
        if segue.source is TwoViewController {
            
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

}
