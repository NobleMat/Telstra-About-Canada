import UIKit

extension UIRefreshControl {

    static var `default`: UIRefreshControl {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.systemTeal
        return refreshControl
    }
}
