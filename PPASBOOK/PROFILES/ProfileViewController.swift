import UIKit
import Firebase
import QuartzCore

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var tb: UITableView!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var icLabel: UILabel!
    @IBOutlet var imageChange: UIImageView!
    
    var user: User? // Add a property to hold the user data

    let menuItems = [
        ("Settings & Privacy"),
        ("History"),
        ("Language"),
        ("How to use PPASBOOK"),
        ("Social Media")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tb.layer.cornerRadius = 10
        tb.clipsToBounds = true
        
        logoutButton.layer.cornerRadius = 10
        logoutButton.clipsToBounds = true
        logoutButton.layer.shadowRadius = 20
        logoutButton.layer.shadowOpacity = 20
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        imageChange.layer.cornerRadius = imageChange.frame.height / 2
        
        tb.dataSource = self
        tb.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageChange.isUserInteractionEnabled = true
        imageChange.addGestureRecognizer(tapGestureRecognizer)
        
        fetchUserProfile()
        loadProfileImage() // Load the profile image from UserDefaults
    }
    
    @objc func logoutButtonTapped() {
        let alert = UIAlertController(title: "Logout", message: "Adakah anda yakin ingin logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ya", style: .destructive, handler: { action in
            self.logout()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                loginVC.modalTransitionStyle = .crossDissolve
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func fetchUserProfile() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        let noic = user.email?.components(separatedBy: "@").first ?? ""
        db.collection("users").document(noic).getDocument { [weak self] document, error in
            if let document = document, document.exists, let data = document.data() {
                let email = data["email"] as? String ?? ""
                let fullname = data["fullname"] as? String ?? ""
                let contactNumber = data["contactNumber"] as? String ?? ""
                let user = User(email: email, noic: noic, fullname: fullname, contactNumber: contactNumber)
                self?.updateUI(with: user)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateUI(with user: User) {
        self.user = user
        nameLabel.text = user.fullname
        icLabel.text = user.noic
    }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem
        return cell
    }

    // MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Implement navigation or action based on selected row
        // Example:
        // if indexPath.row == 0 {
        //     // Navigate to Edit Profile screen
        // }
    }

    // MARK: - UIImagePickerControllerDelegate Methods

    @objc func imageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageChange.image = selectedImage
            saveProfileImage(image: selectedImage) // Save the selected image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Helper Methods

    func saveProfileImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
    }

    func loadProfileImage() {
        if let imageData = UserDefaults.standard.data(forKey: "profileImage") {
            imageChange.image = UIImage(data: imageData)
        }
    }
}
