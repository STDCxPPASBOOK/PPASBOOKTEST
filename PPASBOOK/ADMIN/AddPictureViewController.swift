/*import UIKit
import FirebaseStorage
import FirebaseFirestore

protocol AddPictureViewControllerDelegate: AnyObject {
    func didAddPicture(_ quote: UIImage)
}

class AddPictureViewController: UIViewController {

    weak var delegate: AddPictureViewControllerDelegate?

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var updatePictureButton: UIButton!
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var addTitleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Picture"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @IBAction func updatePictureButtonTapped(_ sender: UIButton) {
        guard let image = pictureImageView.image else {
            showAlert(title: "Error", message: "Please select an image.")
            return
        }

        guard let title = addTitleTextField.text, !title.isEmpty else {
            showAlert(title: "Error", message: "Please enter a title.")
            return
        }

        // Convert the image to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        // Create a unique file name for the image
        let fileName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("MainPicture/\(fileName).jpg")
        
        // Upload the image data to Firebase Storage
        let uploadTask = storageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            if let error = error {
                // Handle the error if upload fails
                print("Failed to upload image: \(error.localizedDescription)")
                self?.showAlert(title: "Upload Error", message: "Failed to upload picture. Please try again.")
                return
            }
            
            // If upload is successful, get the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to get download URL: \(error.localizedDescription)")
                    self?.showAlert(title: "Error", message: "Failed to get image URL.")
                    return
                }
                
                if let downloadURL = url {
                    // Successfully uploaded image, save title and download URL to Firestore
                    self?.saveDataToFirestore(title: title, imageURL: downloadURL.absoluteString)
                }
            }
        }
        
        // Optional: Observe upload progress
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Upload progress: \(percentComplete)%")
        }
    }

    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    // Helper function to show alerts
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        alertController.view.tintColor = UIColor.orange
        present(alertController, animated: true)
    }

    // Save title and image URL to Firestore
    private func saveDataToFirestore(title: String, imageURL: String) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "title": title,
            "imageURL": imageURL,
            "timestamp": FieldValue.serverTimestamp()
        ]
        
        db.collection("pictures").addDocument(data: data) { [weak self] error in
            if let error = error {
                print("Error saving data to Firestore: \(error.localizedDescription)")
                self?.showAlert(title: "Error", message: "Failed to save data. Please try again.")
                return
            }
            
            // Notify the delegate and show success message
            if let image = self?.pictureImageView.image {
                self?.delegate?.didAddPicture(image)
            }
            self?.showAlert(title: "Success", message: "Picture added successfully!")
        }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension AddPictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            pictureImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}*/
