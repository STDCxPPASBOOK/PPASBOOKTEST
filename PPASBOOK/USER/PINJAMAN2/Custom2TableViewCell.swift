//
//  Custom2TableViewCell.swift
//  PPASBOOK
//
//  Created by STDC_20 on 12/08/2024.
//

import UIKit

class Custom2TableViewCell: UITableViewCell {

    func configure(with item: CustomFormItem2) {
            textLabel?.text = item.nama
            detailTextLabel?.text = "\(item.status) - \(item.bandar)"
        }
        

    let textLabelCustom = UILabel()
        let numberLabel = UILabel()
    let pickerLabel = UILabel() // New label for picker selection
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            // Configure the text label
                    textLabelCustom.translatesAutoresizingMaskIntoConstraints = false
                    textLabelCustom.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                    contentView.addSubview(textLabelCustom)
                    
                    // Configure the number label
                    numberLabel.translatesAutoresizingMaskIntoConstraints = false
                    numberLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                    contentView.addSubview(numberLabel)
                    
                    // Configure the picker label
                    pickerLabel.translatesAutoresizingMaskIntoConstraints = false
                    pickerLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                    pickerLabel.textColor = .gray
                    contentView.addSubview(pickerLabel)
                    
                    // Set up constraints for all labels
                    NSLayoutConstraint.activate([
                        textLabelCustom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                        textLabelCustom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                        textLabelCustom.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                        
                        numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                        numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                        numberLabel.topAnchor.constraint(equalTo: textLabelCustom.bottomAnchor, constant: 5),
                        
                        pickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                        pickerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                        pickerLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5),
                        pickerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
                    ])
                }
                
                required init?(coder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
                }
            }
