import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        
        // Configure imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        // Configure label1
        label1.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .systemTeal
        addSubview(label1)
        
        // Configure label2
        label2.font = UIFont.systemFont(ofSize: 12)
        label2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label2)
        
        // Configure label3
        label3.font = UIFont.systemFont(ofSize: 12)
        label3.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label3)
        
        NSLayoutConstraint.activate([
            // Constraints for imageView
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            // Constraints for label1
            label1.centerXAnchor.constraint(equalTo: centerXAnchor),
            label1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            
            // Constraints for label2
            label2.centerXAnchor.constraint(equalTo: centerXAnchor),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 4),
            
            // Constraints for label3
            label3.centerXAnchor.constraint(equalTo: centerXAnchor),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 8),
            label3.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    func configure(with data: YourDataModel) {
        // Set image
        if let image = UIImage(named: data.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "placeholder") // Placeholder image if named image is not found
        }
        
        label1.text = data.label1Text
        label2.text = data.label2Text
        label3.text = data.label3Text
    }
}
