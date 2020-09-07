import Foundation

// MARK: - About

struct About: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Row

struct Row: Codable {
    let title, rowDescription, imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageURL = "imageHref"
    }
}
