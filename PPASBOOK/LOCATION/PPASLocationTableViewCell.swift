//
//  PPASLocationTableViewCell.swift
//  PPASBOOK
//
//  Created by STDC_14 on 09/07/2024.
//

import UIKit

class PPASLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var operationHoursLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        districtLabel.translatesAutoresizingMaskIntoConstraints = false
        operationHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

