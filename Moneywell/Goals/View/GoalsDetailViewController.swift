//
//  GoalsDetailViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

internal class GoalsDetailViewController: UIViewController {
    private var goal: Goal
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    private lazy var amountView = GoalAmountView(achievedAmount: self.goal.currentAmount, targetAmount: self.goal.targetAmount, progressImage: self.goal.progressImage!)
    private lazy var targetView = GoalTargetView(plannedCompletionDate: self.goal.plannedCompletionDate, estimatedCompletionDate: self.goal.estimatedCompletionDate, completionDelta: self.goal.completionDelta)
    
    internal init(index: Int) {
        self.goal = Goal.shared[index]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = goal.name
        view.backgroundColor = .n500
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(amountView)
        amountView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(targetView)
        targetView.snp.makeConstraints { [amountView] (make) in
            make.top.equalTo(amountView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}
