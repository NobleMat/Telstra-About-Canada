import UIKit

final class ActivityIndicator {

    private static var container: UIView = UIView()
    private static var loadingView: UIView = UIView()
    private static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)

    static var layerBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.4)
    static var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.8)
    static var ringColor: UIColor = UIColor.white

    // Show customized activity indicator,
    ///
    /// - Parameter onView: add activity indicator to this view
    static func showActivityIndicator(_ onView: UIView) {
        container.frame = onView.frame
        container.center = onView.center
        container.backgroundColor = layerBackgroundColor

        loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingView.center = container.center
        loadingView.backgroundColor = backgroundColor
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.color = ringColor
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        onView.addSubview(container)
        activityIndicator.startAnimating()
    }

    /// Hide activity indicator
    static func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
}
