struct TableViewSection {
    var headerItem: HeaderFooterDisplayable?
    var items: [CellDisplayable]
    var footerItem: HeaderFooterDisplayable?

    init(
        headerItem: HeaderFooterDisplayable? = nil,
        items: [CellDisplayable],
        footerItem: HeaderFooterDisplayable? = nil
    ) {
        self.headerItem = headerItem
        self.items = items
        self.footerItem = footerItem
    }
}
