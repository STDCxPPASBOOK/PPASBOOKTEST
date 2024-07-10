import UIKit

class PPASLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var filter: UIButton!
    
    let ppasLocations = [
        PPASLocation(name: "PPAS Tun Raja Uda", district: "Shah Alam", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Sungai Udang", district: "Klang", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Daerah Gombak", district: "Gombak", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        // Add other locations
        PPASLocation(name: "PPAS Bangi", district: "Hulu Langat", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Bukit Beruntung", district: "Hulu Selangor", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Sungai Merah", district: "Kajang", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Cawangan Kajang", district: "Kajang", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),PPASLocation(name: "PPAS Pelabuhan Klang", district: "Klang", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),PPASLocation(name: "PPAS Daerah Klang", district: "Klang", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Daerah Kuala Langat", district: "Kuala Langat", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Daerah Kuala Selangor", district: "Kuala Selangor", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Kampung Lindungan", district: "Petaling", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Sri Manja Petaling Jaya", district: "Petaling", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Pekan Dataran Sabak Bernam", district: "Sabak Bernam", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Daerah Sabak Bernam", district: "Shah Alam", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        PPASLocation(name: "PPAS Pekan Sungai Pelek", district: "Sepang", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
    ]
    
    let filterOptions = ["Semua", "Shah Alam", "Klang", "Gombak","Hulu Langat","Kuala Selangor","Hulu Selangor","Sepang","Sabak Bernam","Petaling","Kajang"] // Tambah pilihan penapis lain
        var filteredLocations: [PPASLocation] = []
        var dropdownTableView: UITableView!
        var isDropdownVisible = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 100
            tableView.estimatedRowHeight = 100
            filteredLocations = ppasLocations
            
            // Sesuaikan butang penapis
            setupFilterButton()
            
            // Tetapkan jadual dropdown
            setupDropdownTableView()
        }

        func setupFilterButton() {
            filter.layer.borderColor = UIColor.black.cgColor
            filter.layer.borderWidth = 1.0
            filter.layer.cornerRadius = 10.0
            filter.clipsToBounds = true
            
            // Tambah tindakan untuk butang penapis
            filter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        }

        @objc func filterButtonTapped() {
            isDropdownVisible.toggle()
            dropdownTableView.isHidden = !isDropdownVisible
        }
        
        func setupDropdownTableView() {
            dropdownTableView = UITableView()
            dropdownTableView.dataSource = self
            dropdownTableView.delegate = self
            dropdownTableView.isHidden = true
            dropdownTableView.layer.borderColor = UIColor.black.cgColor
            dropdownTableView.layer.borderWidth = 1.0
            dropdownTableView.layer.cornerRadius = 10.0
            dropdownTableView.clipsToBounds = true
            
            view.addSubview(dropdownTableView)
            
            dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
            dropdownTableView.topAnchor.constraint(equalTo: filter.bottomAnchor).isActive = true
            dropdownTableView.leadingAnchor.constraint(equalTo: filter.leadingAnchor).isActive = true
            dropdownTableView.trailingAnchor.constraint(equalTo: filter.trailingAnchor).isActive = true
            dropdownTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true // Sesuaikan ketinggian mengikut keperluan
        }
        
        // Kaedah-kaedah UITableViewDataSource dan UITableViewDelegate untuk jadual dropdown
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableView == dropdownTableView {
                return filterOptions.count
            } else {
                return filteredLocations.count
            }
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if tableView == dropdownTableView {
                let cell = UITableViewCell()
                cell.textLabel?.text = filterOptions[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PPASCell", for: indexPath) as! PPASLocationTableViewCell
                let location = filteredLocations[indexPath.row]
                
                cell.titleLabel.text = location.name
                cell.districtLabel.text = location.district
                cell.operationHoursLabel.text = getCurrentDayOperationHours(for: location)
                
                let status = getCurrentDayOperationStatus(for: location)
                cell.statusLabel.text = status
                switch status {
                case "Tutup Sebentar Lagi":
                    cell.statusLabel.textColor = UIColor.yellow
                case "Tutup":
                    cell.statusLabel.textColor = UIColor.red
                default:
                    cell.statusLabel.textColor = UIColor.green
                }
                
                return cell
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if tableView == dropdownTableView {
                let selectedFilter = filterOptions[indexPath.row]
                filter.setTitle(selectedFilter, for: .normal)
                // Lakukan penapisan berdasarkan pilihan yang dipilih
                filterLocations(by: selectedFilter)
                dropdownTableView.isHidden = true
                isDropdownVisible = false
            } else {
                let location = filteredLocations[indexPath.row]
                openLocationInMaps(location: location)
            }
        }
        
        func filterLocations(by filter: String) {
            if filter == "Semua" {
                filteredLocations = ppasLocations
            } else {
                filteredLocations = ppasLocations.filter { $0.district == filter }
            }
            tableView.reloadData()
        }
        
        func openLocationInMaps(location: PPASLocation) {
            let address = location.name.replacingOccurrences(of: " ", with: "+")
            if let url = URL(string: "comgooglemaps://?q=\(address)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Jika Google Maps tidak dipasang, buka dalam peta lalai
                    let urlString = "http://maps.apple.com/?q=\(address)"
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
        
        func getCurrentDayOperationHours(for location: PPASLocation) -> String {
            // Laksanakan logik anda untuk mendapatkan waktu operasi untuk hari ini
            return "08:00 - 18:00"
        }
        
        func getCurrentDayOperationStatus(for location: PPASLocation) -> String {
            // Laksanakan logik anda untuk mendapatkan status operasi untuk hari ini
            return "Buka"
        }
    }
