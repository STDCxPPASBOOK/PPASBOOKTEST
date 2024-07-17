import UIKit

private let reuseIdentifier = "Cell"

class FasilitiViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var buttonFilter: UIButton!
    @IBOutlet var buttonFB: UIButton!
    @IBOutlet var buttonPM: UIButton!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, YourDataModel>!
    var items = [
        YourDataModel(imageName: "Auditorium", label1Text: "Auditorium", label2Text: "👥 200 Pax(Maksimum)", label3Text: "💵 RM 330/Jam"),
        YourDataModel(imageName: "DewanSerbaguna", label1Text: "Dewan Serbaguna", label2Text: "👥 200 Pax(Maksimum)", label3Text: "💵 RM 250/Jam"),
        YourDataModel(imageName: "BilikSeminar4", label1Text: "Bilik Seminar 4", label2Text: "👥 70 Pax(Maksimum)", label3Text: "💵 RM 200/Jam"),
        YourDataModel(imageName: "BilikKaca1", label1Text: "Bilik Kaca 1", label2Text: "👥 55 Pax(Maksimum)", label3Text: "💵 RM 80/Jam"),
        YourDataModel(imageName: "BilikAktivitiKanak", label1Text: "Bilik Aktiviti Kanak-Kanak", label2Text: "👥 40 Pax(Maksimum)", label3Text: "💵 RM 60/Jam"),
        YourDataModel(imageName: "BilikMesyuarat", label1Text: "Bilik Mesyuarat", label2Text: "👥 40 Pax(Maksimum)", label3Text: "💵 RM 80/Jam"),
        YourDataModel(imageName: "slide1", label1Text: "Bilik Latihan", label2Text: "👥 28 Pax(Maksimum)", label3Text: "💵 RM 75/Jam"),
        YourDataModel(imageName: "MakmalIT", label1Text: "Makmal IT", label2Text: "👥 80 Pax(Maksimum)", label3Text: "💵 RM 80/Jam"),
        YourDataModel(imageName: "Bilik Perbincangan 1", label1Text: "Bilik Perbincangan 1", label2Text: "👥 20 Pax(Maksimum)", label3Text: "💵 RM 50/Jam"),
        YourDataModel(imageName: "Bilik Perbincangan 2", label1Text: "Bilik Perbincangan 2", label2Text: "👥 10 Pax(Maksimum)", label3Text: "💵 RM 40/Jam"),
        YourDataModel(imageName: "BilikTaklimat", label1Text: "Bilik Taklimat", label2Text: "👥 40 Pax(Maksimum)", label3Text: "💵 RM 70/Jam"),
    ]
    
    var filteredItems: [YourDataModel] = []
    var selectedItem: YourDataModel?
    
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
        applySnapshot()
        
        // Setup search bar delegate
        searchBar.delegate = self
        searchBar.showsCancelButton = true // Show cancel button
        
        // Add shadow to buttons
        configureButtonShadows()
    }
    
    private func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BasicCollectionViewCell, YourDataModel> { cell, indexPath, data in
            cell.configure(with: data)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, data in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, YourDataModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
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
    
    private func applyPriceFilter() {
        filteredItems = items.sorted { item1, item2 in
            // Extract the price from label3Text and convert to integer
            if let priceText1 = item1.label3Text.split(separator: " ").last,
               let price1 = Int(priceText1.replacingOccurrences(of: "RM", with: "").replacingOccurrences(of: "/Jam", with: "")),
               let priceText2 = item2.label3Text.split(separator: " ").last,
               let price2 = Int(priceText2.replacingOccurrences(of: "RM", with: "").replacingOccurrences(of: "/Jam", with: "")) {
                return price1 < price2
            }
            return false
        }
        
        // Apply snapshot with filteredItems after filtering
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
        buttonPM.backgroundColor = .clear // Deselect buttonPM when buttonFB is selected
        if buttonFB.backgroundColor == .systemTeal {
            applyPriceFilter() // Apply price filter when buttonFB is selected
        } else {
            applySnapshot() // Clear the filter
        }
    }
    
    @IBAction func buttonPMTapped(_ sender: UIButton) {
        // Toggle background color on tap
        buttonPM.backgroundColor = buttonPM.backgroundColor == .systemTeal ? .clear : .systemTeal
        buttonFB.backgroundColor = .clear // Deselect buttonFB when buttonPM is selected
        if buttonPM.backgroundColor == .systemTeal {
            applyPriceDescendingFilter() // Apply descending price filter when buttonPM is selected
        } else {
            applySnapshot() // Clear the filter
        }
    }
    
    private func applyPriceDescendingFilter() {
        filteredItems = items.sorted { item1, item2 in
            // Extract the price from label3Text and convert to integer
            if let priceText1 = item1.label3Text.split(separator: " ").last,
               let price1 = Int(priceText1.replacingOccurrences(of: "RM", with: "").replacingOccurrences(of: "/Jam", with: "")),
               let priceText2 = item2.label3Text.split(separator: " ").last,
               let price2 = Int(priceText2.replacingOccurrences(of: "RM", with: "").replacingOccurrences(of: "/Jam", with: "")) {
                return price1 > price2 // Compare in descending order
            }
            return false
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, YourDataModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        dataSource.apply(snapshot, animatingDifferences: true)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.data = selectedItem
            }
        }
    }
}

extension FasilitiViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = dataSource.itemIdentifier(for: indexPath)
        performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
}

extension FasilitiViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            applySnapshot() // Show all items if search text is empty
        } else {
            filteredItems = items.filter { $0.label1Text.contains(searchText) }
            var snapshot = NSDiffableDataSourceSnapshot<Section, YourDataModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(filteredItems)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        applySnapshot() // Show all items when cancel button is clicked
    }
}
