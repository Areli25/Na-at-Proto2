//
//  GlobalParameters.swift
//  Na-at Proto2
//
//  Created by mpacheco on 18/11/21.
//

import Foundation
import Network

class GlobalParameters: NSObject {
    var isFirstTime = true
    var totalHoursProjects = 0
    var nameUser = ""
    var urlProfile:URL!
     
    let keyUserName = "USERNEME_KEY"
    let keyUserProfile = "USERPROFILE_KEY"
    
   
    static let shared = GlobalParameters()
    var listProjects: ActivityHourShow?
}

final class NetworkMonitor{
   
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor:NWPathMonitor
    public private(set) var isConnected:Bool = false
    public private(set) var connectionType:ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            
            self?.isConnected = path.status == .satisfied
            self?.getConnectiontype(path)
        }
    }
    public func stopMonitor(){
        monitor.cancel()
    }
    
    private func getConnectiontype(_ path:NWPath){
        
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else  if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else  if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
    }
}




