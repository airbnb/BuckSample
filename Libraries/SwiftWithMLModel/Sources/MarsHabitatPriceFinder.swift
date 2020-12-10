/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 Main view controller for the MarsHabitatPricer app. Uses a `UIPickerView` to gather user inputs.
 The model's output is the predicted price.
 */

import CoreML
import Foundation

public final class MarsHabitatPriceFinder {

  // MARK: - Initialization

  public init() {}

  // MARK: - Properties

  let model = try! MarsHabitatPricer(configuration: MLModelConfiguration())

  /// Formatter for the output.
  let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 0
    formatter.usesGroupingSeparator = true
    formatter.locale = Locale(identifier: "en_US")
    return formatter
  }()

  /**
   Performs the integration with Core ML.
   First gather the values for input to the model. Then have the model generate
   a prediction with those inputs. Finally, present the predicted value to
   the user.
   */
  public func predictedPrice(solarPanels: Double, greenhouses: Double, size: Double) -> Double {
    guard let marsHabitatPricerOutput = try? model.prediction(solarPanels: solarPanels, greenhouses: greenhouses, size: size) else {
      fatalError("Unexpected runtime error.")
    }

    return marsHabitatPricerOutput.price
  }
}
