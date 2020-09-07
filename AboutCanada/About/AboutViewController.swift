import UIKit

final class AboutViewController: UIViewController {

    // MARK: - Properties

    // MARK: Private

    private var tableView: UITableView {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.registerReusable([AboutCell.self])
        return tableview
    }

    private var items: TableViewItems = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Public

    var presenter: AboutPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        presenter = AboutPresenter(display: self)

        presenter.displayDidLoad()

        setupViews()
    }
}

// MARK: - Conformance

// MARK: AboutDisplaying

extension AboutViewController: AboutDisplaying {

    func set(items: TableViewItems) {
        self.items = items
    }
}

// MARK: UITableViewDataSource

extension AboutViewController: UITableViewDataSource {

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return items[indexPath.row].extractCell(from: tableView, for: indexPath)
    }
}

// MARK: - Private Helpers

private extension AboutViewController {

    func setupViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let tableViewString = "tableView"
        let views: [String: Any] = [
            tableViewString: tableView,
        ]

        var constraints: [NSLayoutConstraint] = []

        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[\(tableViewString)]-|",
            metrics: nil,
            views: views
        )
        constraints += verticalConstraints

        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-\(tableViewString)-|",
            metrics: nil,
            views: views
        )
        constraints += horizontalConstraints

        NSLayoutConstraint.activate(constraints)
    }
}
