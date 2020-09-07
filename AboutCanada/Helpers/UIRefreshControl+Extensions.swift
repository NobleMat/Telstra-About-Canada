import UIKit

extension UIRefreshControl {

    static var `default`: UIRefreshControl {
        let refreshControl: UIRefreshControl = .init()
        refreshControl.tintColor = .systemTeal
        return refreshControl
    }
}
