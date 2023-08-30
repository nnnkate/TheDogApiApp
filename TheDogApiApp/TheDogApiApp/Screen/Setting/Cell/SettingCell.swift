//
//  SettingCell.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class SettingCell: UITableViewCell {
    
    // - Register
    static let reuseID = "SettingCell"

    // - UI
    private lazy var mainView = UIView()
    private lazy var iconImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var arrowImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
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
    private(set) var setting: SettingModel?
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
            contentView.roundCorners(topLeft: 16, topRight: 16, bottomLeft: 16, bottomRight: 16)
        } else if isFirst {
            contentView.roundCorners(topLeft: 16, topRight: 16, bottomLeft: 0, bottomRight: 0)
        } else if isLast {
            contentView.roundCorners(topLeft: 0, topRight: 0, bottomLeft: 16, bottomRight: 16)
        } else {
            contentView.roundCorners(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
        }
    }
    
}

// MARK: - Set
extension SettingCell {
    
    func set(setting: SettingModel?, isFirst: Bool, isLast: Bool) {
        self.setting = setting
        label.text = setting?.name ?? ""
        iconImageView.image = setting?.type.icon
        separator.isHidden = isLast
        self.isFirst = isFirst
        self.isLast = isLast
        updateUI()
        setNeedsDisplay()
    }
    
}

// MARK: - Update
private extension SettingCell {
    
    func updateUI() {
        separator.backgroundColor = Theme.shared.theme.getColor(color: .separator)
        label.textColor = Theme.shared.theme.getColor(color: .label)
        arrowImageView.tintColor = Theme.shared.theme.getColor(color: .tint)
        iconImageView.tintColor = Theme.shared.theme.getColor(color: .tint)
    }
    
}

// MARK: - Configure
private extension SettingCell {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        mainView.clipsToBounds = true
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = Theme.shared.theme.getColor(color: .view)
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(iconImageView)
        mainView.addSubview(arrowImageView)
        mainView.addSubview(label)
        mainView.addSubview(separator)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        iconImageView.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(20).priority(999)
            $0.leading.equalTo(15)
            $0.height.width.equalTo(25)
            $0.bottom.lessThanOrEqualTo(-20).priority(999)
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(20).priority(999)
            $0.trailing.equalTo(-15)
            $0.height.equalTo(25)
            $0.width.equalTo(20)
            $0.bottom.lessThanOrEqualTo(-20).priority(999)
            $0.centerY.equalToSuperview()
        }
        
        label.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(20).priority(999)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-12)
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

