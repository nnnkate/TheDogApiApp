//
//  BaseTableViewDataSource.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol ScrollViewDelegate: AnyObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class BaseTableViewDataSource<Delegate: AnyObject, Model: BaseTableViewCellItem>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private(set) unowned var tableView: UITableView
    
    // - Delegate
    private(set) weak var delegate: Delegate?
    private(set) weak var scrollViewDelegate: ScrollViewDelegate?
    
    // - Data
    private(set) var items: [Model] = []
    
    // - Init
    init(tableView: UITableView,
         delegate: Delegate?,
         scrollViewDelegate: ScrollViewDelegate? = nil) {
        self.tableView = tableView
        self.delegate = delegate
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        configure()
    }
    
    // - Configure
    func configure() {
        registerCells()
        setupDataSource()
        tableView.updateDataSource(dataSource: self)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func setupDataSource() {
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    // - Register
    func registerCells() {
        fatalError("Require implementation")
    }
    
    // - Update
    func reloadData(items: [Model]) {
        self.items = items
        reloadData()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }

    func updateData(items: [Model]) {
        self.items = items
    }
    
    // - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Require implementation")
    }
    
    // - UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll(scrollView)
    }
    
}

// MARK: - BaseProtocol
protocol BaseTableViewDelegate: AnyObject {
    
}

// MARK: - BaseTableViewCellItem
class BaseTableViewCellItem {
    
}


//MARK: - UITableView
extension UITableView {
    
    func updateDataSource<Delegate, Model : BaseTableViewCellItem>(dataSource: BaseTableViewDataSource<Delegate, Model>?) {
        self.delegate = dataSource
        self.dataSource = dataSource
    }
    
}
