@testable import AboutCanada

class MockDisplay: Display {

    private(set) var showLoadingCalledCount: Int = 0
    private(set) var showLoadingShown: Bool?
    func showLoading(show: Bool) {
        showLoadingCalledCount += 1
        showLoadingShown = show
    }

    private(set) var setTitleCalledCount: Int = 0
    private(set) var setTitle: String?
    func set(title: String) {
        setTitleCalledCount += 1
        setTitle = title
    }
}
