import UIKit

class AddOnViewController: UIViewController {

    @IBOutlet weak var Cup1: UIImageView!
    @IBOutlet weak var Wifi2: UIImageView!
    @IBOutlet weak var Toilet3: UIImageView!
    @IBOutlet weak var Prayer4: UIImageView!

    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var stepper1: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial setup for the stepper
                stepper1.minimumValue = 0
                stepper1.maximumValue = 100
                stepper1.stepValue = 1
                stepper1.value = 0
                
                // Set the initial value of the label
                valueLabel.text = "\(Int(stepper1.value))"
    }
    
    @IBAction func stepperValueChanged1(_ sender: UIStepper) {
        // Update the label with the current value of the stepper
          valueLabel.text = "\(Int(sender.value))"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
