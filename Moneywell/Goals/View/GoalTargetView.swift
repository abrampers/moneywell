//
//  GoalTargetView.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

internal class GoalTargetView: UIView {
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Target Completion", size: 18, weight: .medium, color: .n100)
        
        return label
    }()
    
    private let targetCompletionLabel = UILabel()
    
    private let progressTrackerLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Progress Tracker", size: 18, weight: .medium, color: .n100)
        
        return label
    }()
    
    private let progressView = UIImageView(image: UIImage(named: "goal-chart"))
    
    private let predictionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("At the current pace, you will achieve this goal at:", size: 18, weight: .medium, color: .n100)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let etaLabel = UILabel()
    
    private let lateLabel = UILabel()
    
    private lazy var targetStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.targetLabel, self.targetCompletionLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var progressStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.progressTrackerLabel, self.progressView])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var etaStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.etaLabel, self.lateLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.targetStack, self.progressStack, self.predictionLabel, self.etaStack])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16
        
        return stack
    }()
    
    internal init(plannedCompletionDate: String, estimatedCompletionDate: String, completionDelta: String) {
        super.init(frame: .zero)
        
        setupUI(plannedCompletionDate: plannedCompletionDate, estimatedCompletionDate: estimatedCompletionDate, completionDelta: completionDelta)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(plannedCompletionDate: String, estimatedCompletionDate: String, completionDelta: String) {
        targetCompletionLabel.attributedText = .text(plannedCompletionDate, size: 26, weight: .bold, color: .black)
        etaLabel.attributedText = .text(estimatedCompletionDate, size: 26, weight: .bold, color: .black)
        lateLabel.attributedText = .text(completionDelta, size: 18, weight: .bold, color: .r100)
        
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
        
        progressView.snp.makeConstraints { [progressView] (make) in
            make.height.lessThanOrEqualTo(200)
            make.width.equalTo(progressView.snp.height).multipliedBy(307.5/186.45)
        }
    }
}
