//
//  LDExtension.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import Foundation
import UIKit
import Toast_Swift

extension UIColor {
    convenience init(hex: String) {
        var formatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if formatted.hasPrefix("#") {
            formatted.removeFirst()
        }

        var value: UInt64 = 0
        Scanner(string: formatted).scanHexInt64(&value)

        let red = CGFloat((value & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((value & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(value & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIView {
    func parentVC() -> UIViewController {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let vc = responder as? UIViewController {
                return vc
            }
        }
        return UIViewController()
    }
    
    func LDShowActivity() {
        ToastManager.shared.isTapToDismissEnabled = false
        self.isUserInteractionEnabled = false
        self.makeToastActivity(.center)
    }
    
    func LDHideActivity() {
        self.isUserInteractionEnabled = true
        self.hideAllToasts(includeActivity: true)
    }
    
    func LDToast(text: String) {
        self.makeToast(text, position: .center)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }
}

extension UILabel {
    convenience init(text: String,
                     color: UIColor = UIColor(hex: "#333333"),
                     font: UIFont = .systemFont(ofSize: 16.0),
                     alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.textColor = color
        self.font = font
        self.textAlignment = alignment
    }
}

extension UIButton {
    convenience init(text: String,
                     color: UIColor = UIColor(hex: "#333333"),
                     selectedColor: UIColor = UIColor(hex: "#333333"),
                     font: UIFont = .systemFont(ofSize: 16.0)) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(selectedColor, for: .selected)
        self.titleLabel?.font = font
    }
}

extension UIImage {
    static func verifyPhoto(image: UIImage) -> Data? {
        let max = 100 * 1024
        let min = 50 * 1024
        
        var compression: CGFloat = 1.0
        guard var imgData = image.jpegData(compressionQuality: compression) else {
            return nil
        }
        
        while imgData.count > max && compression > 0.1 {
            compression -= 0.1
            if let compressedData = image.jpegData(compressionQuality: compression) {
                imgData = compressedData
            }
        }

        if imgData.count < min {
            return imgData
        }
        
        return imgData
    }
    
    
    func stretchable() -> UIImage {
        let w = self.size.width / 2
        let h = self.size.height / 2
        return resizableImage(
            withCapInsets: UIEdgeInsets(top: h, left: w, bottom: h, right: w),
            resizingMode: .stretch
        )
    }
}

enum InterFontWeight: String {
    case Regular = "GalanoGrotesque-Regular"
    case Bold = "GalanoGrotesque-SemiBold"
    case Extra_Bold = "SharpGrotesk-Bold20"
}

extension UIFont {
    static func interFont(size: CGFloat, fontStyle: InterFontWeight) -> UIFont {
        return self.init(name: fontStyle.rawValue, size: size) ?? UIFont.systemFont(ofSize: size);
    }
}
