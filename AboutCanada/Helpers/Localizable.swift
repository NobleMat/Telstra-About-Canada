import Foundation

protocol Localizable: RawRepresentable {
    var text: String { get }
    var title: String { get }
    var accessibilityText: String { get }

    func text(withArguments arguments: CVarArg...) -> String
    func title(withArguments arguments: CVarArg...) -> String
    func accessibilityText(withArguments arguments: CVarArg...) -> String

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
    var accessibilityText: String { return accessibilityText() }

    func text(withArguments arguments: CVarArg...) -> String {
        return localize(arguments: arguments)
    }

    func title(withArguments arguments: CVarArg...) -> String {
        return localize(withSuffix: Strings.title, arguments: arguments)
    }

    func accessibilityText(withArguments arguments: CVarArg...) -> String {
        return localize(withSuffix: Strings.accessible, arguments: arguments)
    }

    private func localize(withSuffix suffix: String = "", arguments: [CVarArg]) -> String {
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
    static let accessible: String = ".accessible"
}
