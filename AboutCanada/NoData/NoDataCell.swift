import UIKit

final class NoDataCell: UITableViewCell, Reusable {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .semiBoldFont(with: 16)
        label.textAlignment = .center
        label.addAccessibility(using: .body)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func configure(with item: NoDataItem) {
        contentView.backgroundColor = .cellBackground
        descriptionLabel.text = item.description
    }

    private func setupViews() {
        contentView.addSubview(descriptionLabel)

        contentView.addConstraintsWithFormat(
            format: "V:|-8-[v0]-8-|",
            views: descriptionLabel
        )

        contentView.addConstraintsWithFormat(
            format: "H:|-16-[v0]-16-|",
            views: descriptionLabel
        )
    }
}

struct NoDataItem: CellDisplayable {
    let description: String

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell: NoDataCell = tableView.dequeReusable(at: indexPath)
        cell.configure(with: self)
        return cell
    }
}
