import UIKit
import PassKit // Import PassKit untuk Apple Pay

class AddOnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PKPaymentAuthorizationViewControllerDelegate {

    var selectedDate: Date?

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

    let data = ["Projektor", "Sistem Siar Raya", "Table Air Chair", "Ruangan Menunggu VIP"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Contoh penggunaan selectedDate
        if let date = selectedDate {
            print("Tarikh yang dipilih: \(date)")
        }

        tableView1.dataSource = self
        tableView1.delegate = self

        // Konfigurasi awal untuk steppers
        stepper1.minimumValue = 0
        stepper1.maximumValue = 100
        stepper1.stepValue = 1
        stepper1.value = 0

        stepper2.minimumValue = 0
        stepper2.maximumValue = 100
        stepper2.stepValue = 1
        stepper2.value = 0

        stepper3.minimumValue = 0
        stepper3.maximumValue = 100
        stepper3.stepValue = 1
        stepper3.value = 0

        // Set nilai awal untuk text fields
        valueTextField1.text = "\(Int(stepper1.value))"
        valueTextField2.text = "\(Int(stepper2.value))"
        valueTextField3.text = "\(Int(stepper3.value))"

        // Tukar jenis papan kekunci kepada number pad
        valueTextField1.keyboardType = .numberPad
        valueTextField2.keyboardType = .numberPad
        valueTextField3.keyboardType = .numberPad

        // Buat bucu text field bulat
        textField1.layer.cornerRadius = 10.0

        // Buat bucu butang bulat
        ButtonApply.layer.cornerRadius = 10.0
    }

    @IBAction func stepperValueChanged1(_ sender: UIStepper) {
        // Kemas kini nilai text field mengikut nilai semasa stepper
        valueTextField1.text = "\(Int(sender.value))"
    }

    @IBAction func stepperValueChanged2(_ sender: UIStepper) {
        valueTextField2.text = "\(Int(sender.value))"
    }

    @IBAction func stepperValueChanged3(_ sender: UIStepper) {
        valueTextField3.text = "\(Int(sender.value))"
    }

    // Jumlah baris dalam seksyen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    // Sel untuk setiap baris pada index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell2", for: indexPath)
        
        // Kosongkan subviews sebelumnya
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let innerView = UIView(frame: CGRect(x: 10, y: 5, width: cell.contentView.frame.width - 20, height: cell.contentView.frame.height - 10))
        innerView.backgroundColor = .white
        innerView.layer.borderColor = UIColor.systemTeal.cgColor
        innerView.layer.borderWidth = 1.0
        innerView.layer.cornerRadius = 8.0
        innerView.layer.masksToBounds = true

        let label = UILabel(frame: innerView.bounds)
        label.text = data[indexPath.row]
        label.textAlignment = .center
        label.textColor = UIColor.systemTeal
        innerView.addSubview(label)

        cell.contentView.addSubview(innerView)

        let selectedBackgroundView = UIView(frame: cell.contentView.bounds)
        selectedBackgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(data[indexPath.row])")
    }

    // Fungsi untuk menguruskan pembayaran Apple Pay
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        if PKPaymentAuthorizationViewController.canMakePayments() {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.com.example.yourapp"
            request.supportedNetworks = [.visa, .masterCard, .amex]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "MY" // Kod negara
            request.currencyCode = "MYR" // Kod mata wang
            request.paymentSummaryItems = [
                PKPaymentSummaryItem(label: "Item", amount: NSDecimalNumber(string: "10.00")),
                PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "10.00"))
            ]

            if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) {
                paymentVC.delegate = self
                present(paymentVC, animated: true, completion: nil)
            } else {
                print("Tidak dapat memaparkan Apple Pay")
            }
        } else {
            print("Apple Pay tidak tersedia di peranti ini.")
        }
    }

    // Delegate untuk memproses status pembayaran
    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Proses pembayaran di sini
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
