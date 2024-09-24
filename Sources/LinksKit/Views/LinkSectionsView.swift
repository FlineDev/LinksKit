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
                  Menu(menu.title, systemImage: menu.systemImage) {
                     LinkSectionsView(linkSections: menu.linkSections)
                  }
               }
            }
         } header: {
            if let title = linkSection.title {
               Text(title)
            }
         }
         .labelStyle(.titleAndIcon)
      }
   }
}
