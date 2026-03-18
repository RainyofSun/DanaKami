//
//  LDUserVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDUserVC: LDBaseVC, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var userModel: LDUserModel = LDUserModel()
    
    lazy var headerBgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "user_img"))
        return img
    }()
    
    lazy var avatarImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "user_avatar"))
        return img
    }()
    
    lazy var nameLb: UILabel = {
        let label = UILabel(text: "**********",
                            color: .white,
                            font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    lazy var subtitleLb: UILabel = {
        let label = UILabel(text: LDText(key: "Welcome to LaunchDinero"),
                            color: .white,
                            font: .systemFont(ofSize: 13))
        return label
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = LDBgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var bannerImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "user_banner"))
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let label = UILabel(text: LDText(key: "Common functions"),
                            color: UIColor(hex: "#2A2727"),
                            font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    lazy var collectionV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 166, height: 92)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(LDUserCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(headerBgImg)
        self.view.addSubview(avatarImg)
        self.view.addSubview(nameLb)
        self.view.addSubview(subtitleLb)
        self.view.addSubview(bgView)
        bgView.addSubview(bannerImg)
        bgView.addSubview(titleLb)
        bgView.addSubview(collectionV)
        
        headerBgImg.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        avatarImg.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.bottom.equalTo(headerBgImg).offset(-44)
            make.width.height.equalTo(58)
        }
        nameLb.snp.makeConstraints { make in
            make.left.equalTo(avatarImg.snp.right).offset(12)
            make.top.equalTo(avatarImg).offset(6)
            make.height.equalTo(22)
        }
        subtitleLb.snp.makeConstraints { make in
            make.left.equalTo(nameLb)
            make.bottom.equalTo(avatarImg).offset(-6)
            make.height.equalTo(18)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headerBgImg.snp.bottom).offset(-20)
            make.left.right.bottom.equalToSuperview()
        }
        bannerImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(bannerImg.snp.bottom).offset(18)
            make.left.equalTo(14)
            make.height.equalTo(22)
        }
        collectionV.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reqData()
    }
    
    func reqData() {
        self.view.LDShowActivity()
        LDReqManager.request(url: .userInfoUrl, modelType: LDUserModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if let m = success.financial {
                    self.userModel = m
                    self.nameLb.text = self.userModel.userInfo.kate
                    self.collectionV.reloadData()
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(let failure):
                self.view.LDToast(text: failure.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.userModel.mathematicians.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LDUserCell
        if let m = self.userModel.mathematicians[safe: indexPath.item] {
            cell.data = m
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = LDSetupVC()
//        viewController.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(viewController, animated: true)
        if let m = self.userModel.mathematicians[safe: indexPath.item] {
            jumpPage(vc: self, url: m.infinity)
        }
    }

}
