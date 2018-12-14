//
//  MenuVC.swift
//  TapTheColor
//
//  Created by Justin Lewis on 12/4/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row]) Seconds"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameTime = pickerData[row]
        return timePickerTextField.text = "\(pickerData[row]) Seconds"
    }

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var timePickerTextField: UITextField!
    
    let timePicker = UIPickerView()
    let pickerData = [5, 10, 20, 30]
    var gameTime = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePickerTextField.inputView = timePicker
        timePicker.delegate = self
        timePicker.selectRow(1, inComponent: 0, animated: false)
        
        highScoreLabel.adjustsFontSizeToFitWidth = true
        
        //BUTTON PULSE ANIMATION
        UIView.animate(withDuration: TimeInterval(1.0), delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        
        
        

        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        highScoreLabel.text = "Current High Score: \(highScore)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayGameVC {
            vc.gameTime = self.gameTime
        }
    }

}
