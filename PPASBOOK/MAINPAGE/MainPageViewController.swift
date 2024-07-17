import UIKit

class MainPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Properti untuk collectionView atas
    var topCollectionView: UICollectionView!
    let topCellIdentifier = "TopCell"
    let topData = ["top1", "top2", "top3"]
    let topURLs = ["", "", "https://www.instagram.com/p/Cj8BfMtJUI0/?utm_source=ig_web_copy_link"]
    var topImageSizes: [CGSize] = []
    
    // Properti untuk collectionView utama (bawah)
    var collectionView: UICollectionView!
    let cellIdentifier = "MyCell"
    let data = ["slide1", "slide2", "slide3", "slide4", "slide5"]
    var imageSizes: [CGSize] = []
    
    // Properti untuk pemasa
    var topCollectionTimer: Timer?
    var mainCollectionTimer: Timer?
    
    // Indeks untuk menjejaki item semasa
    var topCurrentIndex: Int = 0
    var mainCurrentIndex: Int = 0
    
    // Outlets dari storyboard
    @IBOutlet var bg: UIView!
    @IBOutlet var image1: UIButton!
    @IBOutlet var image2: UIButton!
    @IBOutlet var image3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Konfigurasi background view dan gambar
        bg.clipToBg()
        image1.clipToImage()
        image2.clipToImage()
        image3.clipToImage()

        // Tetapkan collectionView atas
        setupTopCollectionView()

        // Tetapkan collectionView utama (bawah)
        setupMainCollectionView()
        
        // Tambahkan background dan collectionView utama ke view
        view.addSubview(bg)
        view.addSubview(collectionView)
        
        // Bawa background dan collectionView utama ke depan
        view.bringSubviewToFront(bg)
        view.bringSubviewToFront(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Mulakan pemasa untuk pergerakan automatik
        startTimers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Hentikan pemasa apabila view akan hilang
        topCollectionTimer?.invalidate()
        mainCollectionTimer?.invalidate()
    }
    
    // MARK: - Setup CollectionViews
    
    func setupTopCollectionView() {
        // Isi array topImageSizes dengan saiz gambar untuk collectionView atas
        for imageName in topData {
            if let image = UIImage(named: imageName) {
                topImageSizes.append(image.size)
            } else {
                // Jika gambar tidak dijumpai, tambah saiz default
                topImageSizes.append(CGSize(width: 100, height: 100))
            }
        }
        
        // Buat layout untuk collectionView atas
        let topLayout = UICollectionViewFlowLayout()
        topLayout.scrollDirection = .horizontal
        topLayout.minimumInteritemSpacing = 5
        topLayout.minimumLineSpacing = 5
        
        // Kira posisi dan saiz collectionView atas
        let topCollectionViewHeight: CGFloat = 250
        let topCollectionViewY: CGFloat = 170 // Sesuaikan dengan posisi yang diinginkan
        
        // Buat collectionView atas dengan layout yang dibuat
        topCollectionView = UICollectionView(frame: CGRect(x: 0, y: topCollectionViewY, width: view.frame.width, height: topCollectionViewHeight), collectionViewLayout: topLayout)
        topCollectionView.backgroundColor = .white
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: topCellIdentifier)
        topCollectionView.clipsToBounds = true
        topCollectionView.layer.cornerRadius = 10 // Corner radius untuk collectionView atas
        
        // Tambahkan collectionView atas ke view utama
        view.addSubview(topCollectionView)
    }
    
    func setupMainCollectionView() {
        // Isi array imageSizes dengan saiz gambar
        for imageName in data {
            if let image = UIImage(named: imageName) {
                imageSizes.append(image.size)
            } else {
                // Jika gambar tidak dijumpai, tambah saiz default
                imageSizes.append(CGSize(width: 100, height: 100))
            }
        }
        
        // Buat layout untuk collectionView utama (bawah)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5 // Jarak mendatar antara item
        layout.minimumLineSpacing = 5 // Jarak menegak antara baris
        
        // Kira posisi dan saiz collectionView utama
        let collectionViewHeight: CGFloat = 245
        let tabBarHeight: CGFloat = 83  // Sesuaikan dengan ketinggian tab bar anda
        let collectionViewY = view.frame.height - collectionViewHeight - tabBarHeight
        
        // Buat collectionView utama dengan layout yang dibuat
        collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: view.frame.width, height: collectionViewHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 10 // Corner radius untuk collectionView
        
        // Tambahkan collectionView ke view utama
        view.addSubview(collectionView)
    }
    
    // MARK: - Setup Timers
    
    func startTimers() {
        // Mulakan pemasa untuk collectionView atas
        topCollectionTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollTopCollectionView), userInfo: nil, repeats: true)
        
        // Mulakan pemasa untuk collectionView utama
        /*mainCollectionTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollMainCollectionView), userInfo: nil, repeats: true)*/
    }
    
    // Kaedah untuk menatal collectionView atas
    @objc func scrollTopCollectionView() {
        topCurrentIndex = (topCurrentIndex + 1) % topData.count
        let nextItem = IndexPath(item: topCurrentIndex, section: 0)
        topCollectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
    }
    
    // Kaedah untuk menatal collectionView utama
    @objc func scrollMainCollectionView() {
        mainCurrentIndex = (mainCurrentIndex + 1) % data.count
        let nextItem = IndexPath(item: mainCurrentIndex, section: 0)
        collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return topData.count
        } else {
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellIdentifier, for: indexPath) as! TopCollectionViewCell
            cell.button.setImage(UIImage(named: topData[indexPath.item]), for: .normal)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCustomCollectionViewCell
            cell.button.setImage(UIImage(named: data[indexPath.item]), for: .normal)
            cell.button.frame = cell.contentView.bounds
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView {
            return topImageSizes[indexPath.item]
        } else {
            return imageSizes[indexPath.item]
        }
    }
}

// Custom UICollectionViewCell untuk memaparkan gambar dalam topCollectionView
class TopCollectionViewCell: UICollectionViewCell {
    
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Inisialisasi UIButton dalam cell
        button = UIButton(frame: contentView.bounds)
        button.contentMode = .scaleAspectFit // Sesuaikan jika diperlukan
        button.layer.cornerRadius = 10 // Corner radius untuk button dalam cell
        button.clipsToBounds = true
        contentView.addSubview(button)
        
        // Tetapkan penampilan button (border, dll.)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) telah tidak dilaksanakan")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = contentView.bounds
    }
}

// Custom UICollectionViewCell untuk memaparkan gambar dalam collectionView
class MyCustomCollectionViewCell: UICollectionViewCell {
    
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Inisialisasi UIImageView dalam cell
        button = UIButton(frame: contentView.bounds)
        button.contentMode = .scaleAspectFit // Sesuaikan jika diperlukan
        button.layer.cornerRadius = 10 // Corner radius untuk imageView dalam cell
        button.clipsToBounds = true
        contentView.addSubview(button)
        
        // Tetapkan penampilan button (border, dll.)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) telah tidak dilaksanakan")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = contentView.bounds
    }
}

// Extensions untuk UIView dan UIButton
extension UIView {
    func clipToBg() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.systemTeal.cgColor
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = self.frame.height / 10
        self.clipsToBounds = true
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
