import UIKit

protocol TitleDisplaying {

    /// Sets a title to a view controller
    ///
    /// - Parameter title: The title to be set
    func set(title: String)
}

extension TitleDisplaying where Self: UIViewController {

    func set(title: String) {
        self.title = title
    }
}
