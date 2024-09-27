class CustomFormArray2 {
    static let shared = CustomFormArray2()
    private var items: [CustomFormItem2] = []

    private init() {}

    func addItem(nama: String, noIc: String, alamat: String, poskod: String, bandar: String, daerah: String, emel: String, noTel: String, status: String, data: String) {
        let newItem = CustomFormItem2(nama: nama, noIc: noIc, alamat: alamat, poskod: poskod, bandar: bandar, daerah: daerah, emel: emel, noTel: noTel, status: status, data: data)
        items.append(newItem)
    }

    func getItems() -> [CustomFormItem2] {
        return items
    }
}
