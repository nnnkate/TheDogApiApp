//
//  SelectThemeModel.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

final class SelectThemeModel: BaseTableViewCellItem {
    
    private(set) var name: ThemeName
    
    init(name: ThemeName) {
        self.name = name
    }
    
}


