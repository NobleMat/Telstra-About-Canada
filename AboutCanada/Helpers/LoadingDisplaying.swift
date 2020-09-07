import UIKit

protocol LoadingDisplaying {

    /// Show an Activity indicator on the viewController
    ///
    /// - Parameter show: A boolean what thats used to show or hide the activity Indicator
    func showLoading(show: Bool)
}

extension UIViewController: LoadingDisplaying {

    func showLoading(show: Bool) {
        if show {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        } else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
