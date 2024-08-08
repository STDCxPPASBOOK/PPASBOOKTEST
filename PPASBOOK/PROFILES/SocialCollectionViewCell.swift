import UIKit

class SocialCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    private func configureCell() {
            // Set the corner radius
            self.layer.cornerRadius = 10 // Adjust the radius as needed
            self.layer.masksToBounds = false

            // Set up the shadow
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 4

            // Optional: Add a border
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.cgColor

            // Optional: Add rounded corners to content view
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
        }
    }
