import SwiftUI

struct LinkSectionsView: View {
   @Environment(\.openURL) private var openURL

   let linkSections: [LinkSection]

   var body: some View {
      ForEach(self.linkSections) { linkSection in
         Section {
            ForEach(linkSection.entries) { entry in
               switch entry {
               case .link(let link):
                  Button(link.title, systemImage: link.systemImage) {
                     self.openURL(link.url)
                  }

               case .menu(let menu):
                  Menu {
                     LinkSectionsView(linkSections: menu.linkSections)
                  } label: {
                     Label(menu.title, systemImage: menu.systemImage)
                        #if os(visionOS)
                        .padding(20)
                        #endif
                  }
                  #if os(visionOS)
                  .padding(-20)
                  .buttonStyle(.plain)
                  #endif
               }
            }
         } header: {
            if let title = linkSection.title {
               Text(title)
            }
         }
      }
   }
}
