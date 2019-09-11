//
//  HomeViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 11/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

internal class HomeViewController: UIViewController {
    private let rx_disposeBag = DisposeBag()

	private lazy var navigator: HomeNavigator = {
        let nav = DefaultHomeNavigator(navigationController: self.navigationController)
        return nav
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    private let barButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        
        return button
    }()
    
    private let cardImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "card"))
        // Setup Shadow here
        
        return view
    }()
    
    private let balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        return view
    }()
    
    private let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let button4: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.button1, self.button2, self.button3, self.button4])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 9
        
        return stack
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        
        let headerView = UILabel()
        headerView.attributedText = NSAttributedString.text("Recent Transactions", size: 24, weight: .bold, color: .black)
        
        view.backgroundColor = .clear
        view.tableHeaderView = headerView
        view.separatorStyle = .none
        view.allowsSelection = false
        view.isScrollEnabled = false
        
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame = tableView.tableHeaderView?.frame
        frame?.size.height = 37
        
        tableView.tableHeaderView?.frame = frame!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100)
        tableView.frame = CGRect(x: 18, y: buttonStack.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 18, y: buttonStack.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
        
        let contentHeight = buttonStack.frame.maxY + 16 + tableView.contentSize.height
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
    }
    
    private func setupUI() {
        title = "Nicholas Y. L."
        navigationItem.setRightBarButton(UIBarButtonItem(customView: barButton), animated: false)
        view.backgroundColor = .n500
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(cardImage)
        cardImage.snp.makeConstraints { [cardImage] (make) in
            make.width.lessThanOrEqualTo(360)
            make.height.equalTo(cardImage.snp.width).multipliedBy(214.52/340)
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(balanceView)
        balanceView.snp.makeConstraints { [cardImage] (make) in
            make.height.equalTo(84)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.top.equalTo(cardImage.snp.bottom).offset(16)
        }
        
        button1.snp.makeConstraints { [button1] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(button1.snp.height)
        }
        
        button2.snp.makeConstraints { [button2] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(button2.snp.height)
        }
        
        button3.snp.makeConstraints { [button3] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(button3.snp.height)
        }
        
        button4.snp.makeConstraints { [button4] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(button4.snp.height)
        }
        
        scrollView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { (make) in
            make.top.equalTo(balanceView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(tableView)
//        tableView.frame = CGRect(x: 18, y: buttonStack.frame.maxY, width: view.bounds.width - 36, height: tableView.contentSize.height)
    }
    
    private func bindUI() {
        let cardTap = UITapGestureRecognizer()
        cardImage.addGestureRecognizer(cardTap)
        
        let balanceTap = UITapGestureRecognizer()
        balanceView.addGestureRecognizer(balanceTap)
        
        // Triggers
        let cardTapTrigger = cardTap.rx.event.asDriver().mapToVoid()
        let balanceTapTrigger = balanceTap.rx.event.asDriver().mapToVoid()
        
        let tap = Driver.merge(
            cardTapTrigger,
            balanceTapTrigger,
            button1.rx.tap.asDriver(),
            button2.rx.tap.asDriver(),
            button3.rx.tap.asDriver(),
            button4.rx.tap.asDriver(),
            barButton.rx.tap.asDriver()
        )
        
        tap.drive(onNext: { [weak self, navigator] _ in
            print("tableview frame", self?.tableView.frame)
            navigator.toHahaPage()
        })
        .disposed(by: rx_disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier) as! TransactionTableViewCell
        
        cell.configureCell(transaction: Transaction.shared[0])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
