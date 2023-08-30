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
    private lazy var loader = UIActivityIndicatorView()
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.layer.opacity = 0
        return imageView
    }()
    private lazy var label = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
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
        update()
        updateUI()
    }
    
    func update() {
        imageView.image = model?.image
        if model?.image != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.loader.stopAnimating()
            }
        }
    }
    
}

// MARK: - Update
private extension BreedCell {
    
    func updateUI() {
        mainView.backgroundColor = Theme.shared.theme.getColor(color: .view)
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
        loader.startAnimating()
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(label)
        mainView.addSubview(loader)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        loader.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.width.equalTo(mainView.snp.width).multipliedBy(0.8)
            $0.height.equalTo(mainView.snp.width).multipliedBy(0.7)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(label.snp.top).offset(-10).priority(999)
        }
        
        label.snp.makeConstraints {
            $0.bottom.equalTo(-10)
            $0.trailing.equalTo(-20)
            $0.leading.equalTo(15)
        }
    }
    
}
