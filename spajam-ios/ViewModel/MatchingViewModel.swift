//
//  MatchingViewModel.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/23.
//

import CoreBluetooth
import SwiftUI
final class MatchingViewModel: NSObject, ObservableObject{
    private let myID: String = UIDevice.current.identifierForVendor!.uuidString
    
    private var discoveredUUIDs = Array<UUID>()
    private var serivceUUID = CBUUID(string: "0011")
    private var characteristicUUID = CBUUID(string: "0022")
    private var service: CBMutableService!
    
    private var centralManager: CBCentralManager!
    private var targetPeripheral: CBPeripheral!
    
    private var peripheralManager: CBPeripheralManager!
    private var peripheralCharacteristtic: CBCharacteristic!
    
    @Published var isPeripheral = false
    @Published var isConnected = false
    @Published private(set) var emenyUUID: String?
    @Published private(set) var ballSpeed: Int?
    @Published private(set) var reservedData = ""
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func sendUUID(_ uuid: String) {
        self.sendString("uuid:" + uuid)
    }
    
    private func setUUID(_ uuid: String) {
        self.emenyUUID = uuid
    }
    
    func sendBallSpeeed(_ speed: Int) {
        self.sendString("speed:" + String(speed))
    }
    
    private func setBallSpeed(_ speed: Int) {
        self.ballSpeed = speed
    }
    
    private func sendString(_ message: String) {
        if !self.isConnected { return }
        if self.isPeripheral {
            self.sendStringToCentral(message)
        } else {
            self.sendStringToPeripheral(message)
        }
    }
    
    private func sendStringToPeripheral(_ message: String) {
        let data = message.data(using: .utf8)
        self.targetPeripheral.writeValue(data!, for: self.peripheralCharacteristtic!, type: .withResponse)
    }
    
    private func sendStringToCentral(_ message: String) {
        let data = message.data(using: .utf8)
        self.peripheralManager.updateValue(data!, for: self.peripheralCharacteristtic as! CBMutableCharacteristic, onSubscribedCentrals: nil)
    }
}

extension MatchingViewModel: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOff:
            print("[BLE peripheral] powerdOFF")
        case .poweredOn:
            print("[BLE peripheral] powerdON")
            self.publishService()
        case .resetting:
            print("[BLE peripheral] resseting")
        case .unauthorized:
            print("[BLE peripheral] unauthorized")
        case .unknown:
            print("[BLE peripheral] unknown")
        case .unsupported:
            print("[BLE peripheral] unsupported")
        default:
            print("")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if error != nil {
            print("[BLE peripheral] Service Add Faild")
        } else {
            print("[BLE peripheral] Service Add Success")
            self.startAdvertise()
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error != nil {
            print("[BLE peripheral] Service Advertise Falied")
        } else {
            print("[BLE peripheral] Service Advertise Success")
            self.startDiscover()
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("[BLE peripheral] Service subscribe Success")
        self.setIamPeripheral()
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        guard let request = requests.first, let data = request.value else { return }
        var message = String(decoding: data, as: UTF8.self)
        self.peripheralManager.respond(to: request, withResult: .success)
        
        if let range = message.range(of: "uuid:") {
            message.removeSubrange(range)
            self.emenyUUID = message
            self.sendUUID(self.myID)
        } else if let range = message.range(of: "spped:") {
            message.removeSubrange(range)
            self.ballSpeed = Int(message)
            self.sendBallSpeeed(self.ballSpeed!)
        }
        print("[BLE peripheral] Reseive \(message)")
    }
    
    private func publishService() {
        self.service = CBMutableService(type: self.serivceUUID, primary: true)
        self.peripheralCharacteristtic = CBMutableCharacteristic(type: self.characteristicUUID, properties: [.write, .notify, .writeWithoutResponse], value: nil, permissions: [.writeable])
        self.service.characteristics = [self.peripheralCharacteristtic]
        self.peripheralManager.add(self.service)
    }
    
    private func startAdvertise() {
        self.peripheralManager.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [self.serivceUUID],
            CBAdvertisementDataLocalNameKey: "testtest"
        ])
    }
    
    private func stopAdvertise() {
        self.peripheralManager.stopAdvertising()
    }
    
    private func setIamPeripheral() {
        self.isPeripheral = true
        self.isConnected = true
        self.stopDiscoover()
    }
}

extension MatchingViewModel: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let e = error {
            print("[BLE target peripheral] Error \(e.localizedDescription)")
        } else {
            print("[BLE target peripheral] Discover Service Success")
            self.startDiscoverCharacteristics()
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let e = error {
            print("[BLE target peripheral] Error \(e.localizedDescription)")
        } else {
            print("[BLE target peripheral] Discover Characteristics Success")
            service.characteristics?.forEach{ characteristic in
                guard characteristic.uuid == self.characteristicUUID else { return }
                
                peripheral.setNotifyValue(true, for: characteristic)
                
                self.peripheralCharacteristtic = characteristic
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("[BLE target peripheral] Service Update characteristic Falied")
        } else {
            print("[BLE target peripheral] Service Update characteristic Success")
            
            guard characteristic.uuid == self.characteristicUUID else { return }
            
            if (characteristic.isNotifying) {
                print("[BLE target peripheral] Service Is Notifying")
                self.sendUUID(self.myID)
            } else {
                print("[BLE target peripheral] Service Is Not Notifying")
                self.centralManager.cancelPeripheralConnection(peripheral)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let e = error {
            print("[BLE target peripheral] Error \(e.localizedDescription)")
        } else {
            let data = characteristic.value!
            var message = String(decoding: data, as: UTF8.self)
            if let range = message.range(of: "uuid:") {
                message.removeSubrange(range)
                self.emenyUUID = message
            } else if let range = message.range(of: "spped:") {
                message.removeSubrange(range)
                self.ballSpeed = Int(message)
            }
            print("[BLE target peripheral] Received \(message)")
        }
    }
    
    private func setPeripheral(target: CBPeripheral) {
        self.targetPeripheral = target
        self.targetPeripheral.delegate = self
    }
    
    private func startDiscoverServices() {
        self.targetPeripheral.discoverServices([self.serivceUUID])
    }
    
    private func startDiscoverCharacteristics() {
        self.targetPeripheral.services?.forEach({ service in
            self.targetPeripheral.discoverCharacteristics([self.characteristicUUID], for: service)
        })
        
    }

}

extension MatchingViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("[BLE central] powerdOFF")
        case .poweredOn:
            print("[BLE central] powerdON")
        case .resetting:
            print("[BLE central] resseting")
        case .unauthorized:
            print("[BLE central] unauthorized")
        case .unknown:
            print("[BLE central] unknown")
        case .unsupported:
            print("[BLE central] unsupported")
        default:
            print("")
        }
    }
    
    //Success Scan
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("[BLE central] success didcover")
        print("[BLE central] name: \(String(describing: peripheral.name))")
        
        let uuid = UUID(uuid: peripheral.identifier.uuid)
        self.discoveredUUIDs.append(uuid)
        
        let kCBAdvDataLoocalName = advertisementData["kCBAdvDataLocalName"] as? String
        if (kCBAdvDataLoocalName == "testtest") {
            self.stopDiscoover()
            self.setPeripheral(target: peripheral)
            self.setIamCentral()
            self.startConnect()
        }
        
    }
        
    //Success Connect
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("[BLE central] success connect")
        self.startDiscoverServices()
    }
        
    //Faild Connect
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("[BLE central] faild connect")
    }
    
    public func startDiscover() {
        let option = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        self.centralManager.scanForPeripherals(withServices: [self.serivceUUID], options: option)
    }
    
    private func stopDiscoover() {
        self.centralManager.stopScan()
    }
    
    private func startConnect() {
        self.centralManager.connect(self.targetPeripheral, options: nil)
    }
    
    private func setIamCentral() {
        self.isPeripheral = false
        self.isConnected = true
        self.stopAdvertise()
    }
}
