import SwiftUI

public struct LinkSection: Identifiable {
   public enum Entry: Identifiable {
      case link(Link)
      case menu(LinkMenu)

      public var id: UUID {
         switch self {
         case .link(let link): link.id
         case .menu(let linkMenu): linkMenu.id
         }
      }
   }

   public let id: UUID = UUID()
   let title: LocalizedStringKey?
   let entries: [Entry]

   public init(title: LocalizedStringKey? = nil, entries: [Entry]) {
      self.title = title
      self.entries = entries
   }
}

extension LinkSection {
   // TODO: add a built-in combined section for app review, FAQs, and contact
   // TODO: add a built-in combined section with app links to own/related/friends apps
   // TODO: add a built-in combined section for legal links (terms + privacy)
}
