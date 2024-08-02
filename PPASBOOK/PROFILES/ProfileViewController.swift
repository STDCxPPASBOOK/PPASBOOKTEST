//
//  ProfileViewController.swift
//  PPASBOOK
//
//  Created by STDC_15 on 10/07/2024.
//

import UIKit
import Firebase
import QuartzCore

class ProfileViewController: UIViewController {
    
    @IBOutlet var tb: UITableView!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var icLabel: UILabel!
    
    var user: User? // Add a property to hold the user data

    override func viewDidLoad() {
        super.viewDidLoad()

        tb.layer.cornerRadius = 10
        tb.clipsToBounds = true

        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        fetchUserProfile()
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
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//}
