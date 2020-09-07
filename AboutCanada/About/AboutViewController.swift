import UIKit

final class AboutViewController: UIViewController {

    // MARK: - Properties

    // MARK: Private

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.registerReusable(
            [
                AboutCell.self,
            ]
        )
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.allowsSelection = false
        return tableView
    }()

    private var items: TableViewItems = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl.default
        refreshControl.addTarget(self, action: Selector.refresh, for: UIControl.Event.valueChanged)
        return refreshControl
    }

    // MARK: Public

    var presenter: AboutPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.viewBackground

        setupViews()

        presenter = AboutPresenter(display: self)

        presenter.displayDidLoad()
    }
}

// MARK: - Conformance

// MARK: AboutDisplaying

extension AboutViewController: AboutDisplaying {

    func set(items: TableViewItems) {
        if tableView.refreshControl?.isRefreshing == true {
            tableView.refreshControl?.endRefreshing()
        }
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

        view.addSubview(tableView)

        let tableViewString = "tableview"
        let views: [String: Any] = [
            tableViewString: tableView,
        ]

        var constraints: [NSLayoutConstraint] = []

        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[\(tableViewString)]|",
            options: [],
            metrics: nil,
            views: views
        )
        constraints += verticalConstraints

        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[\(tableViewString)]|",
            options: [],
            metrics: nil,
            views: views
        )
        constraints += horizontalConstraints

        view.addConstraints(constraints)
    }

    @objc
    func refresh() {
        presenter.refreshData()
    }
}

// MARK: Selector

private extension Selector {
    static var refresh = #selector(AboutViewController.refresh)
}
