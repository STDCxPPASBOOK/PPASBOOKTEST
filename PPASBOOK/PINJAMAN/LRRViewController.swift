import UIKit

class LRRViewController: UIViewController {

    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    // Nilai default, akan diganti saat segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func PreviousButton(_ sender: UIButton) {
       
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAAViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAAViewController" {
        }
    }
    
    // Di LRRViewController.swift

    @IBAction func unwindToLRRViewController(segue: UIStoryboardSegue) {
        if segue.source is AAViewController {
            
        }
    }


}
