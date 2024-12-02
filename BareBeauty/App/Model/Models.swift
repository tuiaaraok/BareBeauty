import Foundation

struct Entrie: Identifiable, Codable {
    let id: UUID
    
    var client: Client
    var typeOfRemoval: String
    var date: Date
    var time: Date
    var cost: Int
    
    init(id: UUID = UUID(), client: Client, typeOfRemoval: String, date: Date, time: Date, cost: Int) {
        self.id = id
        self.client = client
        self.typeOfRemoval = typeOfRemoval
        self.date = date
        self.time = time
        self.cost = cost
    }
}

struct Client: Identifiable, Codable {
    let id: UUID
    var name: String
    var phoneNumber: String
    var email: String

    init(id: UUID = UUID(), name: String, phoneNumber: String, email: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
}

struct Material: Identifiable, Codable {
    let id: UUID
    var name: String
    var count: Int

    init(id: UUID = UUID(), name: String, count: Int) {
        self.id = id
        self.name = name
        self.count = count
    }
}

struct ImageSection: Identifiable, Codable {
    let id: UUID
    var beforeImage: UIImageData? = nil
    var afterImage: UIImageData? = nil
    
    init(id: UUID = UUID(), beforeImage:  UIImageData? = nil, afterImage: UIImageData? = nil) {
        self.id = id
        self.beforeImage = beforeImage
        self.afterImage = afterImage
    }
}


