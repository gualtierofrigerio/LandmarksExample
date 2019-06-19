//
//  WebView.swift
//  Landmarks
//
//  Created by Gualtiero Frigerio on 18/06/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    var urlString:String
    var helper = WebViewHelper()
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView(frame: .zero)
    }
    
    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if let url = URL(string:urlString) {
            let request = URLRequest(url: url)
            view.load(request)
            view.navigationDelegate = helper
        }
    }
}

class WebViewHelper : NSObject, WKNavigationDelegate {
    
    private var firstPage = true
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var policy:WKNavigationActionPolicy = .allow
        if !firstPage {
            policy = .cancel
        }
        decisionHandler(policy)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        firstPage = false
    }
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://www.google.it")
    }
}
#endif
