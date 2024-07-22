import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var slideButton: UIButton!
    @IBOutlet var BG: UIView!
    @IBOutlet var duaDLayout: UIButton!
    @IBOutlet var tigaDLayout: UIButton!
    @IBOutlet weak var duaDImageView: UIImageView!
    @IBOutlet weak var tigaDImageView: UIImageView!

    
    var data: YourDataModel?
    var originalPosition: CGPoint?
    var facility: Facility?
    
    struct Facility {
        let name: String
        let capacity: Int
        let price: Double
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
                duaDImageView.isHidden = false
                duaDImageView.image = UIImage(named: "2D") // Gantikan "2D" dengan nama gambar sebenar anda
                tigaDImageView.isHidden = true
                tigaDImageView.image = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetSlideButtonPosition()
        
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
                resetSlideButtonPosition()
            }
        default:
            break
        }
    }
    
    private func resetSlideButtonPosition() {
        UIView.animate(withDuration: 0.3) {
            self.slideButton.center = self.originalPosition!
        }
    }
    
    @IBAction func duaDLayoutTapped(_ sender: UIButton) {
            duaDImageView.isHidden = false
            duaDImageView.image = UIImage(named: "2D") // Gantikan "2D" dengan nama gambar sebenar anda
            tigaDImageView.isHidden = true
            tigaDImageView.image = nil
        }

        @IBAction func tigaDLayoutTapped(_ sender: UIButton) {
            tigaDImageView.isHidden = false
            tigaDImageView.image = UIImage(named: "3D") // Gantikan "3D" dengan nama gambar sebenar anda
            duaDImageView.isHidden = true
            duaDImageView.image = nil
        }
    
    @IBAction func unwindToDetailViewController(segue: UIStoryboardSegue) {
        if segue.source is DateViewController {
            resetSlideButtonPosition()
        }
    }

    @IBAction func navigateToNextPage() {
           performSegue(withIdentifier: "goToDate", sender: self)
       }

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "goToDate" {
               if let dateVC = segue.destination as? DateViewController {
                   dateVC.data = self.data // Mengatur data di DateViewController
               }
           }
       }
   }
