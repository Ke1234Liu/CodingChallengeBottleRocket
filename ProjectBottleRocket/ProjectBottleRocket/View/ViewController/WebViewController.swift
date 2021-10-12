//
//  WebViewController.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.boundToSuperView()
        webView.navigationDelegate = self
        return webView
    }()
    
    private var webRefreshButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavBar()
        self.loadWebView()
    }
    
    private func setUpNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.navBarGreen
        let webBackButton = UIBarButtonItem(image: UIImage.backIcon, style: .plain, target: self, action: #selector(self.webBackButtonSelected))
        webBackButton.tintColor = .white
        let button = UIButton()
        button.setImage(UIImage.refreshIcon, for: .normal)
        button.addTarget(self, action: #selector(self.webBackButtonSelected), for: .touchUpInside)
        let webRefreshButton = UIBarButtonItem(customView: button)
        webRefreshButton.tintColor = .white
        self.webRefreshButton = button
        
        let webForwardButton = UIBarButtonItem(image: UIImage.forwardIcon, style: .plain, target: self, action: #selector(self.webForwardButtonSelected))
        webForwardButton.tintColor = .white
        self.navigationItem.setLeftBarButtonItems([webBackButton, webRefreshButton, webForwardButton], animated: false)
    }
    
    private func loadWebView() {
       let  webPage = "https://www.bottlerocketstudios.com"
        guard let url = URL(string: webPage) else { return }
        self.webView.load(URLRequest(url: url))
    }
    
    @objc
    private func webBackButtonSelected() {
        self.webView.goBack()
    }
    
    @objc
    private func webForwardButtonSelected() {
        self.webView.goForward()
    }
    
    @objc
    private func webRefreshButtonSelected() {
        if self.webView.isLoading {
            self.webView.stopLoading()
            self.webRefreshButton?.setImage(UIImage.refreshIcon, for: .normal)
        } else {
            self.webView.reload()
            self.webRefreshButton?.setImage(UIImage.closeIcon, for: .normal)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.webRefreshButton?.setImage(UIImage.refreshIcon, for: .normal)
    }
}
