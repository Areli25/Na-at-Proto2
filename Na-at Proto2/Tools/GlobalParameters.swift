//
//  GlobalParameters.swift
//  Na-at Proto2
//
//  Created by mpacheco on 18/11/21.
//

import Foundation
import Network
import SystemConfiguration

class GlobalParameters: NSObject {
    var isFirstTime = true
    var totalHoursProjects = 0
    var nameUser = ""
    var urlProfile:URL!
     
    let keyUserName = "USERNEME_KEY"
    let keyUserProfile = "USERPROFILE_KEY"
    
    var daysSinceLastRecord = 0
    
    static let shared = GlobalParameters()
    var listProjects: ActivityHourShow?
}

/*final class NetworkMoni{
    static let shared = NetworkMoni()
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
*/
public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
