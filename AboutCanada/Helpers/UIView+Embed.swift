import UIKit

extension UIView {

    struct Size {
        struct Value {
            let value: CGFloat
            let priority: UILayoutPriority

            init(value: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) {
                self.value = value
                self.priority = priority
            }
        }

        let height: Value?
        let width: Value?

        init(height: Value? = nil, width: Value? = nil) {
            self.height = height
            self.width = width
        }
    }

    func embed(
        inView view: UIView,
        insets: UIEdgeInsets = UIEdgeInsets.zero,
        size: Size? = nil
    ) {

        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)

        let viewString = "view"
        let viewDictionary: [String: Any] = [
            viewString: self,
        ]

        var verticalConstraintString: String = "V:|-\(insets.top)-[\(viewString)]-\(insets.bottom)-|"
        var horizontalConstraintString: String = "H:|-\(insets.left)-[\(viewString)]-\(insets.right)-|"

        if let height = size?.height {
            verticalConstraintString = "V:|-\(insets.top)-[\(viewString)(\(height.value))]-\(insets.bottom)@\(height.priority.rawValue)-|"
        }

        if let width = size?.width {
            horizontalConstraintString = "H:|-\(insets.left)-[\(viewString)(\(width.value))]-\(insets.right)@\(width.priority.rawValue)-|"
        }

        var constraints: [NSLayoutConstraint] = []
        let verticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: verticalConstraintString,
            metrics: nil,
            views: viewDictionary
        )
        constraints += verticalConstraint

        let horizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: horizontalConstraintString,
            metrics: nil,
            views: viewDictionary
        )
        constraints += horizontalConstraint

        view.addConstraints(constraints)
    }
}
