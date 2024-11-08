//
//  SquareView.swift
//  TheAnimation
//
//  Created by Nikita Kuzmin on 08.11.2024.
//

import UIKit

final class SquareView: UIView {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Subviews
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform = view.transform.rotated(by: -(.pi / 2))
        view.layer.cornerRadius = Constants.cornerRadius
        view.addBackgroundImageView(.russian)
        view.alpha = 0
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = .trump
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
        addSubviews()
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeAlpha(_ value: Float) {
        containerView.alpha = CGFloat(value)
    }
}

// MARK: - Private

private extension SquareView {
    func setupUI() {
        layer.cornerRadius = Constants.cornerRadius
        addBackgroundImageView(.usa)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        bringSubviewToFront(containerView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }

}

private extension UIView {
    func addBackgroundImageView(_ image: UIImage) {
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = layer.cornerRadius
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
