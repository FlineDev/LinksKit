import Foundation

public struct LinkMenu: Identifiable {
   public let id: UUID = UUID()
   let title: String
   let systemImage: String

   let linkSections: [LinkSection]

   public init(title: String, systemImage: String, linkSections: [LinkSection]) {
      self.title = title
      self.systemImage = systemImage
      self.linkSections = linkSections
   }
}

extension LinkMenu {
   public static func followTheApp(links: [Link]) -> Self {
      LinkMenu(
         title: String(localized: "Follow the App", bundle: .module),
         systemImage: "app.badge",
         linkSections: [LinkSection(entries: links.map(LinkSection.Entry.link))]
      )
   }

   public static func followTheDeveloper(links: [Link]) -> Self {
      LinkMenu(
         title: String(localized: "Follow the Developer", bundle: .module),
         systemImage: "person",
         linkSections: [LinkSection(entries: links.map(LinkSection.Entry.link))]
      )
   }

   public static func moreAppsFromDeveloper(linkSections: [LinkSection]) -> Self {
      LinkMenu(
         title: String(localized: "More apps from Developer", bundle: .module),
         systemImage: "plus.square.on.square",
         linkSections: linkSections
      )
   }

   public static func relatedAppsYouMightLike(linkSections: [LinkSection]) -> Self {
      LinkMenu(
         title: String(localized: "Related apps you might Like", bundle: .module),
         systemImage: "star.square.on.square",
         linkSections: linkSections
      )
   }
}
