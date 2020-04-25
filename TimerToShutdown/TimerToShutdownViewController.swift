//
//  TimerToShutdownViewController.swift
//  TimerToShutdown
//
//  Created by Júlio Andherson de Oliveira Silva on 21/03/20.
//  Copyright © 2020 Júlio Andherson de Oliveira Silva. All rights reserved.
//

import Cocoa

class TimerToShutdownViewController: NSViewController {
    @IBOutlet weak var countdownLabel: NSTextField!
    @IBOutlet weak var timerPicker: NSDatePicker!
    @IBOutlet weak var actionButton: NSButton!
    
    var currentTime: Date!
    var countDown: Date!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleToActivate()
        timerPicker.locale = Locale.current
        
        var calendar = Calendar.current
        timerPicker.dateValue = calendar.date(byAdding: .hour, value: 1, to: Date())!
        
//        timerPicker.dateValue = Date()
        

        // Do view setup here.
    }
    
    @objc func updateCountdown() {
        let calendar = Calendar.current
        print("----- DATE 1: \(countDown)")
        countDown = calendar.date(byAdding: .second, value: -1, to: countDown)
        print("----- DATE 2: \(countDown)")

        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//        var x = formatter.string(from: countDown)
//        print("===> X: \(x)")
        
        let hour = calendar.component(.hour, from: countDown)
        let minutes = calendar.component(.minute, from: countDown)
        let seconds = calendar.component(.second, from: countDown)
    
        
        let myCalendar = Calendar(identifier: .gregorian)
        let ymd = myCalendar.dateComponents([.hour, .minute, .second], from: countDown)
        
        print("===> \(ymd.hour):\(ymd.minute):\(ymd.second)")
        
        print("Countdown update => \(hour):\(minutes):\(seconds)")
        
        
        countdownLabel.stringValue = formatterTime(hour: hour, minute: minutes, second: seconds)
        
        
        // Stop condition
        if currentTime >= timerPicker.dateValue {
            print("Should shutdown")
//            timer.invalidate()
//            timer = nil
//            ScriptService.executeShutDownScript()
//            print("SHOULD SHUTDOWN")
        }

    }
    
    private func setTitleToActivate() {
        actionButton.title = "Activate"
    }
    
    private func setTitleToDeactivate() {
        actionButton.title = "Deactivate"
    }
    
    @IBAction func startTimer(_ sender: NSButton) {
        switch sender.state {
        case .on:
            setTitleToDeactivate()
            print("ON")
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
            
            currentTime = Date()
            var calendar = Calendar.current
            calendar.locale = Locale.current
            print("Time Zone: \(calendar.timeZone)")
            
            var currentHour = calendar.component(.hour, from: currentTime)
            var currentMinutes = calendar.component(.minute, from: currentTime)
            var currentSeconds = calendar.component(.second, from: currentTime)
                    
            print("Hora Atual ===> \(formatterTime(hour: currentHour, minute: currentMinutes, second: currentSeconds))")
            
            let picker = timerPicker.dateValue
            var pickerHour = calendar.component(.hour, from: picker)
            var pickerMinutes = calendar.component(.minute, from: picker)
            var pickerSeconds = calendar.component(.second, from: picker)
            
            print("Hora do Timepicker ===> \(formatterTime(hour: pickerHour, minute: pickerMinutes, second: pickerSeconds))")
            
            var interval = picker.timeIntervalSinceReferenceDate - currentTime.timeIntervalSinceReferenceDate
            countDown = Date(timeIntervalSinceReferenceDate: interval)
            print("Date para desligar ====> \(countDown)")
            
            print("===> CurrentTime: \(currentTime)")
            print("===> PickerTime: \(picker)")
            
        case .off:
            setTitleToActivate()
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
            print("OFF")
        default:
            print("NOTHING TO DO")
        }
    }
    
    private func countDown(currentTime: Time, timeToShutdown: Time) -> Time {
        var timeResult = Time()
        
        // Seconds
        
        
        
        return timeResult
    }
    
    private func formatterTime(hour: Int, minute: Int, second: Int) -> String {
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
}

extension TimerToShutdownViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> TimerToShutdownViewController {
    //1.
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? TimerToShutdownViewController else {
      fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}

struct Time {
    var hour: Int!
    var minute: Int!
    var second: Int!
}

