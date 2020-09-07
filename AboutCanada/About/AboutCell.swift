import UIKit

final class AboutCell: UITableViewCell, Reusable {

    private lazy var labelContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .semiBoldFont(with: 16.0)
        label.addAccessibility(using: .body)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .regularFont(with: 14)
        label.addAccessibility(using: .body)
        return label
    }()

    private lazy var imageContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var aboutImageView: UIImageView = {
        let imageView = UIImageView()
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
        [imageContentView, labelContentView].forEach {
            contentView.addSubview($0)
            contentView.addConstraintsWithFormat(
                format: "V:|-8-[v0]->=8-|",
                views: $0
            )
        }
        contentView.addConstraintsWithFormat(
            format: "H:|-8-[v0]-8-[v1]-8-|",
            views: imageContentView, labelContentView
        )

        contentView.addConstraintsWithFormat(
            format: "H:|-8@750-[v0]-8-|",
            views: labelContentView
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
            format: "V:|[v0(75)]|",
            views: aboutImageView
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
