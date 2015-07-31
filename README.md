## General Description - ARApps iOS Application

The iOS mobile application contains two sample Augemented Reality (AR) applicationse discussed in the thesis: 
	
	Comprehensive Learning Sample:
		This sample visualize an 3D representation of a T-Rex texture. In addition, this sample respects the
		distance betwwen users and the rendered model, and use that distance as a trigger for playing
		multimedia contents (T-Rex roar sound effect in this case).

	Confidential Information Exchange Sample:
		This sample provides an example scenario where user ID and electronic content can be encrypted within
		a QR Code marker. Only user with appropriate authorizatio is able to view the electronic content 
		associated with the encrypted user ID. In this sample, a music video acts an electronic content.


## How To Run

The application requires a Macintosh Computer with XCode 6 installed to be able to compile and run.
In addition, the application do not work in Simulator environment. We need an actual iOS device and an iOS Developer subscription profile to deploy.

The 3D model can be opened using Maxthon Cinema 4D Studio R16.

## Deliverable Contents

There are two part of deliverable contents: Source Code and Design content.

1. Source Code

All main source code can be found under Source Code folder. Three main folders are:

	- Frameworks & Pods folder: Contain metaio framework, BButton and MBProgressHUD library.
	- ARApps folder: Contain all classes within the applcation
		+ Resources: Contain all resources used
			+ Model: Contain compiled T-Rex 3D model used for Comprehensive Learning Sample
			+ Movies: Contain music video used for Confidential Information Exchange Sample
			+ Sound: Contain T-Rex roar sound effect used for Comprehensive Learning Sample
			+ TrackingReferences: Contain XML texture tracking configuration for each sample.

2. T-Rex 3D model

Contain the designed T-Rex 3D model project in Maxthon Cinema 4D Studio R16 with textures.


## Used Framework & Libraries

- metaio AR Framework as discussed in the thesis
- BButton library for customizing button appearance
- MBProgressHUD for customizable system message.
