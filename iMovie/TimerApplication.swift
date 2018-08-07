//
//  TimerApplication.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/11/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class TimerApplication: UIApplication {

    private var timeoutInSeconds = 20

    private var idleTimer: Timer?
    
    private func resetIdleTimer() {
        let vc = findCurrentViewController()
        
        if let vcLayers = vc.view.layer.sublayers {
            for layer in vcLayers {
                if layer is CAEmitterLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        removeBlur(for: vc)
        
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeoutInSeconds),
                                         target: self,
                                         selector: #selector(timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
    }
    
    func removeBlur(for vc: UIViewController) {
        if let blurView = vc.view.viewWithTag(1111) {
            blurView.removeFromSuperview()
        }
    }
    
    @objc private func timeHasExceeded() {
        NotificationCenter.default.post(name: .appTimeout,
                                        object: nil
        )
    }

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouchPhase.began {
                self.resetIdleTimer()
            }
        }
    }
}
