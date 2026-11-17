import SwiftUI
import Combine

class PlantsViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var hasAddedPlant = false

    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var progress: Double {
        plants.isEmpty ? 0 : Double(wateredCount) / Double(plants.count)
    }

    var allWatered: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    func addPlant(_ plant: Plant) {
        plants.append(plant)
        hasAddedPlant = true
        NotificationManager.sendTest()
    }

    func updatePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
        }
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }

    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
        }
    }
}
