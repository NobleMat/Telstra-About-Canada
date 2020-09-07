import UIKit
extension UIView {

    /// Add Constraints to the current view
    /// - Parameters:
    ///   - format: String to specify the Horizontal and Vertical constraints
    ///   - views: Array of views that the format applies to
    ///   - options: The options to be used when settings the constratints
    func addConstraintsWithFormat(
        format: String,
        options: NSLayoutConstraint.FormatOptions = [],
        views: UIView...
    ) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }

        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: options,
                metrics: nil,
                views: viewsDictionary
            )
        )
    }
}
