@testable import AboutCanada

extension About {

    static func mock(
        title: String = "title",
        rows: [Row] = [.mock()]
    ) -> About {
        return About(
            title: title,
            rows: rows
        )
    }
}

extension Row {

    static func mock(
        title: String = "rowTitle",
        rowDescription: String = "rowDescription",
        imageURL: String = "rowImageUrl"
    ) -> Row {
        return Row(
            title: title,
            rowDescription: rowDescription,
            imageURL: imageURL
        )
    }
}
