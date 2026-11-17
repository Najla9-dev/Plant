import SwiftUI
import Combine

class ReminderViewModel: ObservableObject {
    @Published var plantName = ""
    @Published var room = "Bedroom"
    @Published var light = "Full sun"
    @Published var wateringDays = "Every day"
    @Published var water = "20-50 ml"

    private var plantToEdit: Plant?

    var isEditing: Bool {
        plantToEdit != nil
    }

    init(plantToEdit: Plant? = nil) {
        self.plantToEdit = plantToEdit

        if let plant = plantToEdit {
            plantName = plant.name
            room = plant.room
            light = plant.light
            wateringDays = plant.wateringDays
            water = plant.water
        }
    }

    func buildPlant() -> Plant {
        var plant = plantToEdit ?? Plant(
            name: plantName,
            room: room,
            light: light,
            wateringDays: wateringDays,
            water: water
        )
        plant.name = plantName
        plant.room = room
        plant.light = light
        plant.wateringDays = wateringDays
        plant.water = water
        return plant
    }
}
