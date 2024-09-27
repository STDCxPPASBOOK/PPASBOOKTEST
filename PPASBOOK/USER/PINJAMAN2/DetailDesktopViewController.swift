//
//  DetailDesktopViewController.swift
//  PPASBOOK
//
//  Created by STDC_20 on 12/08/2024.
//

import UIKit

class DetailDesktopViewController: UIViewController {

    var item: CustomFormItem2?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var icLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var postalCodeLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var districtLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            nameLabel.text = item.nama
            icLabel.text = item.noIc
            addressLabel.text = item.alamat
            postalCodeLabel.text = item.poskod
            cityLabel.text = item.bandar
            districtLabel.text = item.daerah
            emailLabel.text = item.emel
            phoneLabel.text = item.noTel
            statusLabel.text = item.status
        }
        
        // Apply borders to all labels
        let labels = [nameLabel, icLabel, addressLabel, postalCodeLabel, cityLabel, districtLabel, emailLabel, phoneLabel, statusLabel]
        for label in labels {
            applyBorder(to: label)
        }
    }
    
    // Function to apply a border to a UILabel
    func applyBorder(to label: UILabel?) {
        guard let label = label else { return }
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 7.0
        label.layer.masksToBounds = true
    }
}
