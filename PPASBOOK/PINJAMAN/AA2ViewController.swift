import UIKit

class AA2ViewController: UIViewController {
    
    @IBOutlet var ProgressView: UIProgressView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var progressValue: Float = 0.4 // Nilai default, akan diganti saat segue
    
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
        performSegue(withIdentifier: "goToDekstopViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDekstopViewController" {
            if let destinationVC = segue.destination as? AA2ViewController {
                destinationVC.progressValue = self.progressValue
            }
        }
    }
    
    // Di LRRViewController.swift

    @IBAction func unwindToAA2ViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? DekstopViewController {
            self.progressValue = sourceVC.progressValue
            ProgressView.progress = progressValue
        }
    }


}




