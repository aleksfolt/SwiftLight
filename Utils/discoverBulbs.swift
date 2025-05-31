//
//  discoverBulbs.swift
//  SwiftLight
//
//  Created by Folt on 31/5/25.
//
import Foundation
import Network

struct SSDPResponse {
    let ip: String
    let port: Int
    let capabilities: [String: String]
}

func sendDiscoveryPacket(timeout: TimeInterval = 2,
                         interface: String? = nil,
                         ipAddress: String = "239.255.255.250",
                         port: UInt16 = 1982) -> Int32? {
    let sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
    guard sock >= 0 else { return nil }

    var addrAny = sockaddr_in(
        sin_len: UInt8(MemoryLayout<sockaddr_in>.size),
        sin_family: sa_family_t(AF_INET),
        sin_port: 0,
        sin_addr: in_addr(s_addr: inet_addr("0.0.0.0")),
        sin_zero: (0,0,0,0,0,0,0,0)
    )
    let bindResult = withUnsafePointer(to: &addrAny) { ptr in
        ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockAddrPtr in
            bind(sock, sockAddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
        }
    }
    guard bindResult >= 0 else {
        close(sock)
        return nil
    }

    var ttl: UInt8 = 32
    setsockopt(sock, IPPROTO_IP, IP_MULTICAST_TTL, &ttl, socklen_t(MemoryLayout.size(ofValue: ttl)))

    if let iface = interface {
        let ipStr = getIPAddressString(interface: iface)
        var addr = in_addr()
        if inet_pton(AF_INET, ipStr, &addr) == 1 {
            var inAddr = addr
            setsockopt(sock, IPPROTO_IP, IP_MULTICAST_IF, &inAddr, socklen_t(MemoryLayout.size(ofValue: inAddr)))
        }
    }

    var tv = timeval(tv_sec: Int(timeout), tv_usec: 0)
    setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tv, socklen_t(MemoryLayout.size(ofValue: tv)))

    let requestLines = [
        "M-SEARCH * HTTP/1.1",
        "HOST: \(ipAddress):\(port)",
        #"MAN: "ssdp:discover""#,
        "ST: wifi_bulb"
    ]
    let msg = requestLines.joined(separator: "\r\n")
    guard let data = msg.data(using: .utf8) else {
        close(sock)
        return nil
    }

    var dest = sockaddr_in(
        sin_len: UInt8(MemoryLayout<sockaddr_in>.size),
        sin_family: sa_family_t(AF_INET),
        sin_port: CFSwapInt16HostToBig(port),
        sin_addr: in_addr(s_addr: inet_addr(ipAddress)),
        sin_zero: (0,0,0,0,0,0,0,0)
    )
    let sockAddrSize = socklen_t(MemoryLayout<sockaddr_in>.size)

    Thread.sleep(forTimeInterval: 0.05)

    _ = data.withUnsafeBytes { ptr in
        let raw = ptr.baseAddress!.assumingMemoryBound(to: UInt8.self)
        return withUnsafePointer(to: &dest) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                sendto(sock, raw, data.count, 0, $0, sockAddrSize)
            }
        }
    }

    return sock
}

func getIPAddressString(interface: String) -> String {
    var address = "0.0.0.0"
    var ifaddrPointer: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddrPointer) == 0, let firstAddr = ifaddrPointer else {
        return address
    }
    defer { freeifaddrs(ifaddrPointer) }

    for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let flags = Int32(ptr.pointee.ifa_flags)
        var addr = ptr.pointee.ifa_addr.pointee
        if addr.sa_family == sa_family_t(AF_INET),
           flags & IFF_LOOPBACK == 0,
           String(cString: ptr.pointee.ifa_name) == interface {
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            if getnameinfo(&addr,
                           socklen_t(addr.sa_len),
                           &hostname,
                           socklen_t(hostname.count),
                           nil,
                           0,
                           NI_NUMERICHOST) == 0 {
                address = String(cString: hostname)
                break
            }
        }
    }
    return address
}

func parseCapabilities(_ data: Data) -> [String: String] {
    guard let text = String(data: data, encoding: .utf8) else {
        return [:]
    }
    var result = [String: String]()
    let lines = text.components(separatedBy: "\r\n")
    for line in lines {
        let parts = line.components(separatedBy: ": ")
        if parts.count == 2 {
            let key = parts[0].trimmingCharacters(in: .whitespaces)
            let value = parts[1].trimmingCharacters(in: .whitespaces)
            result[key] = value
        }
    }
    return result
}

func filterLowerCaseKeys(_ dict: [String: String]) -> [String: String] {
    return dict.filter { key, _ in
        let letters = CharacterSet.letters
        let filtered = key.unicodeScalars.filter { letters.contains($0) }
        return !filtered.isEmpty && filtered.allSatisfy { CharacterSet.lowercaseLetters.contains($0) }
    }
}

func discoverBulbs(timeout: TimeInterval = 2, interface: String? = nil) -> [SSDPResponse] {
    guard let sock = sendDiscoveryPacket(timeout: timeout, interface: interface) else {
        return []
    }
    defer { close(sock) }

    var bulbs = [SSDPResponse]()
    var seenIPs = Set<String>()
    let bufSize = 65507
    var buffer = [UInt8](repeating: 0, count: bufSize)
    let start = Date()

    while Date().timeIntervalSince(start) < timeout {
        var addr = sockaddr_in()
        var addrLen = socklen_t(MemoryLayout<sockaddr_in>.size)
        let received = withUnsafeMutablePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockAddrPtr in
                recvfrom(sock,
                         &buffer,
                         bufSize,
                         0,
                         sockAddrPtr,
                         &addrLen)
            }
        }
        if received < 0 {
            let err = errno
            if err == EAGAIN || err == EWOULDBLOCK {
                break
            } else {
                break
            }
        }

        let dataSlice = Data(buffer[0..<received])
        let capabilities = parseCapabilities(dataSlice)

        if let loc = capabilities["Location"],
           let urlRange = loc.range(of: "//") {
            let afterSlash = loc[urlRange.upperBound...]
            let comps = afterSlash.split(separator: ":")
            if comps.count == 2, let port = Int(comps[1]) {
                let ipStr = String(comps[0])
                if seenIPs.contains("\(ipStr):\(port)") {
                    continue
                }
                seenIPs.insert("\(ipStr):\(port)")
                let filteredCaps = filterLowerCaseKeys(capabilities)
                let response = SSDPResponse(ip: ipStr, port: port, capabilities: filteredCaps)
                bulbs.append(response)
            }
        }
    }

    return bulbs
}

func demoDiscovery() {
    let found = discoverBulbs(timeout: 2, interface: nil)
    for bulb in found {
        print("\(bulb.ip):\(bulb.port) → \(bulb.capabilities)")
    }
}
