//
//  SettingsDataSource.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol SettingsDelegate: AnyObject {
    func didSelectSetting(_ setting: SettingsType?)
}

final class SettingsDataSource: BaseTableViewDataSource<AnyObject, BaseTableViewCellItem> {
    
    // - Delegate
    weak var settingsDelegate: SettingsDelegate?
    
    override func setupDataSource() {
        super.setupDataSource()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.contentInset = .init(top: 5, left: 0, bottom: 40, right: 0)
    }

    // - UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return settingCell(cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // - Register
    override func registerCells() {
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseID)
    }
    
    // - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row] as? SettingModel
        settingsDelegate?.didSelectSetting(item?.type)
    }
    
    // - Update
    override func reloadData() {
        super.reloadData()
    }

}

// MARK: - Cell
private extension SettingsDataSource {

    func settingCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseID, for: indexPath) as! SettingCell
        let index = indexPath.row
        cell.set(setting: items[index] as? SettingModel, isFirst: index == 0, isLast: index == items.count - 1)
        return cell
    }

}


