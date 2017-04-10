Pod::Spec.new do |s|
  s.name             = 'SquishyButton'
  s.version          = '0.1.0'
  s.summary          = 'A button that squishes when pressed. As seen in the Clips app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SquishyButton responds to touches with a simple and nice animation. Customize the animation behavior and the button style as you wish.
                       DESC

  s.homepage         = 'https://github.com/BalestraPatrick/SquishyButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BalestraPatrick' => 'me@patrickbalestra.com' }
  s.source           = { :git => 'https://github.com/BalestraPatrick/SquishyButton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/BalestraPatrick'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SquishyButton/Classes/**/*'

  # s.resource_bundles = {
  #   'SquishyButton' => ['SquishyButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
