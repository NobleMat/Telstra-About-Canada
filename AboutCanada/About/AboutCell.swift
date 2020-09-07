import UIKit

final class AboutCell: UITableViewCell, Reusable {

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageContentView, labelStackView])
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 8.0
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.semiBoldFont(with: 16.0)
        label.addAccessibility(using: .body)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.regularFont(with: 14)
        label.addAccessibility(using: .body)
        return label
    }()

    private lazy var imageContentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var aboutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func configure(with item: AboutItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
//        aboutImageView.downloaded(
//            from: item.imageURL
//        ) { success in
//            self.aboutImageView.isHidden = !success
//        }
    }

    private func setupViews() {
        contentStackView.embed(inView: contentView, insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))

        aboutImageView.embed(
            inView: imageContentView,
            size: UIView.Size(
                height: UIView.Size.Value(
                    value: 50,
                    priority: UILayoutPriority.defaultLow
                ),
                width: UIView.Size.Value(value: 50)
            )
        )
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
