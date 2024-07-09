import UIKit

class RQViewController: UIViewController {

    @IBOutlet var ProgressView: UIProgressView!
    @IBOutlet var nextButton: UIButton!
    
    var progressValue: Float = 0.1 // Nilai default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.progress = progressValue
    }
    
    @IBAction func unwindToRQViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? LRRViewController {
            self.progressValue = sourceVC.progressValue
            ProgressView.progress = progressValue
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        progressValue += 0.1
        ProgressView.progress = progressValue
        performSegue(withIdentifier: "goToLRRViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLRRViewController" {
            if let destinationVC = segue.destination as? LRRViewController {
                destinationVC.progressValue = self.progressValue
            }
        }
    }
}
