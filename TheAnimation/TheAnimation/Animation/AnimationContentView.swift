//
//  AnimationContentView.swift
//  TheAnimation
//
//  Created by Nikita Kuzmin on 08.11.2024.
//

import UIKit

final class AnimationContentView: UIView {
    
    private enum Constants {
        static let animationDuration: CGFloat = 0.5
        static let scalingRation: CGFloat = 1.5
        static let layoutMargin: CGFloat = 20
    }
    
    // MARK: - Properties
    
    private(set) var animator: UIViewPropertyAnimator?
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Kit"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Subviews
    
    private(set) lazy var squareView: SquareView = {
        let view = SquareView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var sliderView: UISlider = {
        let view = UISlider()
        view.setThumbImage(.burger, for: [])
        view.tintColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        makeConstraints()
        setupAnimator()
        setupSliderActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
    }
}

// MARK: - Private

private extension AnimationContentView {
    func addSubviews() {
        addSubview(imageView)
        addSubview(sliderView)
        addSubview(squareView)
    }
 
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            sliderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            sliderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layoutMargin),
            sliderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.layoutMargin),
            
            squareView.widthAnchor.constraint(equalToConstant: 75),
            squareView.heightAnchor.constraint(equalToConstant: 75),
            squareView.bottomAnchor.constraint(equalTo: sliderView.topAnchor, constant: -75),
            squareView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layoutMargin),
        ])
    }
    
    func setupAnimator() {
        let animator = UIViewPropertyAnimator(duration: Constants.animationDuration,curve: .easeOut)
        animator.pausesOnCompletion = true
        
        animator.addAnimations {
            let newPositionX = self.frame.width - self.squareView.frame.width - (Constants.layoutMargin * 2)
            self.squareView.frame.origin.x = newPositionX
            self.squareView.transform = CGAffineTransform(
                scaleX: Constants.scalingRation,
                y: Constants.scalingRation
            ).rotated(by: .pi / 2)
        }
        self.animator = animator
    }
    
    func setupSliderActions() {
        let action = UIAction { _ in
            self.squareView.changeAlpha(self.sliderView.value)
            self.animator?.fractionComplete = CGFloat(self.sliderView.value)
        }
        let releaseAction = UIAction { _ in
            self.animator?.startAnimation()
            self.sliderView.setValue(1, animated: true)
            self.squareView.changeAlpha(1)
        }
        
        sliderView.addAction(action, for: .valueChanged)
        sliderView.addAction(releaseAction, for: [.touchUpInside, .touchUpOutside])
    }
}
