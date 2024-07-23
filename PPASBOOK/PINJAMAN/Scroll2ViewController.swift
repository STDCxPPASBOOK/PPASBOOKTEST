//
//  Scroll2ViewController.swift
//  progress
//
//  Created by STDC_20 on 22/07/2024.
//

import UIKit
import UniformTypeIdentifiers
import MobileCoreServices


class Scroll2ViewController: UIViewController, UIDocumentInteractionControllerDelegate, UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var iconButton: UIButton!
    
    @IBOutlet weak var iconButton2: UIButton!
    
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var Label4: UILabel!
    
    @IBOutlet weak var Label5: UILabel!
    
    private var fileURLs: [UILabel: URL] = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        addTapGestureRecognizer(to: Label1)
        addTapGestureRecognizer(to: Label2)
        addTapGestureRecognizer(to: Label3)
        addTapGestureRecognizer(to: Label4)
        addTapGestureRecognizer(to: Label5)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLRRViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLRRViewController" {
            if segue.destination is LRRViewController {
                
            }
        }
    }
    @IBAction func unwindToLRRViewController(segue: UIStoryboardSegue) {
        if segue.source is LRRViewController {
            
        }
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func buttonClicked2(_ sender: UIButton) {
        // Check the current image and toggle it
        if sender.currentImage == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func UploadFiles1(_ sender: UIButton) {
        presentDocumentPicker(for: Label1)
    }
    
    @IBAction func UploadFiles2(_ sender: UIButton) {
        presentDocumentPicker(for: Label2)
    }
    
    @IBAction func UploadFiles3(_ sender: UIButton) {
        presentDocumentPicker(for: Label3)
    }
    
    @IBAction func UploadFiles4(_ sender: UIButton) {
        presentDocumentPicker(for: Label4)
    }
    
    @IBAction func UploadFiles5(_ sender: UIButton) {
        presentDocumentPicker(for: Label5)
    }
    
    private var currentLabel: UILabel?
    
       
       private func presentDocumentPicker(for label: UILabel) {
           currentLabel = label
           let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data], asCopy: true)
           documentPicker.delegate = self
           present(documentPicker, animated: true, completion: nil)
       }
       
       private func addTapGestureRecognizer(to label: UILabel) {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
           label.isUserInteractionEnabled = true
           label.addGestureRecognizer(tapGesture)
       }
       
       @objc private func handleLabelTap(_ gestureRecognizer: UITapGestureRecognizer) {
           guard let label = gestureRecognizer.view as? UILabel, let url = fileURLs[label] else { return }
           openFile(at: url)
       }
       
       private func openFile(at url: URL) {
           let documentInteractionController = UIDocumentInteractionController(url: url)
           documentInteractionController.delegate = self
           documentInteractionController.presentPreview(animated: true)
       }
       
    @objc(documentPicker:didPickDocumentsAtURLs:) func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
           guard let label = currentLabel, let url = urls.first else { return }
           
           let fileName = url.lastPathComponent
           label.text = fileName
           
           fileURLs[label] = url  // Store the selected URL
           
           // Handle the selected file URL here
           print("Selected file URL: \(url)")
           
           currentLabel = nil
       }
       
    @objc func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           currentLabel = nil
           print("Document picker was cancelled.")
       }
       
       // MARK: - UIDocumentInteractionControllerDelegate
       
    @objc internal func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
           return self
       }
    
    @IBAction func unwindToScroll2ViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? LRRViewController {
            
        }
    }
    
   }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     ok
    */


