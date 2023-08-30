//
//  SettingModel.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

final class SettingModel: BaseTableViewCellItem {
    
    private(set) var name: String
    private(set) var type: SettingsType
    
    init(type: SettingsType) {
        self.type = type
        self.name = type.title
    }
    
}

