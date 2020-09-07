import UIKit

protocol TitleDisplaying {
    func set(title: String)
}

extension TitleDisplaying where Self: UIViewController {

    func set(title: String) {
        self.title = title
    }
}
