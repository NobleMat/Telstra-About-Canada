import UIKit

protocol LoadingDisplaying {
    func showLoading(show: Bool)
}

extension LoadingDisplaying where Self: UIViewController {

    func showLoading(show: Bool) {
        if show {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        } else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
