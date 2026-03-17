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
        userContent.add(self, name: "IsOf")
        userContent.add(self, name: "OfRelease")
        userContent.add(self, name: "NineIs")
        userContent.add(self, name: "ThreatensHe")
        userContent.add(self, name: "RankedBully")
        userContent.add(self, name: "ADiscovered")
        userContent.add(self, name: "ToHe")
        userContent.add(self, name: "BestCollege")
        userContent.add(self, name: "VictimLambeau")
        
        let userConfig = WKWebViewConfiguration()
        userConfig.userContentController = userContent
        
        let view = WKWebView(frame: .zero, configuration: userConfig)
        view.navigationDelegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav(backTitle: "Launch Dinero")
        
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
    
    override func backClick() {
        super.backClick()
        self.dismiss(animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.LDHideActivity()
        if let title = webView.title, title.count > 0 {
            setupLeftBtn(backTitle: title)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        self.view.LDHideActivity()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "IsOf" {
            if let body = message.body as? [String], body.count > 0, let urlStr = URL(string: body[0]) {
                wbView.load(URLRequest(url: urlStr))
            }
        } else if message.name == "OfRelease" {
            self.navigationController?.popViewController(animated: true)
        } else if message.name == "NineIs" {
            if let body = message.body as? [String], body.count > 0 {
                let urlStr = body[0]
                jumpPage(vc: self, url: urlStr)
            }
        } else if message.name == "ThreatensHe" {
            self.view.window?.rootViewController = LDTabBarC()
        } else if message.name == "RankedBully" {
            self.view.window?.rootViewController = LDTabBarC(index: 2)
        }  else if message.name == "ADiscovered" { // 跳转到登录页，并清空页面栈
            
        }  else if message.name == "ToHe" {
            if let body = message.body as? [String], body.count > 0 {
                if let url = URL(string: "tel://\(body)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        } else if message.name == "BestCollege" {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else if message.name == "VictimLambeau" {
            if let body = message.body as? [Any], body.count > 0 {
                LDUploadingInfoManager.point(num: 12, pID: "\(body[0])")
            }
        }
    }

}
