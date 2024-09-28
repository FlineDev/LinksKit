import Foundation

public actor LinksKit {
   static var providerToken: String = ""
   static var linkSections: [LinkSection] = []

   public static func configure(providerToken: String, linkSections: [LinkSection]) {
      self.providerToken = providerToken
      self.linkSections = linkSections
   }
}
