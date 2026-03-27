//
//  LDVerifyDetailCVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit
import ContactsUI

class LDVerifyDetailCVC: LDVerifyBaseVC, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate {
    
    var data: LDVerifyDetailCModel = LDVerifyDetailCModel()
    
    var selectedIndex: Int = 0
    
    lazy var tb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = .clear
        tb.delegate = self
        tb.dataSource = self
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.register(LDVerifyDetailCCell.self, forCellReuseIdentifier: "Cell")
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        cornerBgView.addSubview(tb)
        
        tb.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBgView.snp.top)
        }
        
        reqData()
        
        self.beginTime = LDNowTime()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.catholics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDVerifyDetailCCell
        if let m = self.data.catholics[safe: indexPath.row] {
            cell.model = m
            
            cell.relationClourse = {
                self.popup.custom(with: LDPopupConfig()) {
                    let popupV = LDLDVerifyDetailSelectPopup(frame: CGRect(x: 0, y: 0, width: 339, height: 502))
                    popupV.titleLb.text = m.tensions
                    popupV.list = m.lyrics
                    popupV.selectedClourse = { i in
                        self.data.catholics[indexPath.row].irish = "\(m.lyrics[i].listeder)"
                        self.tb.reloadData()
                    }
                    return popupV
                }
            }
            cell.contactsClourse = {
                self.selectedIndex = indexPath.row
                LDUploadingInfoManager.contacts()
                LDPermissionManager.contacts { isAllow in
                    if isAllow {
                        let cpvc = CNContactPickerViewController()
                        cpvc.delegate = self
                        self.present(cpvc, animated: true)
                    } else {
                        LDPermissionManager.requestPermission(currentVC: self)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let name = CNContactFormatter.string(from: contact, style: .fullName) {
            var phoneStr = ""
            for phone in contact.phoneNumbers {
                phoneStr = phone.value.stringValue
                break
            }
            phoneStr = phoneStr.replacingOccurrences(of: "-", with: "")
            self.data.catholics[selectedIndex].scorer = name
            self.data.catholics[selectedIndex].backdrop = phoneStr
            self.tb.reloadData()
        }
    }
    
    func reqData() {
        self.view.LDShowActivity()
        LDReqManager.request(url: .verifyDetailLXRUrl(params: ["foreign": self.pID]), modelType: LDVerifyDetailCModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if let m = success.financial {
                    self.data = m
                    self.tb.reloadData()
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(_):
                break
            }
        }
    }
    
    override func nextBtnClick() {
        var params: [String: Any] = ["foreign": self.pID]
        let contactsList: [[String: Any]] = data.catholics.map { model in
            var contacts: [String: Any] = [:]
            for item in model.lyrics {
                if model.irish == "\(item.listeder)" {
                    contacts["irish"] = item.listeder
                    break
                }
            }
            contacts["scorer"] = model.scorer
            contacts["backdrop"] = model.backdrop
            return contacts
        }
        do {
            let contactsData = try JSONSerialization.data(withJSONObject: contactsList, options: [])
            if let contactsStr = String(data: contactsData, encoding: .utf8) {
                params["financial"] = contactsStr
            }
        } catch {
            
        }
        
        self.view.LDShowActivity()
        LDReqManager.request(url: .verifyCommitLXRUrl(params: params), modelType: LDModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    LDUploadingInfoManager.point(num: 9, beginTime: self.beginTime, pID: self.pID, orderNO: self.OrderNo)
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
