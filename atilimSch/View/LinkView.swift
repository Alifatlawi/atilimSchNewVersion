//
//  LinkView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/30/23.
//

import SwiftUI

struct LinkView: View {
    @State private var showMailView = false
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    profile
                    
                    links
                    
                    menu
                    
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Settings")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var menu: some View {
        Section(header: Text("Contact me")) {
            Button(action: {
                self.showingActionSheet = true
            }) {
                Label("Send me a message", systemImage: "message")
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Choose a method"), message: Text("Please choose your preferred contact method"), buttons: [
                    .default(Text("Email")) {
                        self.openEmailApp()
                    },
                    .default(Text("Instagram"), action: {
                        self.openInstagram(username: "xt4ki")
                    }),
                    .cancel()
                ])
            }
            //            NavigationLink(destination: MailView(subject: "Message from App", toRecipients: ["ali.a.mardan@gmail.com"]), isActive: $showMailView) {
            //                EmptyView()
            //            }
        }
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    var profile : some View {
        VStack(spacing: 8) {
            Image(systemName: "person")
                .symbolVariant(.circle.fill)
                .font(.system(size: 30))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x:-50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.6)
                )
            Text("Made by Ali Al-Fatlawi")
                .font(.title2)
                .fontWeight(.semibold)
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var links : some View {
        Section (header: Text("Useful Links")){
            Link(destination: URL(string: "https://www.atilim.edu.tr/en/dersprogrami")!, label: {
                HStack {
                    Label("Atilim Schedules", systemImage: "building.columns")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .accentColor(.primary)
            
            Link(destination: URL(string: "https://kimlik.atilim.edu.tr/#/")!, label: {
                HStack {
                    Label("Atacs", systemImage: "graduationcap.fill")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .accentColor(.primary)
            
            Link(destination: URL(string: "https://www.alialfatlawi.me/")!, label: {
                HStack {
                    Label("My website", systemImage: "person.fill")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .accentColor(.primary)
        }
    }
    func openInstagram(username: String) {
        let appURL = URL(string: "instagram://user?username=\(username)")!
        let webURL = URL(string: "https://instagram.com/\(username)")!
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
    
    func openEmailApp() {
        if let url = URL(string: "mailto:alawi_amer@yahoo.co.uk") {
            UIApplication.shared.open(url)
        }
    }
}



#Preview {
    LinkView()
}



import MessageUI

struct MailView: UIViewControllerRepresentable {
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView
        
        init(parent: MailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var subject: String
    var toRecipients: [String]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(subject)
        vc.setToRecipients(toRecipients)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

