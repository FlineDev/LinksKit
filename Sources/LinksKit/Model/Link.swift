import SwiftUI

public struct Link {
   let title: String
   let systemImage: String

   let url: URL

   public init(title: String, systemImage: String, url: URL) {
      self.title = title
      self.systemImage = systemImage
      self.url = url
   }
}

extension Link {
   public static func privacyPolicy(url: URL) -> Self {
      Link(title: String(localized: "Privacy Policy", bundle: .module), systemImage: "lock.shield", url: url)
   }

   public static func appStoreTermsAndConditions() -> Self {
      .termsAndConditions(url: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
   }

   public static func termsAndConditions(url: URL) -> Self {
      Link(title: String(localized: "Terms and Conditions", bundle: .module), systemImage: "text.book.closed", url: url)
   }

   public static func followUsOn(socialMedia: SocialMedia, username: String) -> Self {
      Link(
         title: String(localized: "Follow us on \(socialMedia.rawValue)"),
         systemImage: socialMedia.systemImage,
         url: socialMedia.url(username: username)
      )
   }

   public static func developerOn(socialMedia: SocialMedia, username: String) -> Self {
      Link(
         title: String(localized: "Developer on \(socialMedia.rawValue)"),
         systemImage: socialMedia.systemImage,
         url: socialMedia.url(username: username)
      )
   }

   public static func appOn(socialMedia: SocialMedia, username: String) -> Self {
      Link(
         title: String(localized: "App on \(socialMedia.rawValue)"),
         systemImage: socialMedia.systemImage,
         url: socialMedia.url(username: username)
      )
   }

   public static func app(
      id: String,
      name: String,
      systemImage: String = "app",
      campaignToken: String = Bundle.main.bundleIdentifier ?? "com.default.identifier"
   ) -> Self {
      Link(
         title: name,
         systemImage: systemImage,
         url: URL(string: "https://apps.apple.com/app/id\(id)?pt=\(LinksKit.publisherToken)&ct=\(campaignToken)&mt=8")!
      )
   }
}
