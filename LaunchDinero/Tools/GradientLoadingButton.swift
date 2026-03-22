import UIKit

class GradientLoadingButton: UIControl {

    // MARK: - UI
    private let gradientLayer = CAGradientLayer()
    private let contentStack = UIStackView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let indicator = UIActivityIndicatorView(style: .medium)

    // MARK: - 状态
    private var isLoadingInternal = false

    // MARK: - 配置
    var hidesContentWhenLoading: Bool = true
    var disableWhenLoading: Bool = true

    /// 内边距（左右默认 8）
    var contentInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    // MARK: - 对外 loading
    var isLoading: Bool {
        get { isLoadingInternal }
        set { setLoading(newValue) }
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

    // MARK: - UI 初始化
    private func setupUI() {

        // 渐变
        gradientLayer.colors = [
            UIColor(red: 114/255.0, green: 152/255.0, blue: 46/255.0, alpha: 1).cgColor,
            UIColor(red: 91/255.0, green: 136/255.0, blue: 49/255.0, alpha: 1).cgColor,
            UIColor(red: 36/255.0, green: 96/255.0, blue: 56/255.0, alpha: 1).cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)

        layer.cornerRadius = 8
        clipsToBounds = true

        // Stack
        contentStack.axis = .horizontal
        contentStack.spacing = 8
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.isUserInteractionEnabled = false

        // image
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)

        // title（必须有）
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)

        contentStack.addArrangedSubview(iconImageView)
        contentStack.addArrangedSubview(titleLabel)

        addSubview(contentStack)

        // ⭐ 改成居中约束
        NSLayoutConstraint.activate([
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // loading
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: - 自适应尺寸（核心）
    override var intrinsicContentSize: CGSize {
        let stackSize = contentStack.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        return CGSize(
            width: stackSize.width + contentInsets.left + contentInsets.right,
            height: stackSize.height + contentInsets.top + contentInsets.bottom
        )
    }

    // MARK: - 对外 API

    func setTitle(_ text: String) {   // ⭐ 改成必传
        titleLabel.text = text
        invalidateIntrinsicContentSize()
    }

    func setImage(_ image: UIImage?) {
        iconImageView.image = image
        iconImageView.isHidden = (image == nil)
        invalidateIntrinsicContentSize()
    }

    func setTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }

    func setFont(_ font: UIFont) {
        titleLabel.font = font
        invalidateIntrinsicContentSize()
    }

    func setGradientColors(_ colors: [UIColor]) {
        gradientLayer.colors = colors.map { $0.cgColor }
    }

    // MARK: - Loading
    private func setLoading(_ loading: Bool) {
        guard loading != isLoadingInternal else { return }
        isLoadingInternal = loading

        if loading {
            indicator.startAnimating()

            if hidesContentWhenLoading {
                contentStack.alpha = 0
            }

            if disableWhenLoading {
                isUserInteractionEnabled = false
            }

        } else {
            indicator.stopAnimating()
            contentStack.alpha = 1
            isUserInteractionEnabled = true
        }
    }

    // MARK: - 点击高亮
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.alpha = self.isHighlighted ? 0.6 : 1.0
            }
        }
    }
}
