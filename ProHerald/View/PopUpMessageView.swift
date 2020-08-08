//
//  PopUpMessageView.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

class PopUpMessageView: NSObject {
    static let shared = PopUpMessageView()

    private override init() { }
    
    func showAlert(title: String = "", message: String, duration: TimeInterval = 2) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
}
