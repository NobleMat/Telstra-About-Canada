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
}

extension UITableView {

    func dequeReusable<T: Reusable>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
