import Foundation

public struct LinkSection {
   public enum Entry {
      case link(Link)
      case menu(LinkMenu)
   }

   let entries: [Entry]

   public init(entries: [Entry]) {
      self.entries = entries
   }
}

extension LinkSection {
   // TODO: add a built-in section for app review, FAQs, and contact
   // TODO: add a built-in section for legal links (terms + privacy)
}
