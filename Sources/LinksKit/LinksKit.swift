import Foundation

/// The wrapper to configure LinksKit.
public actor LinksKit {
   static var providerToken: String = ""
   static var linkSections: [LinkSection] = []

   /// The main configuration method to be called upon app start to confure the contents of ``LinksView`` for use in settings/help menu.
   ///
   /// - Parameters:
   ///   - providerToken: The `pt` query parameter of your app's campaign link. Same for all your apps, thus provided here on top level.
   ///   - linkSections: The separate link sections you want to auto-render. Use one of the convenience helpers `.helpLinks`, `.socialMenus`, `.appMenus`, `.legalLinks`, or pass a custom ``LegalSection`` with the links/menus of your choice.
   public static func configure(providerToken: String, linkSections: [LinkSection]) {
      self.providerToken = providerToken
      self.linkSections = linkSections
   }
}
