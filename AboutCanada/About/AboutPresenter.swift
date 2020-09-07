protocol AboutDisplaying: Display {

    func set(items: TableViewItems)
}

protocol AboutPresenting {

    func displayDidLoad()
    func refreshData()
}

final class AboutPresenter {

    // MARK: - Properties

    // MARK: Private

    private weak var display: AboutDisplaying!
    private let manager: AboutManaging

    init(
        display: AboutDisplaying,
        manager: AboutManaging = AboutManager()
    ) {
        self.display = display
        self.manager = manager
    }
}

// MARK: - Conformance

// MARK: AboutPresenting

extension AboutPresenter: AboutPresenting {

    func displayDidLoad() {
        display.set(title: Strings.about.title)
        fetchData()
    }

    func refreshData() {
        fetchData()
    }
}

// MARK: - Private Helpers

private extension AboutPresenter {

    enum Strings: String, Localizable {
        case about
        case error = "about.error"
    }

    func fetchData() {
        display.showLoading(show: true)
        manager.fetchData { [weak self] result in
            guard let self = self else { return }
            self.display.showLoading(show: false)
            switch result {
            case .success(let data):
                self.setItems(using: data)
            case .failure(let error):
                self.setError(with: error)
            }
        }
    }

    func setItems(using data: About) {
        display.set(title: data.title)
        display.set(
            items: data.rows.filter {
                !$0.isNil
            }.compactMap {
                AboutItem(using: $0)
            }
        )
    }

    func setError(with error: Error) {
        display.set(title: Strings.about.title)
        display.set(
            items: [
                NoDataItem(description: Strings.error.text),
            ]
        )
    }
}
