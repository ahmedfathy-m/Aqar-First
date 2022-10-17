

import Foundation

// MARK: - Aqar
struct Aqar: Codable {
    let data: [AqarData]
}

// MARK: - Datum
struct AqarData: Codable {
    let id: Int
    let name, lag, lat, aqarType: String
    let elevator, elevatorCount, campany: String
    let campanyPhone: Int
    let worker: String
    let phone, floorID: Int
    let createdAt: String
    let image: String
    let datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name, lag, lat
        case aqarType = "aqar_type"
        case elevator
        case elevatorCount = "elevator_count"
        case campany
        case campanyPhone = "campany_phone"
        case worker, phone
        case floorID = "floor_id"
        case createdAt = "created_at"
        case image
        case datumDescription = "description"
    }
}
