//
//  DesktopsInfoViewController.swift
//  progress
//
//  Created by STDC_20 on 21/06/2024.
//

import UIKit

class DesktopsInfoViewController: UIViewController {

    @IBOutlet var ProgressView: UIProgressView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var progressValue: Float = 0.6 // Nilai default, akan diganti saat segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.progress = progressValue
    }
    
    @IBAction func PreviousButton(_ sender: UIButton) {
        progressValue -= 0.1
        ProgressView.progress = progressValue
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        progressValue += 0.1
        ProgressView.progress = progressValue
    }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


