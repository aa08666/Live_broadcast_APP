//
//  NVActivityIndicatorView.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/1/29.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

public func startAnimating(
    // 設定 Loading CG 的 Size
    _ size: CGSize? = nil,
    // 設定 Loading 顯示的訊息內容
    message: String? = nil,
    // 設定訊息內容的字型
    messageFont: UIFont? = nil,
    // 設定 CG 的樣式
    type: NVActivityIndicatorType? = .pacman,
    // 設定 CG 的顏色
    color: UIColor? = nil,
    // 設定 Padding
    padding: CGFloat? = nil,
    // 設定延遲時間
    displayTimeThreshold: Int? = nil,
    // 最小的延遲時間
    minimumDisplayTime: Int? = nil,
    // 背景顏色
    backgroundColor: UIColor? = nil,
    // 訊息內容顏色
    textColor: UIColor? = .red) {
    
    let activityData = ActivityData(size: size,
                                    message: message,
                                    messageFont: messageFont,
                                    type: type,
                                    color: color,
                                    padding: padding,
                                    displayTimeThreshold: displayTimeThreshold,
                                    minimumDisplayTime: minimumDisplayTime,
                                    backgroundColor: backgroundColor,
                                    textColor: textColor)
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    
}
