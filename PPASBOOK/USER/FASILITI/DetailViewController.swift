import UIKit
import SceneKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var slideButton: UIButton!
    @IBOutlet var BG: UIView!
    @IBOutlet weak var duaDImageView: UIImageView!
    @IBOutlet weak var tigaDImageView: SCNView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var scene: SCNScene!
    var modelNode: SCNNode!
    var initialScale: SCNVector3!
    var data: FacilityDataModel?
    var originalPosition: CGPoint?
    
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
            
            // Tunjukkan paparan 2D pada permulaan
            duaDImageView.isHidden = false
            duaDImageView.image = UIImage(named: "2D") // Gantikan "2D" dengan imej sebenar anda
            tigaDImageView.isHidden = true
            tigaDImageView.scene = nil
            
            // Initialize the 3D scene
            scene = SCNScene()
            guard let usdScene = SCNScene(named: data.usdzFileName) else {
                fatalError("Unable to load USDZ file.")
            }
            
            
            modelNode = usdScene.rootNode.childNodes.first!
            scene.rootNode.addChildNode(modelNode)
            initialScale = modelNode.scale
            tigaDImageView.scene = scene
            tigaDImageView.allowsCameraControl = true
            tigaDImageView.autoenablesDefaultLighting = true
            
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            tigaDImageView.addGestureRecognizer(pinchGesture)
            
            // Set initial segment index
            segmentedControl.selectedSegmentIndex = 0
            updateViewBasedOnSegment(segmentedControl)
        } else {
            imageView.image = UIImage(named: "defaultImage") // Use a default image
            label1.text = "No data available"
            label2.text = ""
            label3.text = ""
            print("Warning: FacilityDataModel is nil.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetSlideButtonPosition()
        
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
        BG.layer.backgroundColor = UIColor.systemGray5.cgColor
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
            let scale = Float(gestureRecognizer.scale)
            modelNode.scale = SCNVector3(initialScale.x * scale, initialScale.y * scale, initialScale.z * scale)
            
            if gestureRecognizer.state == .ended {
                initialScale = modelNode.scale
            }
        }
    }
    
    private func resetSlideButtonPosition() {
        UIView.animate(withDuration: 0.3) {
            self.slideButton.center = self.originalPosition!
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        print("Segment changed to index: \(sender.selectedSegmentIndex)")
        updateViewBasedOnSegment(sender)
    }
    
    // Function to update view based on selected segment
    private func updateViewBasedOnSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Tunjukkan paparan 2D
            print("Switching to 2D view")
            duaDImageView.isHidden = false
            tigaDImageView.isHidden = true
        case 1:
            // Tunjukkan paparan 3D
            print("Switching to 3D view")
            tigaDImageView.isHidden = false
            duaDImageView.isHidden = true
        default:
            print("Invalid segment index")
        }
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
                dateVC.data = self.data
            }
        }
    }
}
