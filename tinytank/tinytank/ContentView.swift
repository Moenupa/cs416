//
//  ContentView.swift
//  tinytank
//
//  Created by Moenupa on 2/24/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State var state = ViewState()
    
    var names = ["TurretLeft","CannonFire","TurretRight","TankLeft","TankForward","TankRight"]
    var scale: CGFloat = 4
    var body: some View {
        let actions :[()-> Void] = [{
            state.anchor?.notifications.rotLT.post()
        },{
            state.anchor?.notifications.fire.post()
        },{
            state.anchor?.notifications.rotRT.post()
        },{
            state.anchor?.notifications.rotL.post()
        },{
            state.anchor?.notifications.forward.post()
        },{
            state.anchor?.notifications.rotR.post()
        }]
        ZStack{
            ARViewContainer(state: state).edgesIgnoringSafeArea(.all)
            GeometryReader{
                geo in
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        
                        ForEach(0..<3){
                            index in
                            Button(action: actions[index]){
                                Image(names[index]).resizable().frame(width: geo.size.width / scale, height: geo.size.width / scale)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        
                        ForEach(3..<6){
                            index in
                            Button(action: actions[index]){
                                Image(names[index]).resizable().frame(width: geo.size.width / scale, height: geo.size.width / scale)
                            }
                        }
                        
                        Spacer()
                    }
                }   
            }
        }
        
    }
}

class ViewState : ObservableObject {
    weak var arView : ARView?
    weak var anchor : TinyToyTank._TinyToyTank?
}


struct ARViewContainer: UIViewRepresentable {
    
    @StateObject var state: ViewState
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        let anchor = try! TinyToyTank.load_TinyToyTank()
        anchor.turret?.setParent(anchor.tank, preservingWorldTransform: true)
        
        arView.scene.anchors.append(anchor)
        state.anchor = anchor
        state.arView = arView
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
                                    
#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
