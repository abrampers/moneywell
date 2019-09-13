//
//  GoalAmountView.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

internal class GoalAmountView: UIView {
    private let achievedLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Achieved Amount", size: 18, weight: .medium, color: .n100)
        
        return label
    }()
    
    private let achievedAmountLabel = UILabel()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Target Amount", size: 18, weight: .medium, color: .n100)
        
        return label
    }()
    
    private let targetAmountLabel = UILabel()
    
    private let progressView = UIImageView()
    
    private lazy var achievedStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.achievedLabel, self.achievedAmountLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var targetStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.targetLabel, self.targetAmountLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var leftStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.achievedStack, self.targetStack])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.leftStack, self.progressView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        
        return stack
    }()

    internal init(achievedAmount: Int, targetAmount: Int, progressImage: UIImage) {
        super.init(frame: .zero)
        
        setupUI(achievedAmount: achievedAmount, targetAmount: targetAmount, progressImage: progressImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(achievedAmount: Int, targetAmount: Int, progressImage: UIImage) {
        achievedAmountLabel.attributedText = .text(achievedAmount.currencyFormat, size: 36, weight: .bold, color: .black)
        targetAmountLabel.attributedText = .text(targetAmount.currencyFormat, size: 26, weight: .bold, color: .black)
        progressView.image = progressImage
        
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
    }
}
