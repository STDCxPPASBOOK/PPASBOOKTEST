import UIKit

class PPASLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
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
        PPASLocation(name: "PPAS Tun Raja Uda", district: "Shah Alam", operationHours: [
            "Monday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            "Tuesday": OperationHours(open: "08:00", close: "18:00", breakStart: "12:00", breakEnd: "13:00"),
            // Add other days
        ]),
        // Add other locations
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ppasLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PPASCell", for: indexPath) as! PPASLocationTableViewCell
        let location = ppasLocations[indexPath.row]
        
        cell.titleLabel.text = location.name
        cell.districtLabel.text = location.district
        cell.operationHoursLabel.text = getCurrentDayOperationHours(for: location)
        
        let status = getCurrentDayOperationStatus(for: location)
        cell.statusLabel.text = status
        switch status {
        case "Closing Soon":
            cell.statusLabel.textColor = UIColor.yellow
        case "Closed":
            cell.statusLabel.textColor = UIColor.red
        default:
            cell.statusLabel.textColor = UIColor.green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = ppasLocations[indexPath.row]
        openLocationInMaps(location: location)
    }
    
    func openLocationInMaps(location: PPASLocation) {
        let address = location.name.replacingOccurrences(of: " ", with: "+")
        if let url = URL(string: "comgooglemaps://?q=\(address)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // If Google Maps is not installed, open in default maps
                let urlString = "http://maps.apple.com/?q=\(address)"
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func getCurrentDayOperationHours(for location: PPASLocation) -> String {
        // Implement your logic to get operation hours for the current day
        return "08:00 - 18:00"
    }
    
    func getCurrentDayOperationStatus(for location: PPASLocation) -> String {
        // Implement your logic to get operation status for the current day
        return "Open"
    }
}
