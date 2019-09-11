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

public class TransactionTableViewCell: UITableViewCell {
    public static var identifier = "TransactionTableViewCell"
    
    private let iconImage = UIImageView()
    private let merchantLabel = UILabel()
    private let locationLabel = UILabel()
    private let timeLabel = UILabel()
    private let amountLabel = UILabel()
    
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
        
        contentView.addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(56)
        }
        
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
        
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(12)
            make.centerY.equalToSuperview()
            //            make.right.greaterThanOrEqualTo(amountLabel.snp.left).offset(-4)
        }
        
        contentView.addSubview(merchantLabel)
        merchantLabel.snp.makeConstraints { [locationLabel] (make) in
            make.left.equalTo(locationLabel.snp.left)
            make.bottom.equalTo(locationLabel.snp.top).offset(-1)
            //            make.right.greaterThanOrEqualTo(amountLabel.snp.left).offset(-4)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { [locationLabel] (make) in
            make.left.equalTo(locationLabel.snp.left)
            make.top.equalTo(locationLabel.snp.bottom).offset(1)
            //            make.right.greaterThanOrEqualTo(amountLabel.snp.left).offset(-4)
        }
    }
}

