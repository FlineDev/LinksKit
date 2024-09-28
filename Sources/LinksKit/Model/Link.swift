import SwiftUI

public struct Link: Identifiable {
   public let id: UUID = UUID()
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
   public static func rateTheApp(id: String) -> Self {
      Link(
         title: String(localized: "Rate the App", bundle: .module),
         systemImage: "star",
         url: URL(string: "https://apps.apple.com/app/apple-store/id\(id)?action=write-review")!
      )
   }

   public static func frequentlyAskedQuestions(url: URL) -> Self {
      Link(title: String(localized: "Frequently Asked Questions (FAQ)", bundle: .module), systemImage: "questionmark.bubble", url: url)
   }

   public static func contactSupport(email: String) -> Self {
      Link(title: String(localized: "Contact Support", bundle: .module), systemImage: "envelope", url: URL(string: "mailto:\(email)")!)
   }

   public static func privacyPolicy(url: URL) -> Self {
      Link(title: String(localized: "Privacy Policy", bundle: .module), systemImage: "lock.shield", url: url)
   }

   public static func appStoreTermsAndConditions() -> Self {
      .termsAndConditions(url: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
   }

   public static func termsAndConditions(url: URL) -> Self {
      Link(title: String(localized: "Terms and Conditions", bundle: .module), systemImage: "text.book.closed", url: url)
   }

   public static func followUsOn(socialPlatform: SocialPlatform, handle: String) -> Self {
      Link(
         title: String(localized: "Follow us on \(socialPlatform.description)"),
         systemImage: socialPlatform.systemImage,
         url: socialPlatform.url(handle: handle)
      )
   }

   public static func developerOn(socialPlatform: SocialPlatform, handle: String) -> Self {
      Link(
         title: String(localized: "Developer on \(socialPlatform.description)"),
         systemImage: socialPlatform.systemImage,
         url: socialPlatform.url(handle: handle)
      )
   }

   public static func appOn(socialPlatform: SocialPlatform, handle: String) -> Self {
      Link(
         title: String(localized: "App on \(socialPlatform.description)"),
         systemImage: socialPlatform.systemImage,
         url: socialPlatform.url(handle: handle)
      )
   }

   public static func ownApp(
      id: String,
      name: String,
      systemImage: String,
      campaignToken: String = Bundle.main.bundleIdentifier ?? "com.default.identifier"
   ) -> Self {
      Link(
         title: name,
         systemImage: systemImage,
         url: URL(string: "https://apps.apple.com/app/id\(id)?pt=\(LinksKit.providerToken)&ct=\(campaignToken)&mt=8")!
      )
   }

   public static func friendsApp(
      id: String,
      name: String,
      systemImage: String,
      providerToken: String? = nil,
      campaignToken: String = Bundle.main.bundleIdentifier ?? "com.default.identifier"
   ) -> Self {
      if let providerToken {
         Link(
            title: name,
            systemImage: systemImage,
            url: URL(string: "https://apps.apple.com/app/id\(id)?pt=\(providerToken)&ct=\(campaignToken)&mt=8")!
         )
      } else {
         Link(
            title: name,
            systemImage: systemImage,
            url: URL(string: "https://apps.apple.com/app/id\(id)?ct=\(campaignToken)&mt=8")!
         )
      }

   }
}
