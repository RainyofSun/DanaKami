//
//  LDHTMLVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/19.
//

import UIKit
import WebKit
import StoreKit

class LDHTMLVC: LDBaseVC, WKNavigationDelegate, WKScriptMessageHandler {
    
    var webUrl: String = ""
    
    lazy var wbView: WKWebView = {
        let userContent = WKUserContentController()
        userContent.add(self, name: "NegotiatorOf")
        userContent.add(self, name: "AutomaticTo")
        userContent.add(self, name: "AfterHis")
        userContent.add(self, name: "UnderOf")
        userContent.add(self, name: "HimBoth")
        
        let userConfig = WKWebViewConfiguration()
        userConfig.userContentController = userContent
        
        let view = WKWebView(frame: .zero, configuration: userConfig)
        view.navigationDelegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(wbView)
        
        wbView.snp.makeConstraints { make in
            make.top.equalTo(LDNavMaxY)
            make.bottom.left.right.equalToSuperview()
        }
        
        for item in LDReqManager.parameters {
            if let valueStr = item.value as? String {
                if webUrl.contains("?") {
                    webUrl += ("&" + item.key + "=" + valueStr)
                } else {
                    webUrl += ("?" + item.key + "=" + valueStr)
                }
            }
        }
        
        if let str = webUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: str) {
            self.view.LDShowActivity()
            wbView.load(URLRequest(url: url))
        }
    }
    
    override func shouldPop() -> Bool {
        if isPushed {
            self.navigationController?.popViewController(animated: true)
        }
        
        if isPresented {
            self.dismiss(animated: true)
        }
        
        return false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.LDHideActivity()
        if let title = webView.title, title.count > 0 {
            self.title = title
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        self.view.LDHideActivity()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("ht === \(message.name)")
        if message.name == "IsOf" {
            if let body = message.body as? [String], body.count > 0, let urlStr = URL(string: body[0]) {
                wbView.load(URLRequest(url: urlStr))
            }
        } else if message.name == "NegotiatorOf" {
            self.navigationController?.popViewController(animated: true)
        } else if message.name == "AutomaticTo" {
            if let body = message.body as? [String], body.count > 0 {
                let urlStr = body[0]
                jumpPage(vc: self, url: urlStr)
            }
        } else if message.name == "AfterHis" {
            self.view.window?.rootViewController = LDTabBarC()
        } else if message.name == "UnderOf" {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else if message.name == "HimBoth" {
            if let body = message.body as? [Any], body.count > 0 {
                LDUploadingInfoManager.fengkpoint(num: FengKongMaiDian.JieShuJieDai, pID: "\(body[0])")
            }
        }
    }

}
