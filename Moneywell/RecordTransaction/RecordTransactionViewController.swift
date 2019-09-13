//
//  RecordTransactionViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Shared

internal class RecordTransactionViewController: UIViewController {
    private let rx_disposeBag = DisposeBag()
    private let icon = UIImageView(image: UIImage(named: "food"))
    private let starbucksLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Starbucks", size: 28, weight: .bold, color: .black)
        
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("Jl. Prof. Dr. Satrio, Jakarta Selatan", size: 18, weight: .book, color: .black)
        
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .text("How much did you spent?", size: 24, weight: .bold, color: .black)
        
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = .text("$0", size: 38, weight: .book, color: .n100)
        field.textAlignment = .center
        field.keyboardType = .numberPad
        
        field.backgroundColor = .n400
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        field.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        
        return field
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)

    internal init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindUI()
        
        textField.becomeFirstResponder()
    }
    
    private func setupUI() {
        view.backgroundColor = .n500
        
        navigationItem.leftBarButtonItem = cancelButton
        textField.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(84)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
        }
        
        view.addSubview(starbucksLabel)
        starbucksLabel.snp.makeConstraints { [icon] (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(20)
        }
        
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { [starbucksLabel] (make) in
            make.top.equalTo(starbucksLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { [addressLabel] (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(addressLabel.snp.bottom).offset(24)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { [questionLabel] (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(82)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { [textField] (make) in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
    
    private func bindUI() {
        let cancelTrigger = Driver.merge(
            doneButton.rx.tap.asDriver(),
            cancelButton.rx.tap.asDriver()
        )
        
        cancelTrigger
            .drive(onNext: { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx_disposeBag)
    }

}

extension RecordTransactionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = "$"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "$" {
            textField.text = ""
        }
    }
}
