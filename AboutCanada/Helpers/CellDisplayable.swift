import UIKit

protocol CellDisplayable {

    var action: ButtonAction? { get }

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}

extension CellDisplayable {

    var action: ButtonAction? {
        return nil
    }
}

protocol HeaderFooterDisplayable {
    func extractView(from tableView: UITableView) -> UIView?
}
