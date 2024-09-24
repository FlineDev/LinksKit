import SwiftUI

struct LinkSectionsView: View {
   @Environment(\.openURL) private var openURL

   let linkSections: [LinkSection]
   let style: LinksStyle

   var body: some View {
      ForEach(self.linkSections) { linkSection in
         switch style {
         case .sections:
            Section {
               ForEach(linkSection.entries) { entry in
                  switch entry {
                  case .link(let link):
                     Button(link.title, systemImage: link.systemImage) {
                        self.openURL(link.url)
                     }

                  case .menu(let menu):
                     Menu(menu.title, systemImage: menu.systemImage) {
                        LinkSectionsView(linkSections: menu.linkSections, style: self.style)
                     }
                  }
               }
            } header: {
               if let title = linkSection.title {
                  Text(title)
               }
            }

         case .groups:
            Group {
               ForEach(linkSection.entries) { entry in
                  switch entry {
                  case .link(let link):
                     Button(link.title, systemImage: link.systemImage) {
                        self.openURL(link.url)
                     }

                  case .menu(let menu):
                     Menu(menu.title, systemImage: menu.systemImage) {
                        LinkSectionsView(linkSections: menu.linkSections, style: self.style)
                     }
                  }
               }
            }
            .labelStyle(.titleAndIcon)

            if linkSection.id != self.linkSections.last?.id {
               Divider()
            }
         }

      }
   }
}
