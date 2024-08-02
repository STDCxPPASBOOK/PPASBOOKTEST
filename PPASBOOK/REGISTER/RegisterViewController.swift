import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alertLabel: UILabel!

    var medanPendaftaran: [MedanPendaftaran] = [
        MedanPendaftaran(placeholder: "Email", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "No IC", teks: "", isSecure: false),
        MedanPendaftaran(placeholder: "Kata Laluan", teks: "", isSecure: true),
        MedanPendaftaran(placeholder: "Sahkan Kata Laluan", teks: "", isSecure: true),
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

    func configureUI() {
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderColor = UIColor.systemTeal.cgColor
        registerButton.layer.borderWidth = 1.0
        alertLabel.isHidden = true
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.layoutMargins = UIEdgeInsets(top: 40, left: 10, bottom: 40, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
    }

    func setupFields() {
        for medan in medanPendaftaran {
            let textField = UITextField()
            textField.placeholder = medan.placeholder
            textField.isSecureTextEntry = medan.isSecure
            textField.textAlignment = .center
            textField.autocapitalizationType = .none
            textField.clipToF()
            textField.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
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

        Auth.auth().createUser(withEmail: noic + "@ppasbook.com", password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.showAlert(message: error.localizedDescription)
            } else {
                let newUser = User(email: email, noic: noic, fullname: fullname, contactNumber: contactNumber)
                strongSelf.saveUser(newUser)
                strongSelf.alertMessage = "Pendaftaran Berjaya!"
                strongSelf.showAlert(message: strongSelf.alertMessage!, isError: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    strongSelf.performSegue(withIdentifier: "goToLogin", sender: strongSelf)
                }
            }
        }
    }

    func showAlert(message: String, isError: Bool = true) {
        alertLabel.text = message
        alertLabel.textColor = isError ? .red : .green
        alertLabel.isHidden = false
    }

    func isNumeric(_ string: String) -> Bool {
        return !string.isEmpty && string.allSatisfy { $0.isNumber }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return email.hasSuffix("@gmail.com")
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func saveUser(_ user: User) {
        let db = Firestore.firestore()
        db.collection("users").document(user.noic).setData([
            "email": user.email,
            "noic": user.noic,
            "fullname": user.fullname,
            "contactNumber": user.contactNumber
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
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
