//
//  SpendingView.swift
//  Moneywell
//
//  Created by Abram Situmorang on 12/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

internal class SpendingView: UIView {
    private let totalSpendingLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Total Spending", size: 16, weight: .book, color: .n100)
        
        return label
    }()
    
    private let amountLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(named: "arrow"))
    private let deltaLabel = UILabel()
    
    private lazy var deltaStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.arrowImageView, self.deltaLabel])
        stack.axis = .horizontal
        stack.alignment = .bottom
        stack.spacing = 4
        
        return stack
    }()
    
    private lazy var spendingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.amountLabel, self.deltaStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        
        return stack
    }()
    
    private let familyChartImage = UIImageView(image: UIImage(named: "family-chart"))

    internal init(spending: Spending) {
        super.init(frame: .zero)
        
        amountLabel.attributedText = .text(spending.amount.currencyFormat, size: 32, weight: .bold, color: .black)
        deltaLabel.attributedText = .text("\(spending.delta)%", size: 16, weight: .medium, color: .black)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubview(totalSpendingLabel)
        totalSpendingLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.lessThanOrEqualToSuperview().offset(-16)
        }
        
        addSubview(spendingStack)
        spendingStack.snp.makeConstraints { [totalSpendingLabel] (make) in
            make.top.equalTo(totalSpendingLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.lessThanOrEqualToSuperview().offset(-16)
        }
        
        addSubview(familyChartImage)
        familyChartImage.snp.makeConstraints { [spendingStack] (make) in
            make.top.equalTo(spendingStack.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
