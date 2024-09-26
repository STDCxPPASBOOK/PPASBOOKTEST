import UIKit
import PassKit

class AddOnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PKPaymentAuthorizationViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var selectedDate: Date?
    var label1Text: String?
    var label3Text: String?

    @IBOutlet var Label1: UILabel!
    @IBOutlet var Label3: UILabel!
    
    @IBOutlet weak var startTimeTextField: UITextField! // TextField untuk masa mula
    @IBOutlet weak var endTimeTextField: UITextField!   // TextField untuk masa tamat
    
    @IBOutlet weak var Cup1: UIImageView!
    @IBOutlet weak var Wifi2: UIImageView!
    @IBOutlet weak var Toilet3: UIImageView!
    @IBOutlet weak var Prayer4: UIImageView!

    @IBOutlet weak var valueTextField1: UITextField!
    @IBOutlet weak var valueTextField2: UITextField!
    @IBOutlet weak var valueTextField3: UITextField!

    @IBOutlet weak var stepper1: UIStepper!
    @IBOutlet weak var stepper2: UIStepper!
    @IBOutlet weak var stepper3: UIStepper!

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var ButtonApply: UIButton!

    @IBOutlet weak var tableView1: UITableView!

    // Data untuk table view
    let data = ["Projektor", "Sistem Siar Raya", "Table Air Chair", "Ruangan Menunggu VIP"]

    // Pilihan masa
    let hoursArray = Array(1...12) // 1 hingga 12 jam untuk format 12 jam
    let minutesArray = Array(0...59) // 0 hingga 59 minit
    let periodsArray = ["AM", "PM"] // AM dan PM untuk format 12 jam
    
    let timePicker = UIPickerView() // UIPickerView untuk masa
    var activeTextField: UITextField? // Untuk menyimpan text field yang aktif

    var selectedHour: Int = 1 // Nilai jam yang dipilih
    var selectedMinute: Int = 0 // Nilai minit yang dipilih
    var selectedPeriod: String = "AM" // Nilai AM atau PM yang dipilih
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtonApply.clipToA()

        // Konfigurasi untuk UIPickerView
        timePicker.delegate = self
        timePicker.dataSource = self
        
        // Tetapkan UIPickerView sebagai inputView untuk startTimeTextField dan endTimeTextField
        startTimeTextField.inputView = timePicker
        endTimeTextField.inputView = timePicker
        
        // Tetapkan delegate kepada diri sendiri supaya dapat kesan text field yang aktif
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
        
        // Menetapkan nilai label jika ada
        if let label1Text = label1Text {
            Label1.text = label1Text
        }

        if let label3Text = label3Text {
            Label3.text = label3Text
        }

        // Menetapkan table view data source dan delegate
        tableView1.dataSource = self
        tableView1.delegate = self
    }

    // MARK: UIPickerViewDelegate & UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Tiga komponen: jam, minit, dan AM/PM
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hoursArray.count // Jumlah pilihan jam
        case 1:
            return minutesArray.count // Jumlah pilihan minit
        case 2:
            return periodsArray.count // AM dan PM
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(hoursArray[row])" // Tunjukkan jam
        case 1:
            return String(format: "%02d", minutesArray[row]) // Tunjukkan minit dengan format dua angka
        case 2:
            return periodsArray[row] // Tunjukkan AM atau PM
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedHour = hoursArray[row] // Tetapkan jam yang dipilih
        case 1:
            selectedMinute = minutesArray[row] // Tetapkan minit yang dipilih
        case 2:
            selectedPeriod = periodsArray[row] // Tetapkan AM atau PM yang dipilih
        default:
            break
        }
        
        // Formatkan masa untuk teks field yang aktif (dalam format 12 jam)
        let formattedTime = String(format: "%02d:%02d %@", selectedHour, selectedMinute, selectedPeriod)
        activeTextField?.text = formattedTime
        
        // Tutup pemilih
        activeTextField?.resignFirstResponder()
    }

    // MARK: UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField // Simpan text field yang sedang aktif
    }
    
    // Stepper untuk menukar nilai
    @IBAction func stepperValueChanged1(_ sender: UIStepper) {
        valueTextField1.text = "\(Int(sender.value))"
    }

    @IBAction func stepperValueChanged2(_ sender: UIStepper) {
        valueTextField2.text = "\(Int(sender.value))"
    }

    @IBAction func stepperValueChanged3(_ sender: UIStepper) {
        valueTextField3.text = "\(Int(sender.value))"
    }

    // TableView Data Source & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell2", for: indexPath)
        cell.textLabel?.text = data[indexPath.row] // Memaparkan data pada sel
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(data[indexPath.row])")
    }

    // Fungsi untuk Apple Pay
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        if PKPaymentAuthorizationViewController.canMakePayments() {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.com.example.yourapp"
            request.supportedNetworks = [.visa, .masterCard, .amex]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "MY"
            request.currencyCode = "MYR"
            request.paymentSummaryItems = [
                PKPaymentSummaryItem(label: "Item", amount: NSDecimalNumber(string: "10.00"))
            ]

            let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request)
            paymentVC?.delegate = self
            if let paymentVC = paymentVC {
                present(paymentVC, animated: true, completion: nil)
            }
        } else {
            print("Apple Pay tidak tersedia pada peranti ini.")
        }
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}

extension UIButton {
    func clipToA() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.systemTeal.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
