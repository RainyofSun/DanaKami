//
//  LDMainVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDMainVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource, AutoHiddenNavigationBar {
    
    var isList: Bool = false
    
    var mainData: LDMainModel = LDMainModel()
    var itemModel: LDMainrRamanujanModel = LDMainrRamanujanModel()
    var listModel: LDMainrRamanujanModel = LDMainrRamanujanModel()
    var serviceModel: LDMainCenturiesModel = LDMainCenturiesModel()
    var festivalModel: LDMainFestivalModel = LDMainFestivalModel()
    var list: [LDMainrRamanujanModel] = []
    var bannerList: [LDMainrRamanujanModel] = []
    
    lazy var mainTb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.contentInsetAdjustmentBehavior = .never
        tb.register(LDMainListCell.self, forCellReuseIdentifier: "Cell2")
        tb.register(UserAvatarView.self, forCellReuseIdentifier: NSStringFromClass(UserAvatarView.self))
        tb.register(MainTableViewFirstCell.self, forCellReuseIdentifier: NSStringFromClass(MainTableViewFirstCell.self))
        tb.register(MainTableViewLastCell.self, forCellReuseIdentifier: NSStringFromClass(MainTableViewLastCell.self))
        tb.register(MainTableViewEnglishCell.self, forCellReuseIdentifier: NSStringFromClass(MainTableViewEnglishCell.self))
        tb.es.addPullToRefresh {
            self.reqData()
        }
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mainTb)
        
        mainTb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-LDHomeBarHeight-LDTabBarHeight)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            LDPermissionManager.tracking()
        }
        
        self.view.LDShowActivity()
        self.reqData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isList {
            return list.count + 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let avatarCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserAvatarView.self), for: indexPath) as? UserAvatarView {
                avatarCell.avatarProtocol = self
                return avatarCell
            }
        } else if indexPath.row == 1 {
            if let applyCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MainTableViewFirstCell.self), for: indexPath) as? MainTableViewFirstCell {
                if isList {
                    applyCell.model = self.listModel
                } else {
                    applyCell.model = self.itemModel
                }
                
                applyCell.showBottomTip = isList
                
                return applyCell
            }
        } else {
            
            if isList {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! LDMainListCell
                if let m = list[safe: indexPath.row - 2] {
                    cell.model = m
                }
                return cell
            } else {
                if isEnglish {
                    if let _lastCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MainTableViewEnglishCell.self), for: indexPath) as? MainTableViewEnglishCell {
                        _lastCell.eProtocol = self
                        return _lastCell
                    }
                } else {
                    if let _lastCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MainTableViewLastCell.self), for: indexPath) as? MainTableViewLastCell {
                        _lastCell.eProtocol = self
                        return _lastCell
                    }
                }
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            applyBtnClick()
        } else {
            if isList {
                if let m = list[safe: indexPath.row - 2] {
                    allowProductDetail(vc: self, pID: "\(m.flag)")
                }
            }
        }
    }
    
    func reqData() {
        
        LDUploadingInfoManager.location()
        LDUploadingInfoManager.idfaIdfv()
        LDUploadingInfoManager.deviceInfo()
        
        LDReqManager.request(url: .mainUrl, modelType: LDMainModel.self) { model in
            self.view.LDHideActivity()
            self.mainTb.es.stopPullToRefresh()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    if let m = success.financial {
                        self.mainData = m
                        self.serviceModel = m.centuries
                        self.festivalModel = m.festival
                        self.refreshData()
                    }
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        isList = false
        for item in mainData.mathematicians {
            if item.listeder == "homeb" {
                if let m = item.ramanujan[safe: 0] {
                    self.itemModel = m
                }
            } else if item.listeder == "homec" {
                isList = true
                if let m = item.ramanujan[safe: 0] {
                    self.listModel = m
                }
            } else if item.listeder == "homed" {
                isList = true
                self.list = item.ramanujan
            }
        }
        
        self.mainTb.reloadData()
    }
    
    @objc func applyBtnClick() {
        if isLogin(currentVC: self) {
            if isList {
                allowProductDetail(vc: self, pID: "\(self.listModel.flag)")
            } else {
                allowProductDetail(vc: self, pID: "\(self.itemModel.flag)")
            }
            
        }
    }

}

extension LDMainVC: UserAvatarProtocol {
    func gotoService() {
        if self.serviceModel.feedbackUrl.isEmpty {
            return
        }
        
        jumpPage(vc: self, url: self.serviceModel.feedbackUrl)
    }
}

extension LDMainVC: EnglishCellProtocol {
    func gotoApply(sender: GradientLoadingButton) {
        if self.festivalModel.international.isEmpty {
            return
        }
        
        jumpPage(vc: self, url: self.festivalModel.international)
    }
}
