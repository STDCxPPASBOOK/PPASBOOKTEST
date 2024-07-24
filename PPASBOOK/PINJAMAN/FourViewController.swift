//
//  FourViewController.swift
//  progress
//
//  Created by STDC_20 on 23/07/2024.
//

import UIKit

class FourViewController: UIViewController {
    
    @IBOutlet weak var checkBox1: UIButton!
    
    @IBOutlet weak var checkBox2: UIButton!
    
    @IBOutlet weak var checkBox3: UIButton!
    
    @IBOutlet weak var checkBox4: UIButton!
    
    @IBOutlet weak var checkBox5: UIButton!
    
    @IBOutlet weak var checkBox6: UIButton!
    
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func iconClicked1(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
    }
    
    @IBAction func iconClicked2(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func iconClicked3(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func iconClicked4(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func iconClicked5(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func iconClicked6(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFiveViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFiveViewController" {
        }
    }
    
    @IBAction func unwindToFourViewController(segue: UIStoryboardSegue) {
        if segue.source is FiveViewController {
            
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
