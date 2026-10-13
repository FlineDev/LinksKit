import Foundation
import Testing

@testable import LinksKit

@Suite("SocialPlatform")
struct SocialPlatformTests {
   @Test(arguments: [
      ("jeehut", "https://bsky.app/profile/jeehut.bsky.social"),
      ("Jeehut", "https://bsky.app/profile/jeehut.bsky.social"),
      ("@jeehut", "https://bsky.app/profile/jeehut.bsky.social"),
      ("jeehut.bsky.social", "https://bsky.app/profile/jeehut.bsky.social"),
      ("fline.dev", "https://bsky.app/profile/fline.dev"),
      ("@fline.dev", "https://bsky.app/profile/fline.dev"),
   ])
   func blueskyLinksResolveShortAndCustomDomainHandles(handle: String, expected: String) {
      #expect(SocialPlatform.bluesky.url(handle: handle).absoluteString == expected)
   }

   @Test func mastodonLinksUseTheInstance() {
      #expect(SocialPlatform.mastodon(instance: "iosdev.space").url(handle: "Jeehut").absoluteString == "https://iosdev.space/@Jeehut")
   }
}
