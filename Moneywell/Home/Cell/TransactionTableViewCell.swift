//
//  TransactionTableViewCell.swift
//  Moneywell
//
//  Created by Abram Situmorang on 11/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Shared

public class TransactionTableViewCell: UITableViewCell {
    public static var identifier = "TransactionTableViewCell"
    
    private let iconImage = UIImageView()
    private let merchantLabel = UILabel()
    private let locationLabel = UILabel()
    private let timeLabel = UILabel()
    private let amountLabel = UILabel()
    
    private lazy var middleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.merchantLabel, self.locationLabel, self.timeLabel])
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
    
    public func configureCell(transaction: Transaction) {
        iconImage.image = transaction.image
        merchantLabel.attributedText = .text(transaction.merchant, size: 18, weight: .bold, color: .black)
        merchantLabel.lineBreakMode = .byTruncatingTail
        locationLabel.attributedText = .text(transaction.location, size: 14, weight: .book, color: .n100)
        locationLabel.lineBreakMode = .byTruncatingTail
        timeLabel.attributedText = .text("\(transaction.time) days ago", size: 14, weight: .book, color: .n100)
        timeLabel.lineBreakMode = .byTruncatingTail
        amountLabel.attributedText = .text(transaction.amount.currencyFormat, size: 20, weight: .bold, color: .black)
        
        backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(82)
        }
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-24)
        }
        
        middleStack.snp.makeConstraints { (make) in
            make.width.equalTo(120)
        }
    }
}

