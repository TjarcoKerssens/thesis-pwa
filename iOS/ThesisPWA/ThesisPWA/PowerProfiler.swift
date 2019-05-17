//
//  PowerProfiler.swift
//  Thesis iOS
//
//  Created by Tjarco Kerssens on 14/05/2019.
//  Copyright © 2019 Tjarco Kerssens. All rights reserved.
//

import UIKit

protocol PowerProfilerDelegate {
    func batteryLevelUpdated(newLevel: Float)
}

class PowerProfiler{
    var initialBatteryLevel: Float = 0
    var batteryLevel: Float{
        return UIDevice.current.batteryLevel
    }
    
    var delegate: PowerProfilerDelegate
    
    init(delegate: PowerProfilerDelegate) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.delegate = delegate
        
        initialBatteryLevel = batteryLevel
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
    }

    @objc func batteryLevelDidChange(_ notification: Notification) {
        delegate.batteryLevelUpdated(newLevel: batteryLevel)
    }
}
