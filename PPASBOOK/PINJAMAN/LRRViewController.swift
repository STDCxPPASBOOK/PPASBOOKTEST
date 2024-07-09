import UIKit

class LRRViewController: UIViewController {

    @IBOutlet var ProgressView: UIProgressView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var progressValue: Float = 0.2 // Nilai default, akan diganti saat segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.progress = progressValue
    }
    
    @IBAction func PreviousButton(_ sender: UIButton) {
        progressValue -= 0.1
        ProgressView.progress = progressValue
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        progressValue += 0.1
        ProgressView.progress = progressValue
        performSegue(withIdentifier: "goToAAViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAAViewController" {
            if let destinationVC = segue.destination as? AAViewController {
                destinationVC.progressValue = self.progressValue
            }
        }
    }
    
    // Di LRRViewController.swift

    @IBAction func unwindToLRRViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AAViewController {
            self.progressValue = sourceVC.progressValue
            ProgressView.progress = progressValue
        }
    }


}
