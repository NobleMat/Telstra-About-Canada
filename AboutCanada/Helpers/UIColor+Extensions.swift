import UIKit

extension UIColor {

    static var cellBackground: UIColor? {
        return UIColor(named: "cellBackground")
    }

    static var viewBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGroupedBackground
        } else {
            return UIColor.groupTableViewBackground
        }
    }
}
