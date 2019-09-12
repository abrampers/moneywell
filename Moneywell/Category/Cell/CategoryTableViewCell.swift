//
//  CategoryTableViewCell.swift
//  Moneywell
//
//  Created by Abram Situmorang on 10/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

public class CategoryTableViewCell: UITableViewCell {
    public static var identifier = "CategoryTableViewCell"
    
    private let iconImage = UIImageView()
    private let titleLabel = UILabel()
    private let transactionLabel = UILabel()
    private let amountLabel = UILabel()
    
    private lazy var middleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.titleLabel, self.transactionLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 1
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.iconImage, self.middleStack, self.amountLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        
        return stack
    }()
    
    public func configureCell(category: Category) {
        iconImage.image = category.image
        titleLabel.attributedText = .text(category.title, size: 18, weight: .bold, color: .black)
        titleLabel.lineBreakMode = .byTruncatingTail
        transactionLabel.attributedText = .text("\(category.numTransaction) Transactions", size: 14, weight: .book, color: .n100)
        transactionLabel.lineBreakMode = .byTruncatingTail
        amountLabel.attributedText = .text(category.amount.currencyFormat, size: 20, weight: .bold, color: .black)
        
        backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(82)
        }
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        middleStack.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(120)
        }
    }
}
