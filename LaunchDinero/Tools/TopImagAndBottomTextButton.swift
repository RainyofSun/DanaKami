//
//  TopImagAndBottomTextButton.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/24.
//

import UIKit

class ImageTopTitleBottomButton: UIControl {

    // MARK: - UI
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()

    // MARK: - 属性
    var spacing: CGFloat = 6 {
        didSet { stackView.spacing = spacing }
    }

    var imageSize: CGSize = CGSize(width: 55, height: 55) {
        didSet {
            imageView.constraints.forEach { constraint in
                if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                    constraint.isActive = false
                }
            }
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
        }
    }

    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // 图片
        imageView.contentMode = .scaleAspectFit

        // 文字
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center

        // 垂直布局
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = spacing
        stackView.isUserInteractionEnabled = false
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // 默认尺寸
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true

        // 点击事件（高亮效果）
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }

    // MARK: - 对外方法
    func set(image: UIImage?, title: String?) {
        imageView.image = image
        titleLabel.text = title
    }

    // MARK: - 点击态反馈
    @objc private func touchDown() {
        alpha = 0.5
    }

    @objc private func touchUp() {
        alpha = 1.0
    }
}
