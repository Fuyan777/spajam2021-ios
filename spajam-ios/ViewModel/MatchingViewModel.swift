//
//  MatchingViewModel.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/23.
//

import CoreBluetooth

final class MatchingViewModel: NSObject, ObservableObject{
    private var discoveredUUIDs = Array<UUID>()
    private var serivceUUID = CBUUID(string: "0011")
    private var characteristicUUID = CBUUID(string: "0022")
    private var service: CBMutableService!
    
    private var centralManager: CBCentralManager!
    private var targetPeripheral: CBPeripheral!
    
    private var peripheralManager: CBPeripheralManager!
    private var peripheralCharacteristtic: CBMutableCharacteristic!
    @Published var sendData: Data = Data()
    @Published var readData: Data = Data()
    
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func sendString(_ message: String) {
        let data = Data(base64Encoded: message)
        self.targetPeripheral.writeValue(data!, for: self.peripheralCharacteristtic!, type: .withoutResponse)
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
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        if request.characteristic.uuid.isEqual(self.peripheralCharacteristtic.uuid) {
            self.peripheralCharacteristtic.value = self.sendData
            request.value = self.peripheralCharacteristtic.value
            
            self.peripheralManager.respond(to: request, withResult: .success)
        }
    }
    
    private func publishService() {
        self.service = CBMutableService(type: self.serivceUUID, primary: true)
        self.peripheralCharacteristtic = CBMutableCharacteristic(type: self.characteristicUUID, properties: [.write, .notify], value: nil, permissions: [.writeable])
        self.service.characteristics = [self.peripheralCharacteristtic]
        self.peripheralManager.add(self.service)
    }
    
    private func startAdvertise() {
        self.peripheralManager.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [self.service],
            CBAdvertisementDataLocalNameKey: "testtest"
        ])
    }
}

extension MatchingViewModel: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let e = error {
            print("[BLE target peripheral] Error \(e.localizedDescription)")
        } else {
            print("[BLE target peripheral] Connect Success")
            self.readData = characteristic.value!
        }
    }
    
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
        self.targetPeripheral.discoverCharacteristics([self.characteristicUUID], for: (self.targetPeripheral.services?.first)!)
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
        print("[BLE pheripheral] success didcover")
        print("[BLE pheripheral] name: \(String(describing: peripheral.name))")
        
        let uuid = UUID(uuid: peripheral.identifier.uuid)
        self.discoveredUUIDs.append(uuid)
        
        let kCBAdvDataLoocalName = advertisementData["kCBAdvDataLocalName"] as? String
        if (kCBAdvDataLoocalName == "testtest") {
            self.stopDiscoover()
            self.setPeripheral(target: peripheral)
            self.startConnect()
        }
        
    }
        
    //Success Connect
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("[BLE pheripheral] success connect")
        self.startDiscoverServices()
    }
        
    //Faild Connect
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("[BLE pheripheral] faild connect")
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
}
