//
//  GradientView.swift
//

import UIKit

@IBDesignable
class GradientView: UIView {

    // MARK: - 渐变层
    private let gradientLayer = CAGradientLayer()

    // MARK: - 渐变颜色
    var colors: [UIColor] = [
        .systemBlue,
        .systemPurple
    ] {
        didSet { updateColors() }
    }

    // MARK: - 渐变方向
    var startPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
        didSet { gradientLayer.startPoint = startPoint }
    }

    var endPoint: CGPoint = CGPoint(x: 1, y: 0.5) {
        didSet { gradientLayer.endPoint = endPoint }
    }

    // MARK: - 圆角
    var cornerRadius: CGFloat = 0 {
        didSet { updateCorner() }
    }

    /// 支持部分圆角（关键）
    var maskedCorners: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner
    ] {
        didSet { updateCorner() }
    }

    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    // MARK: - 初始化渐变
    private func setupGradient() {
        // 防止重复插入
        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }

        updateColors()
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: - 更新颜色
    private func updateColors() {
        gradientLayer.colors = colors.map { $0.cgColor }
    }

    // MARK: - 更新圆角（统一入口）
    private func updateCorner() {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
    }

    // MARK: - 便捷方法

    /// 横向渐变
    func horizontalGradient(_ colors: [UIColor]) {
        self.colors = colors
        startPoint = CGPoint(x: 0, y: 0.5)
        endPoint = CGPoint(x: 1, y: 0.5)
    }

    /// 纵向渐变
    func verticalGradient(_ colors: [UIColor]) {
        self.colors = colors
        startPoint = CGPoint(x: 0.5, y: 0)
        endPoint = CGPoint(x: 0.5, y: 1)
    }

    /// 对角线渐变
    func diagonalGradient(_ colors: [UIColor]) {
        self.colors = colors
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
    }

    // MARK: - UIKit 风格圆角设置（推荐用这个）

    func setCorners(_ corners: UIRectCorner, radius: CGFloat) {
        cornerRadius = radius

        var mask: CACornerMask = []

        if corners.contains(.topLeft) {
            mask.insert(.layerMinXMinYCorner)
        }
        if corners.contains(.topRight) {
            mask.insert(.layerMaxXMinYCorner)
        }
        if corners.contains(.bottomLeft) {
            mask.insert(.layerMinXMaxYCorner)
        }
        if corners.contains(.bottomRight) {
            mask.insert(.layerMaxXMaxYCorner)
        }

        maskedCorners = mask
    }
}
