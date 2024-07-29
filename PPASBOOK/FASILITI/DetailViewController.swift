import UIKit
import SceneKit

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
    @IBOutlet weak var tigaDImageView: SCNView!

    var scene: SCNScene!
    var modelNode: SCNNode!
    var initialScale: SCNVector3!
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
                tigaDImageView.scene = nil
        // Initialize the scene
        scene = SCNScene()
        
        // Load the USDZ model
        guard let usdScene = SCNScene(named: "room.usdz") else {
            fatalError("Unable to load USDZ file.")
        }
        
        // Add the model to the scene
        modelNode = usdScene.rootNode.childNodes.first!
        scene.rootNode.addChildNode(modelNode)
        
        // Save the initial scale
        initialScale = modelNode.scale
        
        // Set the scene to the view
        tigaDImageView.scene = scene
        
        // Allow user interaction
        tigaDImageView.allowsCameraControl = true
        tigaDImageView.autoenablesDefaultLighting = true
        
        // Add gesture recognizers
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        tigaDImageView.addGestureRecognizer(pinchGesture)
        
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
    @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .changed || gestureRecognizer.state == .ended {
            // Apply incremental scale to the model
            let scale = Float(gestureRecognizer.scale)
            modelNode.scale = SCNVector3(initialScale.x * scale, initialScale.y * scale, initialScale.z * scale)
            
            if gestureRecognizer.state == .ended {
                // Update the initial scale when the gesture ends
                initialScale = modelNode.scale
            }
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
            tigaDImageView.scene = nil
        }

        @IBAction func tigaDLayoutTapped(_ sender: UIButton) {
            
                tigaDImageView.isHidden = false
                tigaDImageView.scene = scene // Reuse the existing scene
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
