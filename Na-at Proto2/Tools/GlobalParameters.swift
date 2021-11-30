//
//  GlobalParameters.swift
//  Na-at Proto2
//
//  Created by mpacheco on 18/11/21.
//

import Foundation

class GlobalParameters: NSObject {
    var isFirstTime = true
    var totalHoursProjects = 0
    
    static let shared = GlobalParameters()
    var listProjects: ActivityHourShow?
    //GlobalPArameters.shared.variable
}

