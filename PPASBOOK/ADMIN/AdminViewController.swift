import UIKit

class AdminViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Outlets from storyboard
    @IBOutlet var bg: UIView!
    @IBOutlet var image1: UIButton!
    @IBOutlet var image2: UIButton!
    @IBOutlet var image3: UIButton!
    @IBOutlet var bg1: UIView!
    @IBOutlet var topCollection: UICollectionView!
    @IBOutlet var bottomCollection: UICollectionView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var addButton: UIButton!

    // Shared Data
    var bottomCollectionItems: [CollectionItem] = SharedCollectionData.shared.bottomCollectionItems
    var topCollectionItems: [CollectionItem] = SharedCollectionData.shared.topCollectionItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI
        bg.clipTopCorner(radius: 50.0)
        image1.clipToImages()
        image2.clipToImages()
        image3.clipToImages()
        
        // Configure collections
        configureCollectionView(topCollection, with: topCollectionItems)
        configureCollectionView(bottomCollection, with: bottomCollectionItems)
        
        // Add tap gesture recognizer to the top collection view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addImage))
        topCollection.addGestureRecognizer(tapGesture)

        // Add tap gesture recognizer to the edit button
        let editGesture = UITapGestureRecognizer(target: self, action: #selector(deleteImage))
        editButton.addGestureRecognizer(editGesture)

        // Register cell for collection view
        topCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "combinedCell")
    }
    
    func configureCollectionView(_ collectionView: UICollectionView, with items: [CollectionItem]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 180, height: 180)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @objc func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func deleteImage() {
        guard let indexPath = topCollection.indexPathsForSelectedItems?.first else {
            print("No item selected to delete.")
            return
        }
        
        // Ensure data source is updated first
        SharedCollectionData.shared.topCollectionItems.remove(at: indexPath.row)
        
        // Then delete item from collection view
        topCollection.deleteItems(at: [indexPath])
        print("Item deleted at index: \(indexPath.row)")
    }
    
    @IBAction func unwindToMainPageViewController(segue: UIStoryboardSegue) {
    }
}

// Extensions for UICollectionView
extension AdminViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
}

extension AdminViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == topCollection ? topCollectionItems.count : bottomCollectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "combinedCell", for: indexPath)
        let item = collectionView == topCollection ? topCollectionItems[indexPath.row] : bottomCollectionItems[indexPath.row]
        
        let imageView = UIImageView(image: UIImage(named: item.imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderWidth = 2.0
        cell?.contentView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderWidth = 0.0
    }
}

// Extensions for UIView and UIButton
extension UIView {
    func clipTopCorner(radius: CGFloat) {
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
    func clipToImages() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

// Implementing UIImagePickerControllerDelegate methods
extension AdminViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // Add new item
            let newItem = CollectionItem(imageName: "newImageFromPicker", isAdminItem: true)
            SharedCollectionData.shared.topCollectionItems.append(newItem)
            topCollection.reloadData()
            print("New item added: \(newItem.imageName)") // Log debug
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
