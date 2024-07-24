//
//  Booking1ViewController.swift
//  progress
//
//  Created by STDC_20 on 24/07/2024.
//

import UIKit

class Booking1ViewController: UIViewController {
    
    @IBOutlet var laptopButton: UIButton!
    
    @IBOutlet var desktopButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Set the size of the buttons
        //setButtonSize(button: laptopButton, width: 200, height: 50)
        //setButtonSize(button: desktopButton, width: 200, height: 50)

        // Add border to laptop button
        setupButtonBorder(button: laptopButton)
        
        // Add border to desktop button
        setupButtonBorder(button: desktopButton)

        // Do any additional setup after loading the view.
    }

    func setupButtonBorder(button: UIButton) {
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor // Set your desired color
        button.layer.cornerRadius = 10.0
        // Adjust for rounded corners
    }
    
    func setButtonSize(button: UIButton, width: CGFloat, height: CGFloat) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @IBAction func unwindToBooking1ViewController(segue: UIStoryboardSegue) {
        if segue.source is OneViewController {
            
        }
    }

}
