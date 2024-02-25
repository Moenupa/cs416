//
//  ContentView.swift
//  roomtour
//
//  Created by Moenupa on 2/24/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        uiView.scene.anchors.removeAll()
        
        let anchor = try! RoomTourScenes.loadScene()
        anchor.generateCollisionShapes(recursive: true)
        uiView.scene.anchors.append(anchor)
        
        let anchor1 = try! RoomTourScenes.loadScene1()
        anchor1.generateCollisionShapes(recursive: true)
        uiView.scene.anchors.append(anchor1)
    }
    
}

#Preview {
    ContentView()
}
