//
//  WikiViewController.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit
import WebKit
import SnapKit

final class WikiViewController: UIViewController {

    // - UI
    private lazy var webView = {
        let view = WKWebView(frame: .zero)
        return view
    }()
   
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: Set
extension WikiViewController {
    
    func set(url: String?) {
        setWebView(urlString: url)
    }
       
}

// MARK: WebView
private extension WikiViewController {
    
    func setWebView(urlString: String? = nil) {
        guard let urlString else { return }
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
       
}

// MARK: Configure
private extension WikiViewController {
    
    func configure() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        view.addSubview(webView)
    }
    
    func makeConstraints() {
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}




