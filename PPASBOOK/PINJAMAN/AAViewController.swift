import UIKit

class AAViewController: UIViewController {

    @IBOutlet var ProgressView: UIProgressView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var progressValue: Float = 0.3 // Nilai default
    
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
        performSegue(withIdentifier: "goToAA2ViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAA2ViewController" {
            if let destinationVC = segue.destination as? AAViewController {
                destinationVC.progressValue = self.progressValue
            }
        }
    }
    
    // Di LRRViewController.swift

    @IBAction func unwindToAAViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AA2ViewController {
            self.progressValue = sourceVC.progressValue
            ProgressView.progress = progressValue
        }
    }


}

