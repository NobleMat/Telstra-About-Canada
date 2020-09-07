public extension Optional {
    var isNil: Bool {
        switch self {
        case .none: return true
        default: return false
        }
    }
}
