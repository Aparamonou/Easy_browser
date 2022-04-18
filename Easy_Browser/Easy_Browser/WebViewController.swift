//
//  WebViewController.swift
//  Easy_Browser
//
//  Created by Alex Paramonov on 21.02.22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
     
     var webView: WKWebView!
     var progressView: UIProgressView!
     var webcite = ""
     
     override func loadView() {
          webView = WKWebView()
          webView.navigationDelegate = self
          view = webView
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          setUrl()
//          setRightBarButton()
          setUIBarButtonItems()
     }
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
          if keyPath == "estimatedProgress" {
               progressView.progress = Float(webView.estimatedProgress)
          }
     }
     
     private func setUrl(){
          let url = URL(string: "https://" + webcite)!
          webView.load(URLRequest(url: url))
          webView.allowsBackForwardNavigationGestures = true
          webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
     }
          
     private func openPage(action: UIAlertAction) {
          let url = URL(string: "https://" + action.title!)!
          webView.load(URLRequest(url: url))
     }
     
     private func setUIBarButtonItems() {
          progressView = UIProgressView(progressViewStyle: .default)
          progressView.sizeToFit()  // указывает представлению прогресса установить размер макета так, чтобы он полностью соответствовал его содержимому
          let progressButton = UIBarButtonItem(customView: progressView)
          
//          let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let goBack = UIBarButtonItem(title: "goBack", style: .done, target: webView, action: #selector(webView.goBack) )
          let goFoward = UIBarButtonItem(title: "goFoward", style: .done, target: webView, action: #selector(webView.goForward) )
//     barButtonSystemItem: ., target: webView, action: #selector(webView.goBack)
          
          toolbarItems = [ goBack, progressButton,goFoward]
          navigationController?.isToolbarHidden = false
     }
     
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
          title = webView.title
     }
     
     func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
          let url = navigationAction.request.url
          if let host = url?.host {
               if host.contains(webcite) {
                              decisionHandler(.allow)
                              return
                         }
                    }
          decisionHandler(.cancel)
          
     }
}

