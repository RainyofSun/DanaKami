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
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    lazy var hintLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Verify upload photo hint"),
                         color: UIColor(hex: "#E31C1C"),
                         font: .systemFont(ofSize: 13))
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
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

        self.view.addSubview(bgView)
        self.view.insertSubview(bgView, belowSubview: stepV)
        bgView.addSubview(tableView)
        bgView.addSubview(hintLb)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(14 + LDNavMaxY)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(nextBtn.snp.top).offset(-14)
        }
        stepV.snp.remakeConstraints { make in
            make.top.equalTo(bgView).offset(14)
            make.left.equalTo(29)
            make.right.equalTo(-29)
        }
        hintLb.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(65)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(hintLb.snp.top)
        }
        
        reqData()
    }
    
    override func nextBtnClick() {
        if self.data.actress.society == 0 {
            isFirst = true
            self.takePhoto()
        } else if self.data.subtext.society == 0 {
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
        cell.titleLb.text = indexPath.row == 0 ? self.data.id_front_msg : self.data.face_msg
        cell.bgImg.image = UIImage(named: indexPath.row == 0 ? "verify_photo_img_1" : "verify_photo_img_2")
        cell.photoImg.kf.setImage(with: URL(string: indexPath.row == 0 ? self.data.actress.infinity : self.data.subtext.infinity))
        cell.photoImg.contentMode = indexPath.row == 0 ? .scaleToFill : .scaleAspectFill
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.data.actress.society == 0 {
            isFirst = true
            self.takePhoto()
        } else if self.data.subtext.society == 0 && indexPath.row == 1 {
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
            LDReqManager.request(url: .verifyCommitSFZUrl(params: ["listed": isFirst ? "11" : "10"], imgData: imgData), modelType: LDVerifyDetailConfirmModel.self) { model in
                self.view.LDHideActivity()
                switch model {
                case .success(let success):
                    if success.numbers == 0 {
                        LDUploadingInfoManager.point(num: self.isFirst ? 3 : 6, beginTime: self.beginTime, pID: self.pID, orderNO: self.OrderNo)
                        self.reqData()
                        if self.isFirst {
                            if let m = success.financial, m.social != 0 {
                                self.popup.custom(with: LDPopupConfig()) {
                                    let popupV = LDLDVerifyDetailConfirmPopup(frame: CGRect(x: 0, y: 0, width: 339, height: 519))
                                    popupV.nameV.textTf.text = m.commented
                                    popupV.IDV.textTf.text = m.lipset
                                    popupV.dateV.textTf.text = m.nominee
                                    popupV.CommitClourse = {
                                        self.reqData()
                                    }
                                    return popupV
                                }
                            }
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
            let popupV = LDVerifyDetailBPopup(frame: CGRect(x: 0, y: 0, width: 339, height: 558))
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
