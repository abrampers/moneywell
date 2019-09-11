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
    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
//
//        return view
//    }()
    
//    override public var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set (newFrame) {
//            let inset: CGFloat = 16
//            var frame = newFrame
//            frame.origin.x += inset
//            frame.size.width -= 2 * inset
//            super.frame = frame
//            layoutIfNeeded()
//        }
//    }
    
    private let iconImage = UIImageView()
    private let titleLabel = UILabel()
    private let transactionLabel = UILabel()
    private let amountLabel = UILabel()
    
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
        
//        contentView.addSubview(containerView)
//        containerView.snp.makeConstraints { (make) in
//            make.height.equalTo(82)
//        }
        
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(12)
            make.bottom.equalTo(contentView.snp.centerY).offset(1)
//            make.right.greaterThanOrEqualTo(amountLabel.snp.left).offset(-4)
        }
        
        contentView.addSubview(transactionLabel)
        transactionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(contentView.snp.centerY).offset(1)
//            make.right.greaterThanOrEqualTo(amountLabel.snp.left).offset(-4)
        }
        
        let tap = UITapGestureRecognizer()
        contentView.addGestureRecognizer(tap)
        let rx_disposeBag = DisposeBag()
        
        tap.rx.event.asDriver().mapToVoid().drive(onNext: { [contentView] (_) in
            print("contentview.frame", contentView.frame)
        }).disposed(by: rx_disposeBag)
    }
}
