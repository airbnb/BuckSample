import XCTest
import Quick
import Nimble

final class SomeMoreSecondSwiftModuleTestsWithQuickAndNimble: QuickSpec {

    override func spec() {
      describe("A test with Quick") {
          let aString = "Okayest string"
          it("Expectation with Nimble") {
              expect(aString).to(equal("Okayest string"))
          }
      }
  }
}
