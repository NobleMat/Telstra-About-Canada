import UIKit

typealias TableViewItems = [CellDisplayable]

protocol CellDisplayable {

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
