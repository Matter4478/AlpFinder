//
//  ContentView.swift
//  AlpFinder
//
//  Created by M. De Vries on 16/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    let ExampleData = try? JSONEncoder().encode(SkiData(resorts: [ResortData(name: "Zermatt", webcams: [
        
        CamData(name: "Gornergrat", url: URL(string: "https://zermatt.roundshot.com/gornergrat/#/")!),
        
        CamData(name: "Trockener Steg", url: URL(string: "https://zbag.roundshot.com/trockener-steg/")!),
        
        CamData(name: "Klein Matterhorn", url: URL(string: "https://zbag.roundshot.com/matterhornglacierparadise/")!),
        
        CamData(name: "Rothorn", url: URL(string: "https://zbag.roundshot.com/rothorn/")!)
    ], website: URL(string: "https://matterhornparadise.ch/de")!, logo: URL(string: "https://zermatt.swiss/_ipx/f_webp&s_186x140/images/logo.png")!, lift: LiftData(snowReport: URL(string: "https://www.matterhornparadise.ch/de/erleben/skifahren/pistenplan")!, skiMap: URL(string: "https://infosnow.ch/~apgmontagne/?id=174&tab=map-wi&lang=de&zoom=950,400,300,300")!))]))
    
    @State var data: SkiData = SkiData(resorts: [])

    var body: some View {
        NavigationStack {
            List {
                ForEach(data.resorts, id: \.self){ resort in
//                    ResortView(resort: resort)
                    NavigationLink(destination:  ResortView(resort: resort)) {
                        HStack{
                            AsyncImage(url: resort.logo) { phase in
                                switch phase {
                                case .failure:
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                case .success(let image):
                                    image
                                default:
                                    ProgressView()
                                }
                            }
                            .scaledToFit()
                            Text(resort.name)
                                .fontWeight(.medium)
                        }
                    }
                }
//                Button {
//                    let encoder = JSONEncoder()
//                    encoder.outputFormatting = .prettyPrinted
//                    let out = try! encoder.encode(data)
//                    print(String(data: out, encoding: .utf8))
//                    print(FileManager.default.isWritableFile(atPath: "/Users/m.devries/Downloads"))
//                    FileManager.default.createFile(atPath: "/Users/m.devries/Downloads/skiresort.json", contents: out)
//                } label: {
//                    Text("JSON Output")
//                }

            }
            
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
                ToolbarItem{
                    Button(action: {}){
                        Image(systemName: "line.3.horizontal")
                    }
                }
#if os(iOS)
#endif
            }
//            if !data.resorts.isEmpty{
//                ResortView(resort: data.resorts[0])
//            }
        }
        .onAppear(){
            do {
                data = try Decoder.decode(SkiData.self, from: ExampleData ?? Data())
            } catch {
                print(error)
            }
        }
        
    }
}

struct ResortView: View{
    let resort: ResortData
    
    var body: some View{
        GeometryReader{ reader in
            ScrollView(.vertical){
                HStack{
                    Text(resort.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.all)
                    Spacer()
                }

                ScrollView(.horizontal){
                    HStack{
                        ForEach(resort.webcams, id: \.self){ cam in
                            NavigationLink {
                                WebView(url: cam.url)
//                                    .frame(height: reader.size.height * 1)
                                    .clipShape(.rect(cornerRadius: 5.0))
                                    .padding(.all)
                                
                            } label: {
                                CamView(cam: cam)
                                    .disabled(true)
                                    .padding([.all], 0)
                            }
//                            CamView(cam: cam)
                        }
                    }.padding([.leading, .trailing])
                }
//                NavigationLink {
//                    WebView(url: resort.lift.skiMap)
//                } label: {
//                    WebView(url: resort.lift.skiMap)
//                        .disabled(true)
//                        .frame(height: reader.size.height * 1)
//                        .clipShape(.rect(cornerRadius: 5.0))
//                        .padding(.all)
//                }
                WebView(url: resort.lift.skiMap)
//                    .disabled(true)
                    .frame(height: reader.size.height * 1)
                    .clipShape(.rect(cornerRadius: 5.0))
                    .padding(.all)
            }
        }
    }
}

struct CamView: View {
    let cam: CamData
    var body: some View {
        ZStack{
            WebView(url: cam.url)
//                .disabled(true)
//            Text(cam.name)
        }.frame(width: 300, height: 300)
            .clipShape(.rect(cornerRadius: 5.0))
            .padding(.all)
    }
}




#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
