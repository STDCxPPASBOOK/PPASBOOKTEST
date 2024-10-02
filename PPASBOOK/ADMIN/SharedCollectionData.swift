class SharedCollectionData {
    static let shared = SharedCollectionData()

    var topCollectionItems: [CollectionItem] = [
        CollectionItem(imageName: "top1", isAdminItem: false),
        CollectionItem(imageName: "top2", isAdminItem: false),
        CollectionItem(imageName: "top3", isAdminItem: false),
        CollectionItem(imageName: "top4", isAdminItem: false),
        CollectionItem(imageName: "top5", isAdminItem: false),
        CollectionItem(imageName: "top6", isAdminItem: false),
        CollectionItem(imageName: "top7", isAdminItem: false),
        
    ]
    
    var bottomCollectionItems: [CollectionItem] = [
        CollectionItem(imageName: "slide1", isAdminItem: false),
        CollectionItem(imageName: "slide2", isAdminItem: false),
        CollectionItem(imageName: "slide3", isAdminItem: false),
        CollectionItem(imageName: "slide4", isAdminItem: false),
        CollectionItem(imageName: "slide5", isAdminItem: false)
    ]
    
    private init() {}
}
