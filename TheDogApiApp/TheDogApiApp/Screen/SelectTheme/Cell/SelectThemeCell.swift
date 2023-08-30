//
//  SelectThemeCell.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class SelectThemeCell: UITableViewCell {
    
    // - Register
    static let reuseID = "SettingCell"

    // - UI
    private lazy var mainView = UIView()
    private lazy var selectImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        return imageView
    }()
    private lazy var label = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()
    private lazy var separator = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    // - Date
    private(set) var model: SelectThemeModel?
    private var isFirst = false
    private var isLast = false
    
    // - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isFirst && isLast {
            roundCorners(topLeft: 16, topRight: 16, bottomLeft: 16, bottomRight: 16)
        } else if isFirst {
            roundCorners(topLeft: 16, topRight: 16, bottomLeft: 0, bottomRight: 0)
        } else if isLast {
            roundCorners(topLeft: 0, topRight: 0, bottomLeft: 16, bottomRight: 16)
        } else {
            roundCorners(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
        }
    }
    
}

// MARK: - Set
extension SelectThemeCell {
    
    func set(model: SelectThemeModel?, isFirst: Bool, isLast: Bool) {
        self.selectImageView.isHidden = SettingsManager.shared.currentThemeName != model?.name
        self.model = model
        label.text = model?.name.rawValue.capitalized ?? ""
        separator.isHidden = isLast
        self.isFirst = isFirst
        self.isLast = isLast
        updateUI()
        setNeedsDisplay()
    }
    
}

// MARK: - Update
private extension SelectThemeCell {
    
    func updateUI() {
        label.textColor = Theme.shared.theme.getColor(color: .label)
        selectImageView.tintColor = Theme.shared.theme.getColor(color: .tint)
        separator.backgroundColor = Theme.shared.theme.getColor(color: .separator)
        backgroundColor = Theme.shared.theme.getColor(color: .view)
    }
}

// MARK: - Configure
private extension SelectThemeCell {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        mainView.clipsToBounds = true
        selectionStyle = .none
        contentView.backgroundColor = .clear
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(selectImageView)
        mainView.addSubview(separator)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(20).priority(999)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
            $0.bottom.lessThanOrEqualTo(-20).priority(999)
            $0.centerY.equalToSuperview()
         }
        
        selectImageView.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(20).priority(999)
            $0.trailing.equalTo(-30)
            $0.height.equalTo(25)
            $0.width.equalTo(20)
            $0.bottom.lessThanOrEqualTo(-20).priority(999)
            $0.centerY.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.4)
        }
    }
    
}





