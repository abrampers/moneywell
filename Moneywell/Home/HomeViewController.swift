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
import Shared

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
        view.isUserInteractionEnabled = true
        // Setup Shadow here
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5
        
        return view
    }()
    
    private let balanceView = BalanceView(balance: Balance(amount: 26539, delta: 23))
    
    private let billButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "bill"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let paymentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "payment"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let transferButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "transfer"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let cardsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "cards"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.billButton, self.paymentButton, self.transferButton, self.cardsButton])
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
        
        tableView.frame = CGRect(x: 18, y: buttonStack.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 18, y: buttonStack.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
        
        let contentHeight = buttonStack.frame.maxY + 8 + tableView.contentSize.height + 8
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
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(balanceView)
        balanceView.snp.makeConstraints { [cardImage] (make) in
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.top.equalTo(cardImage.snp.bottom).offset(16)
        }
        
        billButton.snp.makeConstraints { [billButton] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(billButton.snp.height)
        }
        
        paymentButton.snp.makeConstraints { [paymentButton] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(paymentButton.snp.height)
        }
        
        transferButton.snp.makeConstraints { [transferButton] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(transferButton.snp.height)
        }
        
        cardsButton.snp.makeConstraints { [cardsButton] (make) in
            make.height.lessThanOrEqualTo(90)
            make.width.equalTo(cardsButton.snp.height)
        }
        
        scrollView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { (make) in
            make.top.equalTo(balanceView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(tableView)
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
            billButton.rx.tap.asDriver(),
            paymentButton.rx.tap.asDriver(),
            transferButton.rx.tap.asDriver(),
            cardsButton.rx.tap.asDriver(),
            barButton.rx.tap.asDriver()
        )
        
        tap.drive(onNext: { [navigator] _ in
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
        
        cell.configureCell(transaction: Transaction.shared[indexPath.section + indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Transaction.shared.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
