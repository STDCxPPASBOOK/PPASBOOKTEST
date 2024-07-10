//
//  ProfileViewController.swift
//  PPASBOOK
//
//  Created by STDC_15 on 10/07/2024.
//

import UIKit
import QuartzCore

class ProfileViewController: UIViewController {

    @IBOutlet var tb: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mengatur corner radius untuk tableView
           tb.layer.cornerRadius = 10
           tb.clipsToBounds = true // Penting untuk memastikan corner radius terlihat

           // Setup lainnya...
        
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
