import UIKit

class AA2ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerDaerah {
            return data1.count // Return number of rows for pickerView1
        } else if pickerView == pickerStatus {
            return data2.count // Return number of rows for pickerView2
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerDaerah {
            return data1[row] // Return title for each row in pickerView1
        } else if pickerView == pickerStatus {
            return data2[row] // Return title for each row in pickerView2
        } else {
            return nil
        }
    }
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var pickerDaerah: UIPickerView!
    @IBOutlet var pickerStatus: UIPickerView!
    
    let data1 = ["Petaling", "Hulu Langat", "Klang", "Gombak", "Kuala Langat", "Sepang", "Kuala Selangor", "Hulu Selangor", "Sabak Bernam"]
       let data2 = ["Pelajar Sekolah", "Pelajar STPM/Pra-U", "Pelajar IPTA/IPTS/Kolej", "Bekerja"]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerDaerah.delegate = self
        pickerDaerah.dataSource = self
        
        pickerStatus.delegate = self
        pickerStatus.dataSource = self
    }
 
    @IBAction func PreviousButton(_ sender: UIButton) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToDekstopViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDekstopViewController" {
        }
    }
    
    // Di LRRViewController.swift

    @IBAction func unwindToAA2ViewController(segue: UIStoryboardSegue) {
    }


}




