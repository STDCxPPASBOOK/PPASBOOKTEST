import UIKit

private let reuseIdentifier = "Cell"

class FasilitiViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var searchBar: UISearchBar!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, YourDataModel>!
    var items: [YourDataModel] = [
        YourDataModel(imageName: "slide1", label1Text: "Bilik Auditorium", label2Text: "200 Pax", label3Text: "RM 330/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Dewan Serbaguna", label2Text: "200 Pax", label3Text: "RM 250/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Seminar 4", label2Text: "70 Pax", label3Text: "RM 200/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Kaca 1", label2Text: "55 Pax", label3Text: "RM 80/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Aktiviti Kanak-Kanak", label2Text: "40 Pax", label3Text: "RM 60/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Mesyuarat", label2Text: "40 Pax", label3Text: "RM 80/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Latihan", label2Text: "28 Pax", label3Text: "RM 75/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Makmal IT", label2Text: "24 Pax", label3Text: "RM 80/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Perbincangan 1", label2Text: "20 Pax", label3Text: "RM 50/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Perbincangan 2", label2Text: "10 Pax", label3Text: "RM 40/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Taklimat", label2Text: "40 Pax", label3Text: "RM 70/Jam"),
        // Tambah lagi data di sini
    ]
    
    var filteredItems: [YourDataModel] = []
    
    enum Section: CaseIterable {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup collection view
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        
        // Setup data source and delegate
        createDataSource()
        
        // Apply initial snapshot
        applySnapshot(items: items)
        
        // Setup search bar delegate
        searchBar.delegate = self
    }
    
    private func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BasicCollectionViewCell, YourDataModel> { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func applySnapshot(items: [YourDataModel], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, YourDataModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let spacing: CGFloat = 10
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(spacing)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
<<<<<<< HEAD
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "FILTER", message: "Masukkan julat harga:", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Harga Minimum"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { textField in
            textField.placeholder = "Harga Maksimum"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Tapis", style: .default, handler: { _ in
            if let minPriceText = alert.textFields?[0].text, let maxPriceText = alert.textFields?[1].text,
               let minPrice = Int(minPriceText), let maxPrice = Int(maxPriceText) {
                self.applyFilter(minPrice: minPrice, maxPrice: maxPrice)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Clear Filter", style: .cancel, handler: { _ in
            self.applySnapshot() // Apply the initial snapshot to clear filters
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            self.applySnapshot() // Apply the initial snapshot to clear filters
        }))
        
        present(alert, animated: true, completion: nil)
    }

    private func applyFilter(minPrice: Int?, maxPrice: Int?) {
        filteredItems = items.filter { item in
            // Extract the price from the label3Text and convert to an integer
            if let priceText = item.label3Text.split(separator: " ").last,
               let price = Int(priceText.replacingOccurrences(of: "RM", with: "").replacingOccurrences(of: "/Jam", with: "")) {
                if let minPrice = minPrice, let maxPrice = maxPrice {
                    return price >= minPrice && price <= maxPrice
                } else if let minPrice = minPrice {
                    return price >= minPrice
                } else if let maxPrice = maxPrice {
                    return price <= maxPrice
                }
            }
            return false
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, YourDataModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonFBTapped(_ sender: UIButton) {
        // Toggle background color on tap
        buttonFB.backgroundColor = buttonFB.backgroundColor == .systemTeal ? .clear : .systemTeal
    }

    @IBAction func buttonPMTapped(_ sender: UIButton) {
        // Toggle background color on tap
        buttonPM.backgroundColor = buttonPM.backgroundColor == .systemTeal ? .clear : .systemTeal
    }


    private func configureButtonShadows() {
        buttonFB.layer.borderWidth = 1.0
        buttonFB.layer.borderColor = UIColor.gray.cgColor
        buttonFB.layer.cornerRadius = buttonFB.frame.height / 2
        buttonFB.layer.shadowColor = UIColor.black.cgColor
        buttonFB.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonFB.layer.shadowOpacity = 0.5
        buttonFB.layer.shadowRadius = 4
        buttonFB.addTarget(self, action: #selector(buttonFBTapped(_:)), for: .touchUpInside)
            buttonFB.backgroundColor = .clear // Set initial background color
        
        buttonPM.layer.borderWidth = 1.0
        buttonPM.layer.borderColor = UIColor.gray.cgColor
        buttonPM.layer.cornerRadius = buttonPM.frame.height / 2
        buttonPM.layer.shadowColor = UIColor.black.cgColor
        buttonPM.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonPM.layer.shadowOpacity = 0.5
        buttonPM.layer.shadowRadius = 4
        buttonPM.addTarget(self, action: #selector(buttonPMTapped(_:)), for: .touchUpInside)
            buttonPM.backgroundColor = .clear // Set initial background color
    }
=======
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
>>>>>>> parent of 3557f04 (ok)
}

extension FasilitiViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filterContentForSearchText("")
        searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredItems = items.filter { item in
            let lowercasedText = searchText.lowercased()
            return item.label1Text.lowercased().contains(lowercasedText) ||
                   item.label2Text.lowercased().contains(lowercasedText) ||
                   item.label3Text.lowercased().contains(lowercasedText)
        }
        
        applySnapshot(items: filteredItems)
    }
}
