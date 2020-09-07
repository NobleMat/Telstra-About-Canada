import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    typealias ReusableCell = UITableViewCell & Reusable

    func registerReusable(_ cells: [ReusableCell.Type]) {
        cells.forEach { registerReusable($0) }
    }

    func registerReusable(_ cell: ReusableCell.Type) {
        register(cell.self, forCellReuseIdentifier: cell.identifier)
    }

    func registerReusableHeaderFooter(_ headerFooterViews: [ReusableCell.Type]) {
        headerFooterViews.forEach { registerReusableHeaderFooter($0) }
    }

    func registerReusableHeaderFooter(_ headerFooterView: ReusableCell.Type) {
        register(headerFooterView.self, forHeaderFooterViewReuseIdentifier: headerFooterView.identifier)
    }
}

extension UITableView {

    func dequeReusable<T: Reusable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func dequeReusableHeaderFooter<T: Reusable>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}
