//
//  TimerSetupViewController.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 12.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class TimerSetupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var timerPickerView: UIPickerView!
    
    
    let pickerData = ["30 seconds", "1 minute", "5 minutes", "10 minutes"]
    let timerCounts = [30.0, 60.0, 300.0, 600.0]
    var timerCount = Double()
    var playerViewController = PlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerPickerView.delegate = self
        self.timerPickerView.dataSource = self
        timerCount = timerCounts[0]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timerCount = timerCounts[row]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        if timer.isValid{
            
            let date = Date()
            print (date.timeIntervalSince(timer.fireDate))
            let timeToEnd = abs(Int(date.timeIntervalSince(timer.fireDate)))
            
            let alert = UIAlertController(title: "Timer", message: "Timer is active for \(timeToEnd) seconds", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else{
            playerViewController.runTimer(forSeconds: timerCount)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
