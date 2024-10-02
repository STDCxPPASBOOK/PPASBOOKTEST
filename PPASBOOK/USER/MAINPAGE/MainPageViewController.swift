import UIKit

class MainPageViewController: UIViewController {

    // Outlets from storyboard
    @IBOutlet var bg: UIView!
    @IBOutlet var image1: UIButton!
    @IBOutlet var image2: UIButton!
    @IBOutlet var image3: UIButton!
    @IBOutlet var bg1: UIView!
    @IBOutlet var topCollection: UICollectionView!
    @IBOutlet var bottomCollection: UICollectionView!

    // Shared Data
    var topCollectionItems: [CollectionItem] {
        return SharedCollectionData.shared.topCollectionItems
    }
    
    var bottomCollectionItems: [CollectionItem] {
        return SharedCollectionData.shared.bottomCollectionItems
    }
    
    // CADisplayLink for continuous scrolling
    var displayLink: CADisplayLink?
    var scrollSpeed: CGFloat = 30.0 // Adjust this value to change the speed

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI
        bg.clipTopCorners(radius: 50.0)
        image1.clipToImage()
        image2.clipToImage()
        image3.clipToImage()
        
        // Configure collections
        configureCollectionView(topCollection, with: topCollectionItems)
        configureCollectionView(bottomCollection, with: bottomCollectionItems)
        
        // Start continuous scrolling
        startContinuousScrolling()
    }
    
    deinit {
        // Invalidate the display link when the view controller is deallocated
        displayLink?.invalidate()
    }
    
    func configureCollectionView(_ collectionView: UICollectionView, with items: [CollectionItem]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 180, height: 180) // Size of item
        layout.minimumLineSpacing = 10 // Spacing between items
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Padding
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = false // Disable paging for continuous scrolling
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func startContinuousScrolling() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateScroll))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    @objc func updateScroll() {
        // Calculate the new content offset
        let newOffset = topCollection.contentOffset.x + scrollSpeed * (1.0 / 60.0) // Assuming ~60 FPS
        if newOffset >= topCollection.contentSize.width - topCollection.bounds.width {
            // If we've reached the end, reset to start
            topCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        } else {
            // Update content offset
            topCollection.setContentOffset(CGPoint(x: newOffset, y: 0), animated: false)
        }
    }
    
    @IBAction func unwindToMainPageViewController(segue: UIStoryboardSegue) {
    }
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180) // Fixed item size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Padding left and right
    }
}

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollection {
            return topCollectionItems.count // Number of items for topCollection
        } else {
            return bottomCollectionItems.count // Number of items for bottomCollection
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "combinedCell", for: indexPath)
        
        let item: CollectionItem
        if collectionView == topCollection {
            item = topCollectionItems[indexPath.row] // Get item for topCollection
        } else {
            item = bottomCollectionItems[indexPath.row] // Get item for bottomCollection
        }
        
        // Ensure to clean up previous image views
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let imageView = UIImageView(image: UIImage(named: item.imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        // Layout constraints for imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        ])
        
        return cell
    }
}

// Extensions for UIView and UIButton (same as before)
extension UIView {
    func clipTopCorners(radius: CGFloat) {
        self.layoutIfNeeded()
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}

extension UIButton {
    func clipToImage() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
