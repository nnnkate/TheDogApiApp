//
//  SelectThemeDataSource.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol SelectThemeDelegate: AnyObject {
    func didSelectTheme(_ theme: ThemeName?)
}

final class SelectThemeDataSource: BaseTableViewDataSource<AnyObject, BaseTableViewCellItem> {
    
    // - Delegate
    weak var themeDelegate: SelectThemeDelegate?
    
    override func setupDataSource() {
        super.setupDataSource()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.contentInset = .init(top: 5, left: 0, bottom: 40, right: 0)
    }

    // - UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return selectThemeCell(cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row] as? SelectThemeModel
        themeDelegate?.didSelectTheme(item?.name)
    }
    
    // - Register
    override func registerCells() {
        tableView.register(SelectThemeCell.self, forCellReuseIdentifier: SelectThemeCell.reuseID)
    }
    
    // - Update
    override func reloadData() {
        super.reloadData()
    }

}

// MARK: - Cell
private extension SelectThemeDataSource {

    func selectThemeCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectThemeCell.reuseID, for: indexPath) as! SelectThemeCell
        let index = indexPath.row
        cell.set(model: items[index] as? SelectThemeModel, isFirst: index == 0, isLast: index == items.count - 1)
        return cell
    }

}



