import SwiftUI

/// Represents a link with a title, system image, and URL.
///
/// Use this struct to create custom links or use the provided static methods for common link types.
public struct Link: Identifiable {
   public let id: UUID = UUID()
   let title: String
   let systemImage: String
   let url: URL

   /// Creates a new Link instance.
   ///
   /// - Parameters:
   ///   - title: The display title for the link.
   ///   - systemImage: The name of the system image to use as an icon.
   ///   - url: The URL the link should open.
   ///
   /// Example usage:
   /// ```swift
   /// let customLink = Link(
   ///     title: "Visit Our Website",
   ///     systemImage: "globe",
   ///     url: URL(string: "https://www.example.com")!
   /// )
   /// ```
   public init(title: String, systemImage: String, url: URL) {
      self.title = title
      self.systemImage = systemImage
      self.url = url
   }
}

extension Link {
   /// Creates a link to rate the app on the App Store.
   ///
   /// - Parameter id: The App Store ID of your app.
   /// - Returns: A Link instance for rating the app.
   ///
   /// Example usage:
   /// ```swift
   /// let rateLink = Link.rateTheApp(id: "1234567890")
   /// ```
   public static func rateTheApp(id: String) -> Self {
      Link(
         title: String(localized: "Rate the App", bundle: .module),
         systemImage: "star",
         url: URL(string: "https://apps.apple.com/app/apple-store/id\(id)?action=write-review")!
      )
   }

   /// Creates a link to a Frequently Asked Questions (FAQ) page.
   ///
   /// - Parameter url: The URL of your FAQ page.
   /// - Returns: A Link instance for the FAQ.
   ///
   /// Example usage:
   /// ```swift
   /// let faqLink = Link.frequentlyAskedQuestions(url: URL(string: "https://www.example.com/faq")!)
   /// ```
   public static func frequentlyAskedQuestions(url: URL) -> Self {
      Link(title: String(localized: "Frequently Asked Questions (FAQ)", bundle: .module), systemImage: "questionmark.bubble", url: url)
   }

   /// Creates a link to contact support via email.
   ///
   /// - Parameter email: The support email address.
   /// - Returns: A Link instance for contacting support.
   ///
   /// Example usage:
   /// ```swift
   /// let supportLink = Link.contactSupport(email: "support@example.com")
   /// ```
   public static func contactSupport(email: String) -> Self {
      Link(title: String(localized: "Contact Support", bundle: .module), systemImage: "envelope", url: URL(string: "mailto:\(email)")!)
   }

   /// Creates a link to the privacy policy.
   ///
   /// - Parameter url: The URL of your privacy policy.
   /// - Returns: A Link instance for the privacy policy.
   ///
   /// Example usage:
   /// ```swift
   /// let privacyLink = Link.privacyPolicy(url: URL(string: "https://www.example.com/privacy")!)
   /// ```
   public static func privacyPolicy(url: URL) -> Self {
      Link(title: String(localized: "Privacy Policy", bundle: .module), systemImage: "lock.shield", url: url)
   }

   /// Creates a link to the standard App Store Terms and Conditions.
   ///
   /// - Returns: A Link instance for the App Store Terms and Conditions.
   ///
   /// Example usage:
   /// ```swift
   /// let termsLink = Link.appStoreTermsAndConditions()
   /// ```
   public static func appStoreTermsAndConditions() -> Self {
      .termsAndConditions(url: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
   }

   /// Creates a link to custom Terms and Conditions.
   ///
   /// - Parameter url: The URL of your Terms and Conditions.
   /// - Returns: A Link instance for the Terms and Conditions.
   ///
   /// Example usage:
   /// ```swift
   /// let customTermsLink = Link.termsAndConditions(url: URL(string: "https://www.example.com/terms")!)
   /// ```
   public static func termsAndConditions(url: URL) -> Self {
      Link(title: String(localized: "Terms and Conditions", bundle: .module), systemImage: "text.book.closed", url: url)
   }

   /// Creates a link to follow the app on a social media platform.
   ///
   /// - Parameters:
   ///   - socialPlatform: The social media platform.
   ///   - handle: The app's handle or username on the platform.
   /// - Returns: A Link instance for following the app on social media.
   ///
   /// Example usage:
   /// ```swift
   /// let twitterFollowLink = Link.followUsOn(socialPlatform: .twitter, handle: "YourAppHandle")
   /// ```
   public static func followUsOn(socialPlatform: SocialPlatform, handle: String) -> Self {
      Link(
         title: String(localized: "Follow us on \(socialPlatform.description)"),
         systemImage: socialPlatform.systemImage,
         url: socialPlatform.url(handle: handle)
      )
   }

   /// Creates a link to the developer's profile on a social media platform.
   ///
   /// - Parameters:
   ///   - socialPlatform: The social media platform.
   ///   - handle: The developer's handle or username on the platform.
   /// - Returns: A Link instance for the developer's social media profile.
   ///
   /// Example usage:
   /// ```swift
   /// let devTwitterLink = Link.developerOn(socialPlatform: .twitter, handle: "YourDevHandle")
   /// ```
   public static func developerOn(socialPlatform: SocialPlatform, handle: String) -> Self {
      Link(
         title: String(localized: "Developer on \(socialPlatform.description)"),
         systemImage: socialPlatform.systemImage,
         url: socialPlatform.url(handle: handle)
      )
   }

   /// Creates a link to the app's profile on a social media platform.
   ///
   /// - Parameters:
   ///   - socialPlatform: The social media platform.
   ///   - handle: The app's handle or username on the platform.
   /// - Returns: A Link instance for the app's social media profile.
   ///
   /// Example usage:
   /// ```swift
   /// let appInstagramLink = Link.appOn(socialPlatform: .instagram, handle: "YourAppHandle")
   /// ```
   public static func appOn(socialPlatform: SocialPlatform, handle: String) -> Self {
      Link(
         title: String(localized: "App on \(socialPlatform.description)"),
         systemImage: socialPlatform.systemImage,
         url: socialPlatform.url(handle: handle)
      )
   }

   /// Creates a link to one of your own apps on the App Store.
   ///
   /// - Parameters:
   ///   - id: The App Store ID of the app.
   ///   - name: The name of the app.
   ///   - systemImage: The system image name to use as an icon.
   ///   - campaignToken: An optional campaign token for tracking. Defaults to the main bundle identifier.
   /// - Returns: A Link instance for your own app.
   ///
   /// Example usage:
   /// ```swift
   /// let myOtherAppLink = Link.ownApp(
   ///     id: "1234567890",
   ///     name: "My Other App",
   ///     systemImage: "star.circle",
   ///     campaignToken: "myOtherApp"
   /// )
   /// ```
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

   /// Creates a link to a friend's app on the App Store.
   ///
   /// - Parameters:
   ///   - id: The App Store ID of the app.
   ///   - name: The name of the app.
   ///   - systemImage: The system image name to use as an icon.
   ///   - providerToken: An optional provider token for the app's developer.
   ///   - campaignToken: An optional campaign token for tracking. Defaults to the main bundle identifier.
   /// - Returns: A Link instance for a friend's app.
   ///
   /// Example usage:
   /// ```swift
   /// let friendAppLink = Link.friendsApp(
   ///     id: "0987654321",
   ///     name: "Friend's Cool App",
   ///     systemImage: "paintbrush",
   ///     providerToken: "123456",
   ///     campaignToken: "friendCoolApp"
   /// )
   /// ```
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
