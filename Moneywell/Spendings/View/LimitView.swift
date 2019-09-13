//
//  LimitView.swift
//  Moneywell
//
//  Created by Abram Situmorang on 12/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import RxSwift

internal class LimitView: UIView {
    private let progressView = UIImageView(image: UIImage(named: "progress-78"))
    
    private let monthlyLimitLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("of Monthly Limit", size: 18, weight: .bold, color: .black)
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Ends in 8 days", size: 14, weight: .book, color: .n100)
        
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = .b300
        
        return button
    }()
    
    private lazy var middleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.monthlyLimitLabel, self.deadlineLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    public var rx: Reactive<UIButton> {
        return editButton.rx
    }
    
    internal init() {
        super.init(frame: .zero)
        
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
        snp.makeConstraints { (make) in
            make.height.equalTo(84)
        }
        
        addSubview(progressView)
        progressView.snp.makeConstraints { [progressView] (make) in
            make.width.equalTo(66)
            make.height.equalTo(progressView.snp.width)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(middleStack)
        middleStack.snp.makeConstraints { [progressView] (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(progressView.snp.right).offset(8)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.height.equalTo(29)
            make.width.equalTo(54)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
