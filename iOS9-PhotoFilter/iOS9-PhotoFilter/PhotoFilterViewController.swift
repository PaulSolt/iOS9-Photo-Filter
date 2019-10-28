import UIKit
import CoreImage
import Photos

class PhotoFilterViewController: UIViewController {

	// Instance variables
	private let context = CIContext(options: nil)
	private let filter = CIFilter(name: "CIColorControls")!
	
	var originalImage: UIImage? {
		didSet {
			guard let image = originalImage else { return }
			
			var scaledSize = imageView.bounds.size // gets the physical number of pixels on screen
			
			// 1x 2x 3x
			let scale = UIScreen.main.scale
			
			scaledSize = CGSize(width: scaledSize.width * scale, height: scaledSize.height * scale)
			scaledImage = image.imageByScaling(toSize: scaledSize)
		}
	}

	var scaledImage: UIImage? {
		didSet {
			updateImage()
		}
	}
	
	// Outlets
	@IBOutlet var brightnessSlider: UISlider!
	@IBOutlet var contrastSlider: UISlider!
	@IBOutlet var saturationSlider: UISlider!
	@IBOutlet var imageView: UIImageView!
	
	// Init / ViewDidLoad / Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		// TEST: Use the storyboard image to start (Fake it till we make it)
		originalImage = imageView.image
	}
	
	// MARK: Actions
	
	@IBAction func choosePhotoButtonPressed(_ sender: Any) {
		// TODO: show the photo picker so we can choose on-device photos
		// UIImagePickerController + Delegate
		
		presentImagePickerController()
		
	}
	
	@IBAction func savePhotoButtonPressed(_ sender: UIButton) {


	}
	
	// MARK: Slider events
	
	@IBAction func brightnessChanged(_ sender: UISlider) {
		updateImage()
	}
	
	@IBAction func contrastChanged(_ sender: Any) {
		updateImage()
	}
	
	@IBAction func saturationChanged(_ sender: Any) {
		updateImage()
	}
	
	// Instance methods
	
	// public
	// private (internal use only)
	
	
	// Clean Code + Clean Coder
	
private func filterImage(_ image: UIImage) -> UIImage? {
//		let ciImage = originalImage?.ciImage // NIL: must use initializer instead
	
	guard let cgImage = image.cgImage else { return nil }
	let ciImage = CIImage(cgImage: cgImage)
	
	// set up the filter
	filter.setValue(ciImage, forKey: "inputImage")
//		filter.setValue(NSNumber(value: 1.5), forKey: "inputSaturation")
	filter.setValue(saturationSlider.value, forKey: "inputSaturation") // 1.5 is wrapped under the hood as a NSNumber
	filter.setValue(brightnessSlider.value, forKey: "inputBrightness")
	filter.setValue(contrastSlider.value, forKey: "inputContrast")
	
	guard let outputCIImage = filter.outputImage else { return nil }
	
	// render the image
	guard let outputCGImage = context.createCGImage(outputCIImage, from: CGRect(origin: CGPoint.zero, size: image.size)) else { return nil }
	
	return UIImage(cgImage: outputCGImage)
}
	
	private func updateImage() {
		if let image = scaledImage {
			imageView.image = filterImage(image)
		}
	}
	
	private func presentImagePickerController() {

		guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
			NSLog("The photo library is not available")
			return
		}

		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .photoLibrary
		imagePicker.delegate = self

		present(imagePicker, animated: true, completion: nil)
	}
	
}

extension PhotoFilterViewController: UIImagePickerControllerDelegate {
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		picker.dismiss(animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		// get the image
		if let image = info[.originalImage] as? UIImage {
			originalImage = image
		}
		
		// TODO: resize the image when we grab it
		
		
		picker.dismiss(animated: true)
	}
	
}

extension PhotoFilterViewController: UINavigationControllerDelegate {
	
}

