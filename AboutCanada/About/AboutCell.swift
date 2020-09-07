import UIKit

final class AboutCell: UITableViewCell, Reusable {

    private var titleLabel: UILabel!

    private var descriptionLabel: UILabel!

    func configure(with item: AboutItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

struct AboutItem: CellDisplayable {
    let title: String?
    let description: String?
    let imageURL: String?

    init(using about: Row) {
        title = about.title
        description = about.rowDescription
        imageURL = about.imageURL
    }

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell: AboutCell = tableView.dequeReusable(at: indexPath)
        cell.configure(with: self)
        return cell
    }
}
