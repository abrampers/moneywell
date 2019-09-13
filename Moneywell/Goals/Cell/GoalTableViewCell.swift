//
//  GoalTableViewCell.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

internal class GoalTableViewCell: UITableViewCell {
    public static let identifier = "GoalTableViewCell"
    
    private let iconView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        
        return label
    }()
    
    private let totalProgressLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Total Progress", size: 18, weight: .medium, color: .n50)
        
        return label
    }()
    
    private let currentAmountLabel = UILabel()
    private let targetAmountLabel = UILabel()
    
    private let etaLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("ETA", size: 18, weight: .medium, color: .n50)
        
        return label
    }()
    
    private let estimatedLabel = UILabel()
    
    private let progressView = UIImageView()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.iconView, self.titleLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        
        return stack
    }()
    
    private lazy var progressStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.totalProgressLabel, self.currentAmountLabel, self.targetAmountLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var estimatedStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.etaLabel, self.estimatedLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 1
        
        return stack
    }()
    
    private lazy var lowerLeftStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.progressStack, self.estimatedStack])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var lowerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.lowerLeftStack, self.progressView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        
        return stack
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        
        return view
    }()

    internal func configureCell(goal: Goal) {
        iconView.image = goal.image
        titleLabel.attributedText = .text(goal.name, size: 24, weight: .bold, color: .black)
        currentAmountLabel.attributedText = .text(goal.currentAmount.currencyFormat, size: 24, weight: .bold, color: .black)
        targetAmountLabel.attributedText = .text("of \(goal.targetAmount.currencyFormat)", size: 20, weight: .bold, color: .n100)
        estimatedLabel.attributedText = .text(goal.estimatedCompletionDate, size: 22, weight: .bold, color: .black)
        progressView.image = goal.progressImage
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        iconView.snp.makeConstraints { (make) in
            make.height.width.equalTo(58)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
        }
        
        addSubview(titleStack)
        titleStack.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addSubview(line)
        line.snp.makeConstraints { [titleStack] (make) in
            make.top.equalTo(titleStack.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
        
        addSubview(lowerStack)
        lowerStack.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}
