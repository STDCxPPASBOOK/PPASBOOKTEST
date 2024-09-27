import UIKit

class AA2ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Outlets for text fields
    @IBOutlet var NamaLabel1: UITextField!
    @IBOutlet var NoIcLabel2: UITextField!
    @IBOutlet var AlamatLabel3: UITextField!
    @IBOutlet var PoskodLabel4: UITextField!
    @IBOutlet var BandarLabel5: UITextField!
    @IBOutlet var PickerDaerah: UIPickerView!
    @IBOutlet var EmelLabel6: UITextField!
    @IBOutlet var NoTelLabel7: UITextField!
    @IBOutlet var PickerStatus: UIPickerView!
    @IBOutlet var BookNow: UIButton!

    // Programmatic UILabel for showing messages
    var infoLabel: UILabel!

    // Data for pickers
    let data1 = ["Petaling", "Hulu Langat", "Klang", "Gombak", "Kuala Langat", "Sepang", "Kuala Selangor", "Hulu Selangor", "Sabak Bernam"]
    let data2 = ["Pelajar Sekolah", "Pelajar STPM/Pra-U", "Pelajar IPTA/IPTS/Kolej", "Bekerja"]

    // Variables to hold selected values from pickers
    var selectedDaerah: String?
    var selectedStatus: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize and configure infoLabel programmatically
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false // Use Auto Layout
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textColor = .systemGreen
        view.addSubview(infoLabel) // Add label to the view hierarchy

        // Set constraints for infoLabel
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: BookNow.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Set the delegates and data sources for the picker views
        PickerDaerah.delegate = self
        PickerDaerah.dataSource = self
        PickerStatus.delegate = self
        PickerStatus.dataSource = self

        // Set keyboard types for text fields
        NoTelLabel7.keyboardType = .numberPad
        PoskodLabel4.keyboardType = .numberPad
        EmelLabel6.keyboardType = .emailAddress

        // Set default values for pickers
        selectedDaerah = data1.first
        selectedStatus = data2.first

        // Add gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fadeOutInfoLabel()
        
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func unwindToFormViewController(segue: UIStoryboardSegue) {
    }

    @IBAction func showDataButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "BookingNowDataSegue2", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookingNowDataSegue2" {
            if segue.destination is ShowForm2ViewController {
                // No need to pass anything, since ShowFormViewController fetches data from FormArray
            }
        }
    }
    
    private func fadeOutInfoLabel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.infoLabel.alpha = 0.0 // Make the label fully transparent
        }) { _ in
            self.infoLabel.isHidden = true // Hide the label after animation completes
        }
    }


    // Handle the 'Book Now' button tap
    @IBAction func bookNowTapped(_ sender: UIButton) {
        // Creating a confirmation alert
        let alertController = UIAlertController(
            title: "Pengesahan",
            message: "Anda yakin ingin membuat permohonan?",
            preferredStyle: .alert
        )

        // "Yes" button
        let confirmAction = UIAlertAction(title: "Ya", style: .default) { _ in
            self.handleBooking()
        }

        // "No" button
        let cancelAction = UIAlertAction(title: "Tidak", style: .cancel, handler: nil)

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        // Display the alert
        present(alertController, animated: true, completion: nil)
    }

    // Method to handle booking after confirmation
    private func handleBooking() {
        guard let nama = NamaLabel1.text, !nama.isEmpty else {
            showAlert(message: "Sila Masukkan Nama Anda.")
            return
        }
        guard let noIc = NoIcLabel2.text, !noIc.isEmpty else {
            showAlert(message: "Sila Masukkan Nombor Kad Pengenalan Anda.")
            return
        }
        guard let alamat = AlamatLabel3.text, !alamat.isEmpty else {
            showAlert(message: "Sila Masukkan Alamat Anda.")
            return
        }
        guard let poskod = PoskodLabel4.text, !poskod.isEmpty else {
            showAlert(message: "Sila Masukkan Poskod.")
            return
        }
        guard let bandar = BandarLabel5.text, !bandar.isEmpty else {
            showAlert(message: "Sila Masukkan Bandar.")
            return
        }
        guard let daerah = selectedDaerah else {
            showAlert(message: "Sila Pilih Daerah.")
            return
        }
        guard let emel = EmelLabel6.text, !emel.isEmpty else {
            showAlert(message: "Sila Masukkan Emel Anda.")
            return
        }
        guard let noTel = NoTelLabel7.text, !noTel.isEmpty else {
            showAlert(message: "Sila Masukkan Nombor Telefon Anda.")
            return
        }
        guard let status = selectedStatus else {
            showAlert(message: "Sila Pilih Status Anda.")
            return
        }
        
        let data = "PC"

        // Save all inputs, including the picker view selections
        CustomFormArray.shared.addItem(
            nama: nama,
            noIc: noIc,
            alamat: alamat,
            poskod: poskod,
            bandar: bandar,
            daerah: daerah,
            emel: emel,
            noTel: noTel,
            status: status,
            data: data
        )

        clearFields()

        // Update the programmatic infoLabel
        infoLabel.text = "Data saved. Go to the next screen."
        
        // Perform segue after saving the data
        performSegue(withIdentifier: "BookingNowDataSegue", sender: nil)
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == PickerDaerah {
            return data1.count
        } else if pickerView == PickerStatus {
            return data2.count
        } else {
            return 0
        }
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == PickerDaerah {
            return data1[row]
        } else if pickerView == PickerStatus {
            return data2[row]
        } else {
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == PickerDaerah {
            selectedDaerah = data1[row]
        } else if pickerView == PickerStatus {
            selectedStatus = data2[row]
        }
    }

    // Method to show an alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // Method to clear all input fields
    private func clearFields() {
        NamaLabel1.text = ""
        NoIcLabel2.text = ""
        AlamatLabel3.text = ""
        PoskodLabel4.text = ""
        BandarLabel5.text = ""
        EmelLabel6.text = ""
        NoTelLabel7.text = ""
        selectedDaerah = data1.first
        selectedStatus = data2.first
        PickerDaerah.selectRow(0, inComponent: 0, animated: true)
        PickerStatus.selectRow(0, inComponent: 0, animated: true)
    }
}
