import UIKit

extension UIFont {

    /// Helper Function to return a scaled font using testStyle and default size.
    /// This has a maximum font size of 2 times the default size.
    /// - Parameters:
    ///   - textStyle: TextStyle of the font to be used. This can be used to restrict the maximum font size
    ///   - size: Default size to be used when the iPhone is on the default setting
    /// - Returns: A scaled font that can be used by the label.
    func scaledFont(using textStyle: UIFont.TextStyle, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: fontName, size: size) else { fatalError() }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont, maximumPointSize: size * textStyle.maximumFontSize)
    }
}

extension UILabel {
    /// Add text scaling to the the UILabel
    /// - Parameters:
    ///   - textStyle: TextStyle of the font to be used. This can be used to restrict the maximum font size
    ///   - isAttributed: If the label uses an attributed String
    func addAccessibility(using textStyle: UIFont.TextStyle, isAttributed: Bool = false) {
        if isAttributed {
            attributedText = attributedText?.resized(using: textStyle)
        } else {
            font = font.scaledFont(using: textStyle, size: font.pointSize)
            adjustsFontForContentSizeCategory = true
        }
    }
}

extension NSAttributedString {
    /// Resizes the attributedString based on the textStyle and calculated maximum size
    /// - Parameter textStyle: TextStyle of the font to be used. This can be used to restrict the maximum font size
    /// - Returns: The resized attributed string
    func resized(using textStyle: UIFont.TextStyle) -> NSAttributedString {
        guard let resizedString: NSMutableAttributedString = mutableCopy() as? NSMutableAttributedString else { return self }
        resizedString.beginEditing()
        enumerateAttributes(
            in: NSRange(location: 0, length: resizedString.length),
            options: []
        ) { originalAttributes, range, _ in
            var resizedAttributes = originalAttributes
            guard let originalFont = resizedAttributes[.font] as? UIFont else { return }
            let newFont = originalFont.scaledFont(using: textStyle, size: originalFont.pointSize)
            resizedAttributes[.font] = newFont
            resizedString.setAttributes(resizedAttributes, range: range)
        }
        resizedString.endEditing()
        return resizedString
    }
}

private extension UIFont.TextStyle {

    var maximumFontSize: CGFloat {
        switch self {
        case .largeTitle: return 1.25
        default: return 2.0
        }
    }
}
