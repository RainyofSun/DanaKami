//
//  LDVerifyDetailAVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailAVC: LDVerifyBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var data: LDVerifyDetailAModel = LDVerifyDetailAModel()
    
    var type: String = "findb"
    
    lazy var tb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.bounces = false
        tb.register(LDVerifyDetailASelectCell.self, forCellReuseIdentifier: "Cell1")
        tb.register(LDVerifyDetailATextCell.self, forCellReuseIdentifier: "Cell2")
        tb.register(LDVerifyDetailATextSelectCell.self, forCellReuseIdentifier: "Cell3")
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cornerBgView.addSubview(tb)
        
        tb.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(nextBgView.snp.top).offset(-15)
        }

        reqData()
        
        self.beginTime = LDNowTime()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.feature.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let m = data.feature[safe: indexPath.row] {
            if m.editors == "supportinga" || m.editors == "supportingc" {
                if type == "finda" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! LDVerifyDetailASelectCell
                    cell.model = m
                    cell.selectedClourse = { text in
                        self.data.feature[indexPath.row].choice = text
                    }
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3") as! LDVerifyDetailATextSelectCell
                cell.model = m
                cell.selectedClourse = {
                    if m.editors == "supportingc" {
                        self.popup.custom(with: LDPopupConfig()) {
                            let popup = LDLDVerifyDetailDatePopup(frame: CGRect(x: 0, y: 0, width: 339, height: 502))
                            popup.titleLb.text = LDText(key: "Date Birth")
                            popup.selectedClourse = { date in
                                self.data.feature[indexPath.row].choice = date
                                self.tb.reloadData()
                            }
                            return popup
                        }
                    } else {
                        self.popup.custom(with: LDPopupConfig()) {
                            let popupV = LDLDVerifyDetailSelectPopup(frame: CGRect(x: 0, y: 0, width: 315, height: 400))
                            popupV.titleLb.text = m.rainmaker
                            popupV.list = m.lyrics
                            popupV.selectedClourse = { i in
                                self.data.feature[indexPath.row].listeder = "\(m.lyrics[i].listeder)"
                                self.data.feature[indexPath.row].choice = m.lyrics[i].scorer
                                self.tb.reloadData()
                            }
                            return popupV
                        }
                    }
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! LDVerifyDetailATextCell
                cell.model = m
                cell.endEditingClourse = { text in
                    self.data.feature[indexPath.row].choice = text
                }
                return cell
            }
        }
        return LDCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = data.feature[safe: indexPath.row] {
            data.feature[indexPath.row].isShow = !m.isShow
            self.tb.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func reqData() {
        let params: [String: Any] = ["foreign": self.pID]
        var url: LDReqURL = .verifyDetailGRXXUrl(params: params)
        if type == "findc" {
            url = .verifyDetailGZXXUrl(params: params)
        } else if type == "finde" {
            url = .verifyDetailBKUrl(params: params)
        }
        
        self.view.LDShowActivity()
        LDReqManager.request(url: url, modelType: LDVerifyDetailAModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if let m = success.financial {
                    self.data = m
                    self.tb.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
    
    override func nextBtnClick() {
        var params: [String: Any] = ["foreign": self.pID]
        
        for item in data.feature {
            // 单选
            if item.editors == "supportinga" {
                params[item.numbers] = item.listeder
            }
        
            if item.editors == "supportingb" {
                params[item.numbers] = item.choice
            }
        }
        
        var url: LDReqURL = .verifyCommitWJUrl(params: params)
        if type == "findb" {
            url = .verifyCommitGRXXUrl(params: params)
        } else if type == "findc" {
            url = .verifyCommitGZXXUrl(params: params)
        } else if type == "finde" {
            url = .verifyCommitBKUrl(params: params)
        }
        
        self.view.LDShowActivity()
        LDReqManager.request(url: url, modelType: LDModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    var num: Int = 2
                    if self.type == "findc" {
                        num = 7
                    } else if self.type == "findd" {
                        num = 8
                    } else if self.type == "findf" {
                        num = 10
                    }
                    LDUploadingInfoManager.point(num: num, beginTime: self.beginTime, pID: self.pID, orderNO: self.OrderNo)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(_):
                break
            }
        }
    }

}
