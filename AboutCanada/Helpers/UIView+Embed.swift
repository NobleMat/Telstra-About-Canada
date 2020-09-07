import UIKit
extension UIView {

    /// Add Constraints to the current view
    /// - Parameters:
    ///   - format: String to specify the Horizontal and Vertical constraints
    ///   - views: Array of views that the format applies to
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }

        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: [],
                metrics: nil,
                views: viewsDictionary
            )
        )
    }
}
