require 'should'

AvatarsIO = require '../'
AvatarsIO.appId = 'your app id'
AvatarsIO.accessToken = 'your access token'

describe 'AvatarsIO', ->
	it 'should upload an image', (done) ->
		AvatarsIO.upload '/Users/vadimdemedes/Pictures/People.jpg', (err, url) ->
			/^http\:\/\/avatars\.io\/[A-Za-z0-9]+$/.test(url).should.equal true
			do done
	
	it 'should upload an image with assigned identifier', (done) ->
		AvatarsIO.upload '/Users/vadimdemedes/Pictures/Ocean.jpg', 'beautiful-ocean', (err, url) ->
			url.indexOf('beautiful-ocean').should.not.equal -1
			do done
	
	it 'should return Twitter\'s avatar URL', ->
		AvatarsIO.avatarUrl('twitter', 'vdemedes').should.equal 'http://avatars.io/twitter/vdemedes'
	
	it 'should return auto avatar URL', ->
		AvatarsIO.auto('vdemedes').should.equal 'http://avatars.io/auto/vdemedes'
	
	it 'should return auto avatar URL only for Twitter and Facebook', ->
		AvatarsIO.auto('vdemedes', ['twitter', 'facebook']).should.equal 'http://avatars.io/auto/vdemedes?services=twitter,facebook'