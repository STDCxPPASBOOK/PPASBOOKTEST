import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var slideButton: UIButton!
    @IBOutlet var BG: UIView!
    
    var data: YourDataModel?
    var originalPosition: CGPoint?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonShadows()
        
        // Setup gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        slideButton.addGestureRecognizer(panGesture)
        originalPosition = slideButton.center
        
        // Load initial data if available
        if let data = data {
            imageView.image = UIImage(named: data.imageName)
            label1.text = data.label1Text
            label2.text = data.label2Text
            label3.text = data.label3Text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload data if it's updated or reset
        if let data = data {
            imageView.image = UIImage(named: data.imageName)
            label1.text = data.label1Text
            label2.text = data.label2Text
            label3.text = data.label3Text
        }
    }
    
    private func configureButtonShadows() {
        slideButton.layer.borderWidth = 1.0
        slideButton.layer.borderColor = UIColor.black.cgColor
        slideButton.layer.cornerRadius = slideButton.frame.height / 2
        
        BG.layer.borderWidth = 1.0
        BG.layer.borderColor = UIColor.black.cgColor
        BG.layer.backgroundColor = UIColor.lightGray.cgColor
        BG.layer.cornerRadius = BG.frame.height / 2
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .changed:
            slideButton.center = CGPoint(x: originalPosition!.x + translation.x, y: originalPosition!.y)
        case .ended:
            if translation.x > 100 {
                navigateToNextPage()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.slideButton.center = self.originalPosition!
                }
            }
        default:
            break
        }
    }

    func navigateToNextPage() {
        performSegue(withIdentifier: "goToNextPage", sender: self)
    }
    @IBAction func unwindToDetailViewController(_ unwindSegue: UIStoryboardSegue) {
        // Optional: Update data if needed when unwinding
        if let sourceViewController = unwindSegue.source as? DateViewController {
            self.data = sourceViewController.data
        }
    }
}
