import UIKit

class AddOnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        
        tableView1.dataSource = self
        tableView1.delegate = self
        
        // Initial setup for the steppers
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
        
        // Set the initial value of the text fields
        valueTextField1.text = "\(Int(stepper1.value))"
        valueTextField2.text = "\(Int(stepper2.value))"
        valueTextField3.text = "\(Int(stepper3.value))"
        
        // Set the keyboard type to number pad
        valueTextField1.keyboardType = .numberPad
        valueTextField2.keyboardType = .numberPad
        valueTextField3.keyboardType = .numberPad
        
        // Make the text field's corners rounded
        textField1.layer.cornerRadius = 10.0
        
        // Make the button's corners rounded
        ButtonApply.layer.cornerRadius = 10.0
    }
    
    
    
    @IBAction func stepperValueChanged1(_ sender: UIStepper) {
        // Update the text field with the current value of the stepper
        valueTextField1.text = "\(Int(sender.value))"
    }
    
    @IBAction func stepperValueChanged2(_ sender: UIStepper) {
        // Update the text field with the current value of the stepper
        valueTextField2.text = "\(Int(sender.value))"
    }
    
    @IBAction func stepperValueChanged3(_ sender: UIStepper) {
        // Update the text field with the current value of the stepper
        valueTextField3.text = "\(Int(sender.value))"
    }
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    // Cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell2", for: indexPath)
        
        // Remove any subviews added from previous reuse
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create a UIView to act as the inner content holder
        let innerView = UIView(frame: CGRect(x: 10, y: 5, width: cell.contentView.frame.width - 20, height: cell.contentView.frame.height - 10))
        
        innerView.backgroundColor = .white // Set the background color of the inner view
        innerView.layer.borderColor = UIColor.systemTeal.cgColor
        innerView.layer.borderWidth = 1.0
        innerView.layer.cornerRadius = 8.0
        innerView.layer.masksToBounds = true
        
        // Create and add the label to the inner view
        let label = UILabel(frame: innerView.bounds)
        label.text = data[indexPath.row]
        label.textAlignment = .center
        label.textColor = UIColor.systemTeal // Set the text color to systemTeal
        innerView.addSubview(label)
        
        // Add the inner view to the cell's content view
        cell.contentView.addSubview(innerView)
        
        // Create a custom selected background view
        let selectedBackgroundView = UIView(frame: cell.contentView.bounds)
        selectedBackgroundView.backgroundColor = .clear // Ensure it does not change color on selection
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    // Optional: Handle row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(data[indexPath.row])")
    }
}
    


