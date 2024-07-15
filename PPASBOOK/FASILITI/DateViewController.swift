//
//  DateViewController.swift
//  PPASBOOK
//
//  Created by STDC_16 on 15/07/2024.
//

import UIKit

class DateViewController: UIViewController {

        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var label1: UILabel!
        @IBOutlet weak var label2: UILabel!
        @IBOutlet weak var label3: UILabel!

        var data: YourDataModel? // Properti untuk menyimpan data yang diterima

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload data if it's updated or reset
        if let data = data {
            imageView.image = UIImage(named: data.imageName)
            label1.text = data.label1Text
            label2.text = data.label2Text
            label3.text = data.label3Text
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToDetailViewController" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.data = self.data
            }
        }
    }
}

