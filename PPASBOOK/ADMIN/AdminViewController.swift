import UIKit

class AdminViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Model untuk CollectionItem
    struct CollectionItem {
        let imageName: String
        let isAdminItem: Bool
    }

    // Outlets dari storyboard
    @IBOutlet var bg: UIView!
    @IBOutlet var image1: UIButton!
    @IBOutlet var image2: UIButton!
    @IBOutlet var image3: UIButton!
    @IBOutlet var bg1: UIView!
    @IBOutlet var topCollection: UICollectionView!
    @IBOutlet var bottomCollection: UICollectionView! // Outlet untuk bottomCollection
    @IBOutlet var editButton: UIButton! // Butang untuk mengedit
    @IBOutlet var addButton: UIButton!
    
    // Sumber data untuk koleksi gabungan
        let topCollectionItems: [CollectionItem] = [
            // Gambar untuk top collection (MainPageViewController)
            CollectionItem(imageName: "top1", isAdminItem: false),
            CollectionItem(imageName: "top2", isAdminItem: false),
            CollectionItem(imageName: "top3", isAdminItem: false),
            CollectionItem(imageName: "top4", isAdminItem: false),
            CollectionItem(imageName: "top5", isAdminItem: false),
            CollectionItem(imageName: "top6", isAdminItem: false),
            CollectionItem(imageName: "top7", isAdminItem: false)
        ]
        
        let bottomCollectionItems: [CollectionItem] = [
            // Gambar untuk bottom collection (AdminViewController)
            CollectionItem(imageName: "slide1", isAdminItem: true),
            CollectionItem(imageName: "slide2", isAdminItem: true),
            CollectionItem(imageName: "slide3", isAdminItem: true),
            CollectionItem(imageName: "slide4", isAdminItem: false)
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Konfigurasi background view
            bg.clipTopCorners(radius: 50.0)
            image1.clipToImage()
            image2.clipToImage()
            image3.clipToImage()
            
            // Atur UICollectionView untuk topCollection
            configureCollectionView(topCollection, with: topCollectionItems)
            
            // Atur UICollectionView untuk bottomCollection
            configureCollectionView(bottomCollection, with: bottomCollectionItems)
        }
        
        func configureCollectionView(_ collectionView: UICollectionView, with items: [CollectionItem]) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 180, height: 180) // Saiz item
            layout.minimumLineSpacing = 10 // Spacing antara item
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Padding
            collectionView.collectionViewLayout = layout
            
            collectionView.isPagingEnabled = true // Mengaktifkan paging
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
        @IBAction func unwindToMainPageViewController(segue: UIStoryboardSegue) {
        }
    }

    extension AdminViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 180, height: 180) // Saiz item tetap
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Padding kiri dan kanan
        }
    }

    extension AdminViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == topCollection {
                return topCollectionItems.count // Jumlah item untuk topCollection
            } else {
                return bottomCollectionItems.count // Jumlah item untuk bottomCollection
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "combinedCell", for: indexPath)
            
            let item: CollectionItem
            if collectionView == topCollection {
                item = topCollectionItems[indexPath.row] // Ambil item untuk topCollection
            } else {
                item = bottomCollectionItems[indexPath.row] // Ambil item untuk bottomCollection
            }
            
            let imageView = UIImageView(image: UIImage(named: item.imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            cell.contentView.addSubview(imageView)
            
            // Layout constraints untuk imageView
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
            ])
            
            // Tambahkan border pada setiap item
            cell.layer.borderColor = UIColor.black.cgColor  // Warna border hitam
            cell.layer.borderWidth = 0.5  // Tebal border 0.5 poin
            cell.layer.masksToBounds = true
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let item: CollectionItem
            if collectionView == topCollection {
                item = topCollectionItems[indexPath.row]
            } else {
                item = bottomCollectionItems[indexPath.row]
            }
            
            if item.isAdminItem {
                // Kendalikan pemilihan item admin
                print("Item admin dipilih: \(item.imageName)")
            } else {
                // Kendalikan pemilihan item biasa
                print("Item biasa dipilih: \(item.imageName)")
            }
        }
    }

    // Extensions untuk UIView dan UIButton (sama seperti sebelum ini)
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

