# DvdLogo
puts a bouncing dvd logo over your iPhone to fuel your [dopamine](https://github.com/opa334/Dopamine) addiction. (requires a jailbroken iPhone)

 Forked from [Snoverlay](https://github.com/leftyfl1p/Snoverlay), uses Snoverlay code for drawing images over the screen.

 this demo video is slower than real life my screen recrorder bugged
 ![](demo.gif)
 
 ## Installation
 For arm64, install the deb from releases. For arm64e, the arm64 deb *might* work (try it), or you can build from source. iOS version requirements are unknown, tested on iPhone 5s iOS 10.3.3 only. Definitely doesn't work on rootless.

 ## Building
 You need Theos installed. I used the iOS 10.3 SDK. `make package` will produce a `deb` package in `packages`. Building for arm64e or a different SDK should edit the Makefile.
