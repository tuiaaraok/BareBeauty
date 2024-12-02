import Foundation

class Storage: ObservableObject {

    
    static let shared = Storage()
    
    private let entriesKey = "entries"
    private let clientsKey = "clients"
    private let materialsKey = "materials"
    private let portfolioImageSectionsKey = "portfolioImageSections"
    
    private let appLinkKey = "appLink"
    private let firstLaunchKey = "appLink"
    
    let appId = "6738696565"
    let privacyPolicyUrl = "https://docs.google.com/document/d/1UIjZjulrouLZZ3_ASMeX6LhGtUqohYF6JYSgxbEV0PI/mobilebasic"
    let email = "gurkanmandirali41@icloud.com"
    
    func saveAppLink(_ appLink: String) {
        UserDefaults.standard.set(appLink, forKey: appLinkKey)
    }

    func getAppLink() -> String {
        return UserDefaults.standard.string(forKey: appLinkKey) ?? ""
    }

    func saveFirstLaunch(_ isFirstLaunch: Bool) {
        UserDefaults.standard.set(isFirstLaunch, forKey: firstLaunchKey)
    }

    func getFirstLaunch() -> Bool {
        return UserDefaults.standard.bool(forKey: firstLaunchKey)
    }
    
    private init() {}
    
    func getPortfolioImageSections() -> [ImageSection] {
        guard let savedPortfolioImageSectionsData = UserDefaults.standard.data(forKey: portfolioImageSectionsKey) else {
            return []
        }
        let decoder = JSONDecoder()
        if let decodedPortfolioImageSections = try? decoder.decode([ImageSection].self, from: savedPortfolioImageSectionsData) {
            return decodedPortfolioImageSections
        }
        return []
    }
    
    func savePortfolioImageSections(_ portfolioImageSections: [ImageSection]) {
        let encoder = JSONEncoder()
        if let encodedportfolioImageSections = try? encoder.encode(portfolioImageSections) {
            UserDefaults.standard.set(encodedportfolioImageSections, forKey: portfolioImageSectionsKey)
        }
    }
    
    func updateMaterialCountById(id: UUID, count: Int) {
        var materials = getMaterials()
        if let index = materials.firstIndex(where: { $0.id == id }) {
            materials[index].count = count
        }
        let encoder = JSONEncoder()
        if let encodedMaterials = try? encoder.encode(materials) {
            UserDefaults.standard.set(encodedMaterials, forKey: materialsKey)
        }
    }
    
    func saveMaterials(_ materials: [Material]) {
        let encoder = JSONEncoder()
        if let encodedMaterials = try? encoder.encode(materials) {
            UserDefaults.standard.set(encodedMaterials, forKey: materialsKey)
        }
    }
    
    func saveMaterial(material: Material) {
        var materials = getMaterials()
        materials.append(material)
        
        let encoder = JSONEncoder()
        if let encodedMaterials = try? encoder.encode(materials) {
            UserDefaults.standard.set(encodedMaterials, forKey: materialsKey)
        }
    }
    
    func getMaterials() -> [Material] {
        guard let savedMaterialsData = UserDefaults.standard.data(forKey: materialsKey) else {
            return []
        }
        let decoder = JSONDecoder()
        if let decodedMaterials = try? decoder.decode([Material].self, from: savedMaterialsData) {
            return decodedMaterials
        }
        return []
    }
    
    func saveEntries(_ entries: [Entrie]) {
        let encoder = JSONEncoder()
        if let encodedEntries = try? encoder.encode(entries) {
            UserDefaults.standard.set(encodedEntries, forKey: entriesKey)
        }
    }
    
    func saveEntrie(entrie: Entrie) {
        var entries = getEntries()
        entries.append(entrie)

        let encoder = JSONEncoder()
        if let encodedEntries = try? encoder.encode(entries) {
            UserDefaults.standard.set(encodedEntries, forKey: entriesKey)
        }
    }
    
    func getEntriesByDate(date: Date) -> [Entrie] {
        let allEntries = getEntries()
        let calendar = Calendar.current
        
        return allEntries.filter { entry in
            calendar.isDate(entry.date, inSameDayAs: date)
        }
    }
    
    func getEntries() -> [Entrie] {
        guard let savedEntriesData = UserDefaults.standard.data(forKey: entriesKey) else {
            return []
        }
        let decoder = JSONDecoder()
        if let decodedEntries = try? decoder.decode([Entrie].self, from: savedEntriesData) {
            return decodedEntries
        }
        return []
    }
    
    func saveClient(client: Client) {
        var clients = getClients()
        clients.append(client)

        let encoder = JSONEncoder()
        if let encodedClients = try? encoder.encode(clients) {
            UserDefaults.standard.set(encodedClients, forKey: clientsKey)
        }
    }
    
    func getClientById(id: UUID) -> Client? {
        let allClients = getClients()
        return allClients.first { $0.id == id }
    }
    
    func getClients() -> [Client] {
        guard let savedClientsData = UserDefaults.standard.data(forKey: clientsKey) else {
            return []
        }
        let decoder = JSONDecoder()
        if let decodedClients = try? decoder.decode([Client].self, from: savedClientsData) {
            return decodedClients
        }
        return []
    }
}

