import UIKit

class SocialViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    let socialMediaPlatforms = [
        (name: "INSTAGRAM", icon: UIImage(named: "insta2"), url: URL(string: "https://www.instagram.com/selangorlibrary/")),
        (name: "FACEBOOK", icon: UIImage(named: "fb2"), url: URL(string: "https://www.facebook.com/selangorlibrary")),
        (name: "TIKTOK", icon: UIImage(named: "tt"), url: URL(string: "https://www.tiktok.com/@selangorlibrary?is_from_webapp=1&sender_device=pc"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialMediaPlatforms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCell", for: indexPath) as! SocialCollectionViewCell
        let platform = socialMediaPlatforms[indexPath.row]
        cell.titleLabel.text = platform.name
        cell.iconImageView.image = platform.icon
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 100) // Adjust the size as needed
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let platform = socialMediaPlatforms[indexPath.row]
        
        if let url = platform.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
