class CustomFormArray {
    static let shared = CustomFormArray()
    private var items: [CustomFormItem] = []

    private init() {}

    func addItem(nama: String, noIc: String, alamat: String, poskod: String, bandar: String, daerah: String, emel: String, noTel: String, status: String, data: String) {
        let newItem = CustomFormItem(nama: nama, noIc: noIc, alamat: alamat, poskod: poskod, bandar: bandar, daerah: daerah, emel: emel, noTel: noTel, status: status, data: data)
        items.append(newItem)
    }

    func getItems() -> [CustomFormItem] {
        return items
    }
}
