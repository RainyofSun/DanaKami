//
//  LDVerifyListCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/20.
//

import UIKit

protocol VerifyCellProtocol: AnyObject {
    func didTapCellControl(index: Int)
}

class LDVerifyListCell: LDCell {
    
    open weak var cellDelegate: VerifyCellProtocol?
    
    lazy var tipLab: UILabel = UILabel(text: LDText(key: "Certification Items"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "DBDCA5")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()

        self.contentView.addSubview(bgView)
        bgView.addSubview(self.tipLab)
        
        bgView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.verticalEdges.equalToSuperview().inset(15)
        }
        
        tipLab.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
        }
    }
    
    func buildListView(cellList: [LDVerifyPromisingModel]) {
        self.bgView.subviews.forEach { item in
            if let _viskw = item as? VerifyCellItem {
                _viskw.removeFromSuperview()
            }
        }
        
        var topItem: VerifyCellItem?
        
        cellList.enumerated().forEach { (index, item) in
            let cellItem = VerifyCellItem(frame: CGRectZero)
            cellItem.isSelected = item.society == 1
            if let _url = URL(string: item.outstanding) {
                cellItem.iconImgView.kf.setImage(with: _url, options: [.transition(.fade(0.3))])
            }
            cellItem.titleLb.text = item.rainmaker
            cellItem.tag = 1000 + index
            cellItem.addTarget(self, action: #selector(clickCellControl(sender: )), for: UIControl.Event.touchUpInside)
            
            self.bgView.addSubview(cellItem)
            
            if let _top = topItem {
                if index == cellList.count - 1 {
                    cellItem.snp.makeConstraints { make in
                        make.horizontalEdges.equalTo(_top)
                        make.top.equalTo(_top.snp.bottom).offset(10)
                        make.bottom.equalToSuperview().offset(-15)
                    }
                } else {
                    cellItem.snp.makeConstraints { make in
                        make.horizontalEdges.equalTo(_top)
                        make.top.equalTo(_top.snp.bottom).offset(10)
                    }
                }
            } else {
                cellItem.snp.makeConstraints { make in
                    make.horizontalEdges.equalToSuperview().inset(15)
                    make.top.equalTo(self.tipLab.snp.bottom).offset(10)
                }
            }
            
            topItem = cellItem
        }
    }

    @objc func clickCellControl(sender: VerifyCellItem) {
        cellDelegate?.didTapCellControl(index: sender.tag - 1000)
    }
}
