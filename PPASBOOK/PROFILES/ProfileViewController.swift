//
//  ProfileViewController.swift
//  PPASBOOK
//
//  Created by STDC_15 on 10/07/2024.
//

import UIKit
import QuartzCore

class ProfileViewController: UIViewController {
    
    @IBOutlet var tb: UITableView!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var icLabel: UILabel!
    
    var user: User? // Add a property to hold the user data

    override func viewDidLoad() {
        super.viewDidLoad()

        // Mengatur corner radius untuk tableView
        tb.layer.cornerRadius = 10
        tb.clipsToBounds = true // Penting untuk memastikan corner radius terlihat

        // Setup lainnya...
        
        // Tambahkan aksi untuk tombol logout
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        // Update UI with user data
        if let user = user {
            nameLabel.text = user.fullname
            icLabel.text = user.noic
        }
    }
    
    @objc func logoutButtonTapped() {
        // Membuat UIAlertController
        let alert = UIAlertController(title: "Logout", message: "Adakah anda yakin ingin logout?", preferredStyle: .alert)
        
        // Menambahkan aksi "Tidak"
        alert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: nil))
        
        // Menambahkan aksi "Ya"
        alert.addAction(UIAlertAction(title: "Ya", style: .destructive, handler: { action in
            self.logout()
        }))
        
        // Menampilkan alert
        present(alert, animated: true, completion: nil)
    }
    
    func logout() {
        print("User telah logout.")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            mainVC.modalTransitionStyle = .crossDissolve // Anda bisa memilih .coverVertical, .crossDissolve, .partialCurl, dll.
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
        } else {
            print("MainViewController tidak ditemukan di storyboard")
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
}
