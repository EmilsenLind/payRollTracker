//
//  ViewController.swift
//  PayrollTracker
//
//  Created by Emil Møller Lind on 24/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //IBOUTLETS
    
    @IBOutlet weak var WorkedHoursLabel: UILabel!
    @IBOutlet weak var fromHour: UITextField!
    @IBOutlet weak var toHour: UITextField!
    @IBOutlet weak var payPerHour: UITextField!
    @IBOutlet weak var payBefore: UITextField!
    @IBOutlet weak var payAfter: UITextField!
    
    
    //Properties
    
    var pay : payRoll!
    var dateFormatFrom: Date!
    var dateFormatTo: Date!
    var result: (Double, Double)?
    var workHoursTag: Int?
    
    
    //IBActions
    
    
    @IBAction func editEnd(_ sender: UITextField) {
        self.toHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        self.fromHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        
        print("edit end triggered")
    }
    @IBAction func editEnd2(_ sender: AnyObject) {
        
        self.toHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        self.fromHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        
        print("edit end triggered")

    }
    
    
    @IBAction func hoursWorkedPressed(_ sender: UITextField) {
        print("hoursWorkedPressed")
        self.toHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        self.fromHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        sender.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        workHoursTag = sender.tag
        let datePicker = self.customizeDatePicker()
        sender.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: .valueChanged)
        
        let dateformatter = self.customizedDateFormatter()
        if workHoursTag == 0 {
            self.fromHour.text = ""
            
            self.fromHour.text = self.roundMinute(timeString: dateformatter.string(from: datePicker.date))
            //self.toHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        }
        if workHoursTag == 1 {
            self.toHour.text = ""
            self.toHour.text = self.roundMinute(timeString: dateformatter.string(from: datePicker.date))
           // self.fromHour.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
            
        }
        print("tag: \(workHoursTag)")

        }
    @IBAction func calcBtn(_ sender: AnyObject) {
        pay = payRoll(from: self.dateFormatFrom, to: self.dateFormatTo, payPerHour: self.payPerHour.text)
        self.result = pay.calculate()
    updateUI(result: result!)
        
        self.payPerHour.resignFirstResponder()
        }
   
    
    
    
    @IBAction func saveBtn(_ sender: AnyObject) {
    }
    
   
    //@IBOutlet weak var tableView: UITableView!
   
    func updateUI(result: (Double, Double)) {
        self.payBefore.text = String(result.0)
        self.payAfter.text = String(result.1)
        self.WorkedHoursLabel.text = String(pay.hoursWorked)
    }
    
    
    override func viewDidLoad() {
        
       
        
        
        
        
        
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "payrollDay", for: indexPath) as! payrollDayTableViewCell
        
        return cell
    }
    
    // Functions
    
    
    
    func customizeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 5
        datePicker.locale = Locale(identifier: "da_DK")
        return datePicker
    }
    
    // function separator
    func customizedDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter
    }
    
     // function separator
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateformatter = customizedDateFormatter()
        if workHoursTag == 0 {
            dateFormatFrom = sender.date
            self.fromHour.text = dateformatter.string(from: sender.date)
        }
        if workHoursTag == 1 {
            dateFormatTo = sender.date
            self.toHour.text = dateformatter.string(from: sender.date)
        }
        
        
    }

     // function separator
    
    
    
    func roundMinute(timeString:String) -> String {
        let lastChar = String(timeString.characters.last!)
        var newString = String(timeString.characters.dropLast())
        if let lastInt = Int(lastChar) {
            if lastInt < 5 {
                newString.append("0")
            } else if lastInt >= 5 {
                newString.append("5")
            }
        }
        return newString
        }
}


    


