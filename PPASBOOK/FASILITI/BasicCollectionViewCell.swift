import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BasicCollectionViewCell"
    
    let imageView = UIImageView()
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure the cell's subviews
        configureSubviews()
        configureCellAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure label fonts and colors
        label1.font = UIFont.systemFont(ofSize: 13, weight: .bold) // Set the font size and weight
        label1.textColor = .systemTeal // Set the text color
        label1.textAlignment = .center // Align text center
        
        label2.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label2.textColor = .black
        label2.textAlignment = .center
        
        label3.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label3.textColor = .black
        label3.textAlignment = .center
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            label1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 4),
            label2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 4),
            label3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureCellAppearance() {
        // Set cell border
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        //layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    func configure(with data: YourDataModel) {
        imageView.image = UIImage(named: data.imageName)
        label1.text = data.label1Text
        label2.text = data.label2Text
        label3.text = data.label3Text
    }
}
