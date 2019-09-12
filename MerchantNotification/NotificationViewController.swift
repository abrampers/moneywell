//
//  NotificationViewController.swift
//  MerchantNotification
//
//  Created by Abram Situmorang on 12/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Shared
import SnapKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    private let mapImage = UIImageView(image: UIImage(named: "map", in: Bundle.main, compatibleWith: nil))
    
    private let upperLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString.text("We notice that you visited", size: 20, weight: .medium, color: .black)
        
        return label
    }()
    
    private let merchantLabel = UILabel()
    private let addressLabel = UILabel()
    
    private let lowerLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString.text("Did you spent some money there?", size: 20, weight: .medium, color: .black)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(mapImage)
        mapImage.snp.makeConstraints { [mapImage] (make) in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(mapImage.snp.width).multipliedBy(218/359.5)
        }
        
        view.addSubview(upperLabel)
        upperLabel.snp.makeConstraints { [mapImage] (make) in
            make.top.equalTo(mapImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(merchantLabel)
        merchantLabel.snp.makeConstraints { [upperLabel] (make) in
            make.top.equalTo(upperLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { [merchantLabel] (make) in
            make.top.equalTo(merchantLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(lowerLabel)
        lowerLabel.snp.makeConstraints { [addressLabel] (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func didReceive(_ notification: UNNotification) {
        print("incoming notif", notification)
//        self.label?.text = notification.request.content.body
        merchantLabel.attributedText = .text(notification.request.content.title, size: 20, weight: .bold, color: .black)
        addressLabel.attributedText = .text(notification.request.content.subtitle, size: 14, weight: .book, color: .black)
    }

}
