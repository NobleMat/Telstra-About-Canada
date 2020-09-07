protocol AboutDisplaying: Display {

    func set(items: TableViewItems)
}

protocol AboutPresenting {

    func displayDidLoad()
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
    }
}

// MARK: - Private Helpers

private extension AboutPresenter {

    enum Strings: String, Localizable {
        case about
    }

    func fetchData() {
        manager.fetchData { [weak self] result in
            guard let self = self else { return }
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
            items: data.rows.compactMap {
                AboutItem(using: $0)
            }
        )
    }

    func setError(with error: Error) {
        display.set(title: Strings.about.title)
    }
}