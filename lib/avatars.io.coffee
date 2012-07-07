request = require 'request'
fs = require 'fs'
crypto = require 'crypto'

class AvatarsIO
	@appId: ''
	@accessToken: ''
	
	@upload: (path, identifier, callback) ->
		if 'function' is typeof identifier
			callback = identifier
			identifier = ''
		
		fs.readFile path, (err, buffer) =>
			request
				url: 'http://avatars.io/v1/token'
				method: 'POST'
				headers:
					'x-client_id': @appId
					'Authorization': "OAuth #{ @accessToken }"
				body: JSON.stringify
					data:
						filename: path
						md5: crypto.createHash('md5').update(buffer).digest('hex')
						size: buffer.length
						path: identifier
			, (err, res, body) =>
				body = JSON.parse body
				return callback false, body.data.url if not body.data.upload_info
				
				request
					url: body.data.upload_info.upload_url
					method: 'PUT'
					headers:
						'Authorization': body.data.upload_info.signature
						'Date': body.data.upload_info.date
						'Content-Type': body.data.upload_info.content_type
						'x-amz-acl': 'public-read'
					body: buffer
				, =>
					request
						url: "http://avatars.io/v1/token/#{ body.data.id }/complete"
						method: 'POST'
						headers:
							'x-client_id': @appId
							'Authorization': "OAuth #{ @accessToken }"
						body: ''
					, (err, res, body) ->
						callback false, JSON.parse(body).data
	
	@avatarUrl: (service, key) -> "http://avatars.io/#{ service }/#{ key }"
	@avatarURL: -> @avatarUrl.apply @, arguments
	@avatar_url: -> @avatarUrl.apply @, arguments
	@avatar: -> @avatarUrl.apply @, arguments
	
	@autoUrl: (key) -> "http://avatars.io/auto/#{ key }"
	@autoURL: -> @autoUrl.apply @, arguments
	@auto_url: -> @autoUrl.apply @, arguments
	@auto: -> @autoUrl.apply @, arguments

module.exports = AvatarsIO