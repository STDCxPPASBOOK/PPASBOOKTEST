//
//  ShowForm2ViewController.swift
//  PPASBOOK
//
//  Created by STDC_20 on 12/08/2024.
//

import UIKit

class ShowForm2ViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var formItems: [CustomFormItem] = []
    var filteredFormItems: [CustomFormItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set a larger row height
            tableView.rowHeight = 60 // Adjust this value as needed
        
        // Muat data dari array borang yang dikongsi
        formItems = CustomFormArray.shared.getItems()
        filteredFormItems = formItems
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        setupSegmentedControl()
    }
    
    @IBAction func unwindToShowFormViewController(segue: UIStoryboardSegue) {
        if segue.source is DetailDesktopViewController {
            // Handle unwinding actions if needed
        }
    }
    
    // In ShowFormViewController

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = filteredFormItems[indexPath.row]
        
        // Perform segue or push view controller
        performSegue(withIdentifier: "showDetailSegue", sender: selectedItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let detailVC = segue.destination as? DetailDesktopViewController,
               let selectedItem = sender as? CustomFormItem2 {
                detailVC.item = selectedItem 
                // Pass the selected item to the detail view controller
            }
        }
    }
    
    func setupSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["ALL", "FASILITI", "LAPTOP","PC","BOOKFLY2U"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        // Adjust the frame of the segmented control
        let headerHeight: CGFloat = 45 // Height of the header view
        let offset: CGFloat = 0 // Move the control up by 10 points
        
        // Set the width as needed
        let segmentedControlWidth: CGFloat = tableView.frame.width - 0
        
        // Example: padding of 20 on each side
        segmentedControl.frame = CGRect(x: 0 , y: offset, width: segmentedControlWidth, height: headerHeight)
        
        // Set font size and other attributes
            let font = UIFont.systemFont(ofSize: 11) // Change the font size as needed
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.black // Optional: Set the text color
            ]
            segmentedControl.setTitleTextAttributes(attributes, for: .normal)
            

            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
            headerView.addSubview(segmentedControl)

            tableView.tableHeaderView = headerView
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filteredFormItems = formItems
        case 1:
            filteredFormItems = formItems.filter { $0.data.contains("FASILITI") }
        case 2:
            filteredFormItems = formItems.filter { $0.data.contains("LAPTOP") }
        case 3:
            filteredFormItems = formItems.filter { $0.data.contains("PC") }
        case 4:
            filteredFormItems = formItems.filter { $0.data.contains("BOOKFLY2U") }
        default:
            break
        }
        
        // Debug: Cetak data yang ditapis
        print("Item ditapis: \(filteredFormItems)")
        
        tableView.reloadData()
    }
    
    // Metode UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFormItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Tidak dapat menempatkan CustomTableViewCell")
        }

        let item = filteredFormItems[indexPath.row]
        cell.configure(with: item)

        return cell
    }
}

