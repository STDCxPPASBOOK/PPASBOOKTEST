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
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
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
