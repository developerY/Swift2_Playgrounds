import UIKit

public func loadElements() -> [(date: NSDate, image: UIImage)] {
    let plistElements = NSArray(contentsOfURL: NSBundle.mainBundle().URLForResource("Timeline", withExtension: "plist")!)! as! [[String: AnyObject]]
    return plistElements.map { elem in
        return (date: elem["date"] as! NSDate, image: UIImage(named: elem["image"] as! String)!)
    }
}

