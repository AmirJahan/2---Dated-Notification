import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserPermission();
        
        // Calendar Notification
        let destDate = Date().addingTimeInterval(10)
        showDatedNotification(at: destDate)
        
        
    }
    
    

    
    func showDatedNotification(at date: Date) {
        
        
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar,
                                           timeZone: .current,
                                           month: components.month,
                                           day: components.day,
                                           hour: components.hour,
                                           minute: components.minute,
                                           second: components.second)
        
 
        
        let myFormatter = DateFormatter()
        
        myFormatter.dateFormat = "MMM dd,yyyy"
        myFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"

        let date: Date? = myFormatter.date(from: "2016-02-29 12:24:26")
        print(myFormatter.string(from: date!))
        
        
        
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: newComponents,
                                                        repeats: false)
        
        
        let dateContent = UNMutableNotificationContent()
        dateContent.title = "Date Notification"
        dateContent.body = "This happens at a certain time"
        dateContent.sound = UNNotificationSound.default()
        
        requestFunc(inpIdentifier: "dateId",
                    inpContent: dateContent,
                    inpTrigger: dateTrigger)
    }
    
    

    func requestFunc(inpIdentifier: String,
                     inpContent:UNMutableNotificationContent,
                     inpTrigger: UNNotificationTrigger)  {
        
        // Creating notification request
        let request = UNNotificationRequest(identifier:inpIdentifier,
                                            content: inpContent,
                                            trigger: inpTrigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error with request: \(error)")
            }
        }
    }
    
    
    
    
    func getUserPermission()
    {
        // grant access by user to receve notifications
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound])
            {
                (accepted, error) in
                var alert : UIAlertController;
                
                
                if !accepted
                {
                    alert = UIAlertController(title: "Denied",
                                              message: "Notification access denied.",
                                              preferredStyle: UIAlertControllerStyle.alert);
                }
                else
                {
                    alert = UIAlertController(title: "Granted",
                                              message: "Notification access granted.",
                                              preferredStyle: UIAlertControllerStyle.alert);
                }
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: UIAlertActionStyle.default,
                                              handler: nil))
                
                self.present(alert, animated: true, completion: nil)
        }
    }
}
