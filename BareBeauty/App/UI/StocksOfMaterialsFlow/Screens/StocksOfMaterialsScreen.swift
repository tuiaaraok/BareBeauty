import SwiftUI

@available(iOS 16.0, *)
struct StocksOfMaterialsScreen: View {
    
    @State private var materials: [Material] = []
    
    @State private var isShowingAddMaterialAlert = false
    @State private var isShowingLowStockAlert = false
    @State private var newMaterialName = ""
    @State private var newMaterialCount = ""
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: { isShowingAddMaterialAlert = true }) {
                HStack(spacing: 0) {
                    Image("plusButtonIcon")
                        .frame(maxWidth: 25, maxHeight: 25)
                    Text("Add a new material")
                        .padding(.leading, 7)
                    Spacer()
                }
                .customFont(.mainText)
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 14, leading: 16, bottom: 15, trailing: 16))
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.buttons)
                .cornerRadius(20)
            }
            .padding(25)
            
            List {
                ForEach(materials) { material in
                    MaterialView(material: material, onLowStock: {
                        isShowingLowStockAlert = true
                    })
                    .listRowBackground(Color.background)
                }
                .onDelete { indexSet in
                    materials.remove(atOffsets: indexSet)
                    storage.saveMaterials(materials)
                }
                
            }
            .padding(.bottom, 1)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
        .onAppear {
            materials = storage.getMaterials()
        }
        .overlay(
            CustomAlertView(isPresented: $isShowingAddMaterialAlert, newMaterialName: $newMaterialName, newMaterialCount: $newMaterialCount, onAdd: addNewMaterial)
        )
        .overlay(
            CustomAlertLowStockView(isPresented: $isShowingLowStockAlert)
        )
    }
    
    private func addNewMaterial() {
        guard let count = Int(newMaterialCount), !newMaterialName.isEmpty else { return }
        
        let newMaterial = Material(name: newMaterialName, count: count)
        materials.append(newMaterial)
        storage.saveMaterial(material: newMaterial)
        
        newMaterialName = ""
        newMaterialCount = ""
    }
}

@available(iOS 16.0, *)
private struct CustomAlertLowStockView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Warning")
                        .foregroundStyle(Color.black)
                    
                    Text("Material stock is low!")
                        .foregroundStyle(Color.black)
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Close")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.buttons)
                            .cornerRadius(20)
                            .foregroundStyle(Color.white)
                            .frame(maxHeight: 50)
                    }
                    .frame(maxWidth: .infinity)
                }
                .customFont(.mainText)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 40)
            }
        }
    }
}

@available(iOS 16.0, *)
private struct CustomAlertView: View {
    @Binding var isPresented: Bool
    @Binding var newMaterialName: String
    @Binding var newMaterialCount: String
    var onAdd: () -> Void
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Add a new material")
                        .foregroundStyle(Color.white)
                    
                    Text("Enter the name and count of the material")
                        .foregroundStyle(Color.white)
                    
                    MainTextField(text: $newMaterialName, placeholder: "Name")
                    MainTextField(text: $newMaterialCount, placeholder: "Count", keyboardType: .numberPad)
                    
                    HStack {
                        
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.buttonsDeepRed)
                                .cornerRadius(20)
                                .foregroundStyle(Color.white)
                                .frame(maxHeight: 50)
                        }
                        
                        Button(action: {
                            onAdd()
                            isPresented = false
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.buttonsDeepGreen)
                                .cornerRadius(20)
                                .foregroundStyle(Color.white)
                                .frame(maxHeight: 50)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .customFont(.mainText)
                .padding()
                .background(Color.buttons)
                .cornerRadius(20)
                .padding(.horizontal, 40)
            }
        }
    }
}

@available(iOS 16.0, *)
struct MaterialView: View {
    
    @State var material: Material
    var onLowStock: () -> Void
    
    private let storage = Storage.shared
    
    var body: some View {
        
        HStack(spacing: 0) {
            Text(material.name)
            Spacer()
            HStack(spacing: 14) {
                MinusButton(action: minusButtonAction)
                    .buttonStyle(.plain)
                Text("\(material.count)")
                PlusButton(action: plusButtonAction)
                    .buttonStyle(.plain)
            }
        }
        .customFont(.materialsScreenMainText)
        .foregroundStyle(Color.black)
    }
    
    private func minusButtonAction() {
        if material.count > 0 {
            material.count -= 1
            storage.updateMaterialCountById(id: material.id, count: material.count)
        }
        if material.count < 3 {
            onLowStock()
        }
    }
    
    private func plusButtonAction() {
        material.count += 1
        storage.updateMaterialCountById(id: material.id, count: material.count)
    }
}
