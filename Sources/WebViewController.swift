//
//  WebView.swift
//  QRCode
//
//  Created by Erwin on 16/5/6.
//  Copyright © 2016年 Erwin. All rights reserved.
//

import UIKit
import WebKit

public class WebViewController: UIViewController,WKNavigationDelegate {
  
  var url : String?
  
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    let str = url ?? "http://www.baidu.com" as String
    print("-------------------------\(str)")
    let path = URL(string: str)
    let webview = WKWebView(frame: self.view.bounds)
    //会蹦掉
    //致命错误：意外发现零而展开可选值
    webview.load(URLRequest(url: path!))
    webview.navigationDelegate = self
    self.view.addSubview(webview)
    
  }
  
  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.title = webView.title
  }
}
