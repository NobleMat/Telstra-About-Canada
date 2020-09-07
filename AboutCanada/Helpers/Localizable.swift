import Foundation

protocol Localizable: RawRepresentable {
    var text: String { get }
    var title: String { get }

    func text(with arguments: CVarArg...) -> String
    func title(with arguments: CVarArg...) -> String

    func localize(_ key: String) -> String
}

extension Localizable {

    func localize(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension Localizable where RawValue == String {
    var text: String { return text() }
    var title: String { return title() }

    func text(with arguments: CVarArg...) -> String {
        return localize(with: "", arguments: arguments)
    }

    func title(with arguments: CVarArg...) -> String {
        return localize(with: Strings.title, arguments: arguments)
    }

    private func localize(with suffix: String = "", arguments: [CVarArg]) -> String {
        let key = rawValue.appending(suffix)

        if arguments.isEmpty {
            return localize(key)
        } else {
            return String(format: localize(key), arguments: arguments)
        }
    }
}

private enum Strings {
    static let title: String = ".title"
}
