//
//  SettingsTableViewController.swift
//  HydroPal
//
//  Created by Shao Qian MAH on 15/11/2016.
//  Copyright © 2016 HydroPal. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var waterSwitch: UISwitch!
    @IBOutlet weak var customWaterTextField: UITextField!
    @IBOutlet weak var customWaterIntakeCell: UITableViewCell!
    
    @IBOutlet weak var sexCell: UITableViewCell!
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var ledSwitch: UISwitch!
    @IBOutlet weak var reminderCell: UITableViewCell!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var reminderTimeCell: UITableViewCell!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var wakeLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    
    @IBOutlet weak var wakeTimeLabel: UILabel!
    @IBOutlet weak var sleepTimeLabel: UILabel!
    
    @IBOutlet weak var wakeTimePicker: UIDatePicker!
    @IBOutlet weak var sleepTimePicker: UIDatePicker!
    
    @IBAction func waterSwitchValue(_ sender: UISwitch) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        if waterSwitch.isOn {
            customWaterTextField.becomeFirstResponder()
        } else {
            customWaterTextField.resignFirstResponder()
        }
    }
    
    @IBAction func ledSwitchValue(_ sender: UISwitch) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    @IBAction func wakeTimePickerChanged(_ sender: Any) {
        timePickerChanged(label: wakeTimeLabel, picker: wakeTimePicker)
    }
    
    @IBAction func sleepTimePickerChanged(_ sender: Any) {
        timePickerChanged(label: sleepTimeLabel, picker: sleepTimePicker)
    }
    
    
    
    var time: String = "60" {
        didSet {
            timeLabel.text? = time
        }
    }
    
    var sex: String = "Select" {
        didSet {
            sexLabel.text? = sex
        }
    }
    
    var wakeTimePickerHidden = true
    var sleepTimePickerHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load userdefaults
        let defaults = UserDefaults.standard
        waterSwitch.setOn(defaults.bool(forKey: "customGoalSwitch"), animated: false)
        customWaterTextField.text = defaults.string(forKey: "customGoal")
        sexLabel.text = defaults.string(forKey: "selectedSex")
        ledSwitch.setOn(defaults.bool(forKey: "ledSwitch"), animated: false)
        timeLabel.text = defaults.string(forKey: "reminderTime")
        
        
        addDoneButton() // Adds done button to num pad
        
        //Check timepicker
        toggleTimePickerColor(label: wakeLabel, timePickerHidden: wakeTimePickerHidden)
        toggleTimePickerColor(label: sleepLabel, timePickerHidden: sleepTimePickerHidden)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ""
        let date = dateFormatter.date(from: )
        
        timePickerChanged(label: wakeTimeLabel, picker: wakeTimePicker)
        timePickerChanged(label: sleepTimeLabel, picker: sleepTimePicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 2 {
            // Wake cell
            // Shows and hides time picker: toggleTimePicker()
            wakeTimePickerHidden = !wakeTimePickerHidden
            tableView.beginUpdates()
            tableView.endUpdates()
            
            toggleTimePickerColor(label: wakeLabel, timePickerHidden: wakeTimePickerHidden)
        }
        if indexPath.section == 1 && indexPath.row == 4 {
            // Sleep cell
            // Wake cell
            // Shows and hides time picker: toggleTimePicker()
            sleepTimePickerHidden = !sleepTimePickerHidden
            tableView.beginUpdates()
            tableView.endUpdates()
            
            toggleTimePickerColor(label: sleepLabel, timePickerHidden: sleepTimePickerHidden)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1{
            if waterSwitch.isOn {
                customWaterIntakeCell.isHidden = false
                return 55.0
            } else {
                customWaterIntakeCell.isHidden = true
                return 0.0
            }
        } else if indexPath.section == 0 && indexPath.row == 2 {
            if waterSwitch.isOn {
                sexCell.isHidden = true
                return 0.0
            } else {
                sexCell.isHidden = false
                return 55.0
            }
        } else if indexPath.section == 1 && indexPath.row == 1 {
            if ledSwitch.isOn {
                reminderCell.isHidden = false
                return 55.0
            } else {
                reminderCell.isHidden = true
                return 0.0
            }
        } else if wakeTimePickerHidden && indexPath.section == 1 && indexPath.row == 3 {
                return 0.0
        } else if sleepTimePickerHidden && indexPath.section == 1 && indexPath.row == 5 {
            return 0.0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // Sets cell background colour according to active state
    func toggleTimePickerColor(label: UILabel, timePickerHidden: Bool) {
        if timePickerHidden == false {
            label.textColor = UIColor(red: 21/255, green: 126/255, blue: 251/255, alpha: 1)
        }
        if timePickerHidden == true {
            label.textColor = UIColor.black
        }
    }
    
    // If timePickerChanged
    func timePickerChanged (label: UILabel, picker: UIDatePicker) {
        label.text = DateFormatter.localizedString(from: picker.date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
    
    // Add done button to numpad
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        customWaterTextField.inputAccessoryView = keyboardToolbar
    }
    
    func timePickerChanged(timepicker: UIDatePicker, label: UILabel) {
        label.text = DateFormatter.localizedString(from: timepicker.date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
    
    @IBAction func helptoSettings(segue:UIStoryboardSegue) {
    }
    
    // Sex selection is passed to this view controller
    @IBAction func unwindWithSelectedSex(_ segue:UIStoryboardSegue) {
        if let sexTableViewController = segue.source as? SexTableViewController,
            let selectedSex = sexTableViewController.selectedSex {
            sex = selectedSex
        }
    }
    
    // Reminder time information is passed to this view controller
    @IBAction func unwindWithSelectedTime(_ segue:UIStoryboardSegue) {
        if let timeTableViewController = segue.source as? TimeTableViewController,
            let selectedTime = timeTableViewController.selectedTime {
            time = selectedTime
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickTime" {
            if let timeTableViewController = segue.destination as? TimeTableViewController {
                timeTableViewController.selectedTime = time
            }
        } else if segue.identifier == "pickSex" {
            if let sexTableViewController = segue.destination as? SexTableViewController {
                sexTableViewController.selectedSex = sex
            }
        } else if segue.identifier == "saveSettings" {
            // Save all of the user settings
            
            let defaults = UserDefaults.standard
            if waterSwitch.isOn == true {
                defaults.set(true, forKey: "customGoalSwitch")
            } else {
                defaults.set(false, forKey: "customGoalSwitch")
            }
            defaults.set(customWaterTextField.text, forKey: "customGoal")
            defaults.set(sexLabel.text, forKey: "selectedSex")
            
            if ledSwitch.isOn == true {
                defaults.set(true, forKey: "ledSwitch")
            } else {
                defaults.set(false, forKey: "ledSwitch")
            }
            
            defaults.set(timeLabel.text, forKey: "reminderTime")
            
            defaults.set(DateFormatter.localizedString(from: wakeTimePicker.date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short), forKey: "wakeTime")
            defaults.set(DateFormatter.localizedString(from: sleepTimePicker.date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short), forKey: "sleepTime")
        }
    }
}
