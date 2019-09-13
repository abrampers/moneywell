//
//  GoalsViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class GoalsViewController: UIViewController {
    private let rx_disposeBag = DisposeBag()
    
	private lazy var navigator: GoalsNavigator = {
        let nav = DefaultGoalsNavigator(navigationController: self.navigationController)
        return nav
    }()
    
    private let barButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus-button"), for: .normal)
        
        return button
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
        
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    internal init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        title = "Goals"
        navigationItem.setRightBarButton(UIBarButtonItem(customView: barButton), animated: false)
        
        view.backgroundColor = .n500
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func bindUI() {
        barButton.rx.tap
            .asDriver()
            .drive(onNext: { [navigator] (_) in
                navigator.toHahaPage()
            })
            .disposed(by: rx_disposeBag)
    }
}

extension GoalsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigator.toHahaPage()
    }
}

extension GoalsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.identifier) as! GoalTableViewCell
        
        cell.configureCell(goal: Goal.shared[indexPath.section + indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Goal.shared.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
