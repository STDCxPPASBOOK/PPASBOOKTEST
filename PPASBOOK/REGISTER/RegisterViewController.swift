import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alertLabel: UILabel!

    var medanPendaftaran: [MedanPendaftaran] = [
        MedanPendaftaran(placeholder: "Email", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "No IC", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "Kata Laluan", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "Sahkan Kata Laluan", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "Nama Penuh", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "Nombor Telefon", teks: "", isSecure: false)
    ]
    
    var textFields: [UITextField] = []
    var alertMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFields()
        configureUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    // MARK: - UI Setup
    func configureUI() {
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderColor = UIColor.systemTeal.cgColor
        registerButton.layer.borderWidth = 1.0
        alertLabel.isHidden = true
        
        // Configure stackView properties
        stackView.axis = .vertical
        stackView.spacing = 16 // Spacing between fields
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        // Configure stackView layout margins
        stackView.layoutMargins = UIEdgeInsets(top: 40, left: 10, bottom: 40, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
    }

    func setupFields() {
        for medan in medanPendaftaran {
            let textField = UITextField()
            textField.placeholder = medan.placeholder
            textField.isSecureTextEntry = medan.isSecure
            textField.textAlignment = .center // Center the text
            textField.clipToF()
            textField.heightAnchor.constraint(equalToConstant: 70).isActive = true // Adjust height
            
            stackView.addArrangedSubview(textField)
            textFields.append(textField)
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        let emailTextField = textFields[0]
        let noicTextField = textFields[1]
        let passwordTextField = textFields[2]
        let confirmPasswordTextField = textFields[3]
        let fullnameTextField = textFields[4]
        let contactNumberTextField = textFields[5]

        guard let email = emailTextField.text, !email.isEmpty,
              let noic = noicTextField.text, !noic.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let fullname = fullnameTextField.text, !fullname.isEmpty,
              let contactNumber = contactNumberTextField.text, !contactNumber.isEmpty else {
            showAlert(message: "Sila isi semua ruangan.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(message: "Email mesti mengandungi @gmail.com.")
            return
        }
        
        guard isNumeric(noic) else {
            showAlert(message: "Nombor IC mesti hanya mengandungi nombor.")
            return
        }
        
        guard isNumeric(contactNumber) else {
            showAlert(message: "Nombor telefon mesti hanya mengandungi nombor.")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(message: "Kata laluan mesti mempunyai sekurang-kurangnya 8 aksara dan mengandungi sekurang-kurangnya satu nombor.")
            return
        }

        guard password == confirmPassword else {
            showAlert(message: "Kata laluan tidak sepadan.")
            return
        }

        // Jika semua validasi lulus
        let newUser = User(email: email, noic: noic, password: password, fullname: fullname, contactNumber: contactNumber)
        saveUser(newUser)

        alertMessage = "Pendaftaran Berjaya!"
        showAlert(message: alertMessage!, isError: false)
        
        // Lakukan segue hanya setelah semua validasi lulus
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.performSegue(withIdentifier: "goToLogin", sender: self)
        }
    }
    
    func showAlert(message: String, isError: Bool = true) {
        alertLabel.text = message
        alertLabel.textColor = isError ? .red : .green
        alertLabel.isHidden = false
    }

    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@gmail.com")
    }
    
    func isNumeric(_ string: String) -> Bool {
        return !string.isEmpty && string.allSatisfy { $0.isNumber }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func saveUser(_ user: User) {
        var users = loadUsers()
        users.append(user)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(users) {
            UserDefaults.standard.set(encoded, forKey: "registeredUsers")
        }
    }
    
    func loadUsers() -> [User] {
        if let savedUsers = UserDefaults.standard.object(forKey: "registeredUsers") as? Data {
            let decoder = JSONDecoder()
            if let loadedUsers = try? decoder.decode([User].self, from: savedUsers) {
                return loadedUsers
            }
        }
        return []
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogin" {
            let destinationVC = segue.destination as? LoginViewController
            destinationVC?.alertMessage = alertMessage
        }
    }
}

// Extension for UITextField styling
extension UITextField {
    func clipToF() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.systemTeal.cgColor
        self.layer.borderWidth = 3.0 // Border width
        self.layer.cornerRadius = 35 // Corner radius
        self.clipsToBounds = true
    }
}
