import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet var noicTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var newUser: UIButton!
    @IBOutlet var togglePasswordButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton! // Add this IBOutlet

    var alertMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        noicTextField.clipToCircle()
        passwordTextField.clipToCircle()

        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderColor = UIColor.systemTeal.cgColor
        loginButton.layer.borderWidth = 1.0
        alertLabel.isHidden = true

        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside) // Add this line

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let message = alertMessage {
            showAlert(message: message, isError: false)
            alertMessage = nil
        }
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let noic = noicTextField.text, !noic.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Sila isi semua maklumat.")
            return
        }

        guard isNumeric(noic) else {
            showAlert(message: "Nombor IC mesti mengandungi nombor sahaja.")
            return
        }

        let email = noic + "@ppasbook.com"
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.showAlert(message: error.localizedDescription)
            } else {
                strongSelf.showAlert(message: "Login Berjaya!", isError: false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    strongSelf.navigateToProfile()
                }
            }
        }
    }

    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()

        let buttonImageName = passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        togglePasswordButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }

    @objc func forgotPasswordTapped() {
        let alertController = UIAlertController(title: "Forgot Password", message: "Enter your email to reset your password.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Email"
        }
        let resetAction = UIAlertAction(title: "Reset", style: .default) { _ in
            if let email = alertController.textFields?.first?.text, !email.isEmpty {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        self.showAlert(message: error.localizedDescription)
                    } else {
                        self.showAlert(message: "Password reset email sent.", isError: false)
                    }
                }
            } else {
                self.showAlert(message: "Please enter an email address.")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlert(message: String, isError: Bool = true) {
        alertLabel.text = message
        alertLabel.textColor = isError ? .red : .green
        alertLabel.isHidden = false
    }

    func isNumeric(_ string: String) -> Bool {
        return !string.isEmpty && string.allSatisfy { $0.isNumber }
    }

    func navigateToProfile() {
        let storyboard = UIStoryboard(name: "MainPage", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        tabBarController.selectedIndex = 1
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
            profileVC.modalPresentationStyle = .fullScreen
            profileVC.modalTransitionStyle = .crossDissolve
            self.present(profileVC, animated: true, completion: nil)
        }
    }
}

extension UITextField {
    func clipToCircle() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.systemTeal.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}


