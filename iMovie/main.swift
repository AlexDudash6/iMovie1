//
//  main.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/11/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(TimerApplication.self),
    NSStringFromClass(AppDelegate.self)
)
