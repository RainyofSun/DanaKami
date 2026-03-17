//
//  LDMainCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/18.
//

import UIKit
import FSPagerView

class LDMainCell: LDCell, FSPagerViewDelegate, FSPagerViewDataSource {
    
    var model: LDMainrRamanujanModel = LDMainrRamanujanModel() {
        didSet {
            amountA.text = model.southeastern
            amountB.text = model.telly
            
            termA.text = model.leading
            termB.text = model.female
            
            rateA.text = model.satellite
            rateB.text = model.actors
            
            applyBtn.setTitle(model.turkish, for: .normal)
        }
    }
    
    var bannerData: [LDMainrRamanujanModel] = [] {
        didSet {
            self.bannerV.reloadData()
            
            bannerV.isHidden = bannerData.count <= 0
            
            knowLb.snp.remakeConstraints { make in
                if bannerData.count > 0 {
                    make.top.equalTo(bannerV.snp.bottom).offset(14)
                } else {
                    make.top.equalTo(bgImageView.snp.bottom).offset(10)
                }
                make.left.equalTo(14 * LDScale)
            }
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: LDText(key: "main_1_img")))
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var amountA: UILabel = {
        let lb = UILabel(text: "",
                         color: .white)
        return lb
    }()
    lazy var amountB: UILabel = {
        let lb = UILabel(text: "",
                         color: .white,
                         font: UIFont(name: "Racing Sans One", size: 58) ?? .systemFont(ofSize: 58))
        return lb
    }()
    
    lazy var termI: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_1_term"))
        return img
    }()
    lazy var termA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .systemFont(ofSize: 14))
        return lb
    }()
    lazy var termB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 15))
        return lb
    }()
    
    lazy var rateI: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_1_rate"))
        return img
    }()
    lazy var rateA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .systemFont(ofSize: 14))
        return lb
    }()
    lazy var rateB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 15))
        return lb
    }()
    
    lazy var applyBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "main_1_btn"), for: .normal)
        btn.setTitle("", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 22)
        btn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var stepLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Loan process"),
                         font: .boldSystemFont(ofSize: 16))
        return lb
    }()
    lazy var stepImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: LDText(key: "main_1_step")))
        return img
    }()
    
    lazy var knowLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Do you know us?"),
                         font: .boldSystemFont(ofSize: 16))
        return lb
    }()
    lazy var knowImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: LDText(key: "main_1_know")))
        return img
    }()
    
    lazy var bannerV: FSPagerView = {
        let view = FSPagerView()
        view.delegate = self
        view.dataSource = self
        view.isInfinite = false
        view.backgroundColor = .clear
        view.itemSize = CGSize(width: LDScreenWidth, height: 113)
        view.register(LDMainBannerCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(bgImageView)
        bgImageView.addSubview(amountA)
        bgImageView.addSubview(amountB)
        bgImageView.addSubview(termI)
        bgImageView.addSubview(termA)
        bgImageView.addSubview(termB)
        bgImageView.addSubview(rateI)
        bgImageView.addSubview(rateA)
        bgImageView.addSubview(rateB)
        bgImageView.addSubview(applyBtn)
        bgImageView.addSubview(stepLb)
        bgImageView.addSubview(stepImg)
        self.contentView.addSubview(knowLb)
        self.contentView.addSubview(knowImg)
        self.contentView.addSubview(bannerV)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        amountA.snp.makeConstraints { make in
            make.top.equalTo(123)
            make.left.equalTo(14)
            make.height.equalTo(22)
        }
        amountB.snp.makeConstraints { make in
            make.top.equalTo(amountA.snp.bottom).offset(5)
            make.left.equalTo(14)
            make.height.equalTo(73)
        }
        termI.snp.makeConstraints { make in
            make.top.equalTo(286)
            make.left.equalTo(isiPhoneX ? 28 : 42)
            make.width.height.equalTo(35)
        }
        termA.snp.makeConstraints { make in
            make.left.equalTo(termI.snp.right).offset(10)
            make.top.equalTo(termI)
        }
        termB.snp.makeConstraints { make in
            make.left.equalTo(termA)
            make.bottom.equalTo(termI)
        }
        rateA.snp.makeConstraints { make in
            make.top.equalTo(termI)
            make.right.equalTo(isiPhoneX ? -28 : -42)
        }
        rateI.snp.makeConstraints { make in
            make.top.width.height.equalTo(termI)
            make.right.equalTo(rateA.snp.left).offset(-10)
        }
        rateB.snp.makeConstraints { make in
            make.bottom.equalTo(rateI)
            make.left.equalTo(rateA)
        }
        applyBtn.snp.makeConstraints { make in
            make.top.equalTo(termI.snp.bottom).offset(19)
            make.left.equalTo(28)
            make.right.equalTo(-28)
        }
        stepImg.snp.makeConstraints { make in
            make.bottom.equalTo(-21 * LDScale)
            make.left.right.equalTo(applyBtn)
        }
        stepLb.snp.makeConstraints { make in
            make.left.equalTo(stepImg)
            make.bottom.equalTo(stepImg.snp.top).offset(-10 * LDScale)
        }
        knowLb.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(10)
            make.left.equalTo(14 * LDScale)
        }
        knowImg.snp.makeConstraints { make in
            make.top.equalTo(knowLb.snp.bottom).offset(10)
            make.left.equalTo(14 * LDScale)
            make.bottom.right.equalTo(-14 * LDScale)
        }
        
        bannerV.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(113)
        }
    }
    
    @objc func applyBtnClick() {
        if isLogin(currentVC: self.parentVC()) {
            allowProductDetail(vc: self.parentVC(), pID: "\(model.flag)")
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        bannerData.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "Cell", at: index) as! LDMainBannerCell
        if let m = bannerData[safe: index] {
            cell.model = m
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let m = bannerData[safe: index] {
            jumpPage(vc: self.parentVC(), url: m.infinity)
        }
    }

}

class LDMainBannerCell: FSPagerViewCell {
    
    var model: LDMainrRamanujanModel = LDMainrRamanujanModel() {
        didSet {
            img.kf.setImage(with: URL(string: model.knew))
        }
    }
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.isUserInteractionEnabled = true
        img.backgroundColor = .red
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.top.bottom.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
