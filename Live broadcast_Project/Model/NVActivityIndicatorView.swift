//
//  NVActivityIndicatorView.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/1/29.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation
import NVActivityIndicatorView



class MyNVActivityIndicator: UIViewController, NVActivityIndicatorViewable {
    func startAnimating(){
        startAnimating(CGSize(width: 50, height: 50), message: "Loading", messageFont: UIFont(name: "Damascus", size: 20), type: NVActivityIndicatorType.pacman, color: .orange, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
    }
    func stopAnimation(){
        stopAnimating()
    }
}

