import Foundation

public final class LinksKit {
   static var publisherToken: String = ""
   static var linkSections: [LinkSection] = []

   public static func configure(publisherToken: String, linkSections: [LinkSection]) {
      self.publisherToken = publisherToken
      self.linkSections = linkSections
   }
}
