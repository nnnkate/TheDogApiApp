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
        return imageView
    }()
    private lazy var label = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
        model?.subscriber = self
        self.model = model
        label.text = model?.title
        setImage()
        updateUI()
    }
    
    private func setImage() {
        let image = model?.image
        imageView.image = image
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            UIView.animate(withDuration: 0.3) {
                self.imageView.isHidden = image == nil
            }
            if image != nil  {
                self.loader.stopAnimating()
            } else {
                self.loader.startAnimating()
            }
        }
        
    }
    
}

// MARK: - Update
extension BreedCell: BreedModelSubscriber {
   
    func notify() {
        setImage()
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
        loader.startAnimating()
    }
    
    func configureUI() {
        imageView.isHidden = true
        clipsToBounds = false
        contentView.clipsToBounds = false
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
            $0.top.equalTo(10)
            $0.trailing.equalTo(-20)
            $0.leading.equalTo(20)
            $0.bottom.equalTo(label.snp.top).offset(-10)
        }
        
        label.snp.makeConstraints {
            $0.bottom.equalTo(-10)
            $0.trailing.equalTo(-20)
            $0.leading.equalTo(20)
        }
    }
    
}
