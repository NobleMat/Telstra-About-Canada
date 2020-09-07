import UIKit

final class AboutCell: UITableViewCell, Reusable {

    private lazy var contentStackView = makeStackView()

    private lazy var labelContentView = makeView()

    private lazy var titleLabel = makeLabel(with: .semiBoldFont(with: 16.0))

    private lazy var descriptionLabel = makeLabel(with: .regularFont(with: 14))

    private lazy var imageContentView = makeView()

    private lazy var aboutImageView = makeImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func configure(with item: AboutItem) {
        contentView.backgroundColor = .cellBackground
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        aboutImageView.downloaded(
            from: item.imageURL
        ) { success in
            self.imageContentView.isHidden = !success
        }
    }

    private func setupViews() {
        contentView.addSubview(contentStackView)
        contentView.addConstraintsWithFormat(
            format: "V:|-8-[v0]-8-|",
            views: contentStackView
        )
        contentView.addConstraintsWithFormat(
            format: "H:|-16-[v0]-16-|",
            views: contentStackView
        )

        [titleLabel, descriptionLabel].forEach {
            labelContentView.addSubview($0)
            labelContentView.addConstraintsWithFormat(
                format: "H:|[v0]|",
                views: $0
            )
        }

        labelContentView.addConstraintsWithFormat(
            format: "V:|[v0]-8-[v1]->=0-|",
            views: titleLabel, descriptionLabel
        )

        imageContentView.addSubview(aboutImageView)
        imageContentView.addConstraintsWithFormat(
            format: "H:|[v0(75)]|",
            views: aboutImageView
        )
        imageContentView.addConstraintsWithFormat(
            format: "V:|[v0(75)]->=0-|",
            views: aboutImageView
        )
    }

    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    private func makeLabel(with font: UIFont) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.addAccessibility(using: .body)
        return label
    }

    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }

    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageContentView, labelContentView])
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
