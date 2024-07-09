//
//  DekstopViewController.swift
//  progress
//
//  Created by STDC_20 on 21/06/2024.
//

import UIKit

class DekstopViewController: UIViewController {
    
    @IBOutlet var ProgressView: UIProgressView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var progressValue: Float = 0.5 // Nilai default, akan diganti saat segue
    
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
        performSegue(withIdentifier: "goToDesktopsInfoViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDesktopsInfoViewController" {
            if let destinationVC = segue.destination as? DekstopViewController {
                destinationVC.progressValue = self.progressValue
            }
        }
    }
    
    // Di LRRViewController.swift

    @IBAction func unwindDekstopViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? DesktopsInfoViewController {
            self.progressValue = sourceVC.progressValue
            ProgressView.progress = progressValue
        }
    }


}
