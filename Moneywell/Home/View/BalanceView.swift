//
//  BalanceView.swift
//  Moneywell
//
//  Created by Abram Situmorang on 12/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import SnapKit

public class BalanceView: UIView {
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Total Balance", size: 18, weight: .medium, color: .n50)
        
        return label
    }()
    
    private let amountLabel = UILabel()
    private let deltaLabel = UILabel()
    private let arrowImage = UIImageView(image: UIImage(named: "arrow"))
    
    private let monthlyLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Monthly", size: 18, weight: .medium, color: .n50)
        
        return label
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.totalLabel, self.amountLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var deltaStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.arrowImage, self.deltaLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        
        return stack
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.deltaStack, self.monthlyLabel])
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 4
        
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.leftStackView, self.rightStackView])
        stack.axis = .horizontal
        
        return stack
    }()

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        snp.makeConstraints { (make) in
            make.height.equalTo(84)
        }
        
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
        }
    }
    
    public init(balance: Balance) {
        super.init(frame: .zero)
        
        amountLabel.attributedText = .text(balance.amount.currencyFormat, size: 30, weight: .bold, color: .black)
        deltaLabel.attributedText = .text("\(balance.delta)%", size: 20, weight: .bold, color: .black)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
