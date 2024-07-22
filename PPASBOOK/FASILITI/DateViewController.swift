import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet var warna1: UIView!
    @IBOutlet var warna2: UIView!
    @IBOutlet var warna3: UIView!
    
    var data: YourDataModel? // Properti untuk menyimpan data yang diterima

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCalendar()
        configureButtonShadows()
        

        // Reload data if it's updated or reset
        if let data = data {
            label1.text = data.label1Text
        }
    }
    
    private func configureButtonShadows() {
        warna1.layer.cornerRadius = warna1.frame.height / 2
        warna2.layer.cornerRadius = warna2.frame.height / 2
        warna3.layer.cornerRadius = warna3.frame.height / 2
        
    }

    func createCalendar() {
        view.backgroundColor = .systemBackground
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.layer.cornerRadius = 12
        calendarView.backgroundColor = .systemGray6
        view.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 420),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToDetailViewController" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.data = self.data
            }
        }
    }
}

extension DateViewController: UICalendarViewDelegate, UICollectionViewDelegateFlowLayout {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
