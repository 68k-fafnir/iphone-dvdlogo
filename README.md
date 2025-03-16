# DvdLogo
puts a bouncing dvd logo over your phone to fuel your [dopamine](https://github.com/opa334/Dopamine) addiction

 Uses code from [Snoverlay](https://github.com/leftyfl1p/Snoverlay) for drawing over the screen.
 
 ## Installation
 For arm64, download the deb from releases. For arm64e, the arm64 deb *might* work (try it), or you can build from source. iOS version requirements are unknown, tested on iPhone 5s iOS 10.3.3 only.

 ## Building
 You need Theos installed. I used the iOS 10.3 SDK. `make package` will produce a `deb` package in `packages`. Building for arm64e or a different SDK should edit the Makefile.
