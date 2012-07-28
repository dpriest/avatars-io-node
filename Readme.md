# Avatars.io client library

Hosted User Avatar Service for your Apps and Site.

# Installation

`npm install avatars.io`

# Usage

```javascript
var AvatarsIO = require('avatars.io');

// getting URLs to avatars from social networks

AvatarsIO.assetURL('twitter', 'vdemedes'); // http://avatars.io/twitter/vdemedes

// auto-detecting avatar on social networks

AvatarsIO.auto('vdemedes'); // http://avatars.io/auto/vdemedes
AvatarsIO.auto('vdemedes', ['facebook', 'twitter']); // http://avatars.io/auto/vdemedes?services=facebook,twitter

// uploading own avatars

AvatarsIO.appId = 'your app id';
AvatarsIO.accessToken = 'your access token';

AvatarsIO.upload('path/to/image.jpg', function(err, url){
	// url is a URL of just uploaded avatar
});

// uploading own avatars with custom identifier assigned to them

AvatarsIO.upload('path/to/image.jpg', 'awesome-image', function(err, url){
	// url could be http://avatars.io/asfsd8fh45fjisdf/awesome-image
});
```

# Tests

Run tests by executing `mocha` in Terminal.

# License

&copy; Chute Corporation.