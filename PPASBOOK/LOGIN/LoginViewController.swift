import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet var noicTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var newUser: UIButton!
    @IBOutlet var togglePasswordButton: UIButton! // Add this outlet
    
    var alertMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        noicTextField.clipToCircle()
        passwordTextField.clipToCircle()
        
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderColor = UIColor.systemTeal.cgColor
        loginButton.layer.borderWidth = 1.0
        alertLabel.isHidden = true
        
        // Add target for toggle password button
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
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
            alertMessage = nil // Clear the message after showing it
        }
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

           Auth.auth().signIn(withEmail: noic + "@ppasbook.com", password: password) { [weak self] authResult, error in
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
