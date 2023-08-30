//
//  BreedCell.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class BreedCell: UICollectionViewCell {
    
    // - Register
    static let reuseID = "BreedCell"
    
    // - UI
    private lazy var mainView = {
        let view = UIButton()
        view.addAnimatingPress()
        view.addShadow()
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(touchActionHandler), for: .touchUpInside)
        return view
    }()
    private lazy var label = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()
    
    // - Data
    private(set) var model: BreedModel?
    
    // - Closure
    var touchAction: (BreedModel?) -> () = { _ in }
    
    // - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
}

// MARK: - Set
extension BreedCell {
    
    func set(model: BreedModel?) {
        self.model = model
        label.text = model?.title
        updateUI()
    }
    
}

// MARK: - Update
private extension BreedCell {
    
    func updateUI() {
        mainView.backgroundColor = .white
        label.textColor = Theme.shared.theme.getColor(color: .label)
    }
    
}

// MARK: - Action
extension BreedCell {
    
    @objc func touchActionHandler(_ sender: UIButton) {
        touchAction(model)
    }
    
}

// MARK: - Configure
private extension BreedCell {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        clipsToBounds = false
        contentView.clipsToBounds = false
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(label)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.trailing.equalTo(-10)
            $0.top.leading.equalTo(10)
        }
    }
    
}
