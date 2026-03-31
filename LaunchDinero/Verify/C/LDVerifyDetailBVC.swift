//
//  LDVerifyDetailBVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailBVC: LDVerifyBaseVC, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var data: LDVerifyDetailBModel = LDVerifyDetailBModel()
    
    var isFirst: Bool = true
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.bounces = false
        tb.register(LDVerifyDetailBCell.self, forCellReuseIdentifier: "Cell")
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        cornerBgView.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBgView.snp.top)
        }
        
        reqData()
    }
    
    override func nextBtnClick() {
        if self.data.ramanujan.parts.isEmpty {
            isFirst = true
            self.takePhoto()
        } else if self.data.ramanujan.power.isEmpty {
            isFirst = false
            self.takePhoto()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDVerifyDetailBCell
        cell.titleLb.text = indexPath.row == 0 ? self.data.ramanujan.concern : self.data.ramanujan.fourth
        if indexPath.row == 0 {
            if self.data.ramanujan.parts.isEmpty {
                cell.iconImg.image = isEnglish ? UIImage(named: "vertify_front_en") : UIImage(named: "vertify_front")
            } else {
                cell.iconImg.kf.setImage(with: URL(string: self.data.ramanujan.parts))
            }
            
            cell.containerView.isHidden = !self.data.ramanujan.parts.isEmpty
            cell.vertifyLab.isHidden = !cell.containerView.isHidden
        }
        
        if indexPath.row == 1 {
            if self.data.ramanujan.power.isEmpty {
                cell.iconImg.image = UIImage(named: "vertify_back")
            } else {
                cell.iconImg.kf.setImage(with: URL(string: self.data.ramanujan.power))
            }
            
            cell.containerView.isHidden = !self.data.ramanujan.parts.isEmpty
            cell.vertifyLab.isHidden = !cell.containerView.isHidden
        }
        
        cell.photoImg.contentMode = indexPath.row == 0 ? .scaleToFill : .scaleAspectFill
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.data.ramanujan.parts.isEmpty {
            isFirst = true
            self.takePhoto()
        } else if self.data.ramanujan.power.isEmpty {
            isFirst = false
            self.takePhoto()
        }
    }
    
    func reqData() {
        self.view.LDShowActivity()
        LDReqManager.request(url: .verifyDetailSFZUrl(params: ["foreign": self.pID]), modelType: LDVerifyDetailBModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if let m = success.financial {
                    self.data = m
                    self.isFirst = self.data.ramanujan.parts.isEmpty
                    self.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
    
    func commitPhoto(photo: UIImage) {
        self.view.LDShowActivity()
        if let imgData = UIImage.verifyPhoto(image: photo) {
            LDReqManager.request(url: .verifyCommitSFZUrl(params: ["listeder": isFirst ? "11" : "10"], imgData: imgData), modelType: LDVerifyDetailConfirmModel.self) { model in
                self.view.LDHideActivity()
                switch model {
                case .success(let success):
                    if success.numbers == 0 {
                        self.reqData()
                        if self.isFirst {
                            if let m = success.financial, m.social != 0 {
                                self.popup.custom(with: LDPopupConfig()) {
                                    let popupV = LDLDVerifyDetailConfirmPopup(frame: CGRect(x: 0, y: 0, width: 315, height: 460))
                                    popupV.titleLb.text = self.navTitle
                                    popupV.pid = self.pID
                                    popupV.buildItemList(source: m.determines)
                                    popupV.CommitClourse = {
                                        LDUploadingInfoManager.fengkpoint(num: self.isFirst ? FengKongMaiDian.ShenFenZhengZhengMian : FengKongMaiDian.ShenFenZhengBeiMian, beginTime: self.beginTime, endTime: LDNowTime(), pID: self.pID, orderNO: self.OrderNo)
                                        self.reqData()
                                    }
                                    return popupV
                                }
                            } else {
                                LDUploadingInfoManager.fengkpoint(num: self.isFirst ? FengKongMaiDian.ShenFenZhengZhengMian : FengKongMaiDian.ShenFenZhengBeiMian, beginTime: self.beginTime, endTime: LDNowTime(), pID: self.pID, orderNO: self.OrderNo)
                            }
                        } else {
                            LDUploadingInfoManager.fengkpoint(num: self.isFirst ? FengKongMaiDian.ShenFenZhengZhengMian : FengKongMaiDian.ShenFenZhengBeiMian, beginTime: self.beginTime, endTime: LDNowTime(), pID: self.pID, orderNO: self.OrderNo)
                        }
                    } else {
                        self.view.LDToast(text: success.information)
                    }
                    
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func takePhoto() {
        self.beginTime = LDNowTime()
        self.popup.custom(with: LDPopupConfig()) {
            let popupV = LDVerifyDetailBPopup(frame: CGRect(x: 0, y: 0, width: 315, height: 440))
            popupV.titleLb.text = self.isFirst ? self.data.ramanujan.concern : self.data.ramanujan.fourth
            popupV.isFirst = self.isFirst
            popupV.nextClourse = {
                self.showCamera()
            }
            return popupV
        }
        
    }
    
    func showCamera() {
        LDPermissionManager.camera { isAllow in
            DispatchQueue.main.async {
                if isAllow {
                    DispatchQueue.main.async {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            let imagePC = UIImagePickerController()
                            imagePC.sourceType = .camera
                            imagePC.delegate = self
                            imagePC.cameraDevice = self.isFirst ? .rear : .front
                            imagePC.allowsEditing = false
                            self.present(imagePC, animated: true)
                        }
                    }
                } else {
                    LDPermissionManager.requestPermission(currentVC: self)
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.commitPhoto(photo: image)
        }
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }

}
