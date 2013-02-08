###
POST upload
###
path = require 'path'

# i couldn't get plist to consistently, correctly check for base64 encoding
# plist = require 'plist'
currentAddr = 'http://172.20.25.210:8235'

fs = require 'fs'
exports.index = (req, res, next) ->
  title     = req.body.title
  version   = req.body.version
  url       = currentAddr + '/uploads/' + req.files.file.path.split('/')[2]
  directory = "plists/#{ title }_#{ version }.plist"
  plistContents = buildPlist(url, version, title)
  fs.writeFile 'public/' + directory, plistContents, (err) ->
    throw err  if err
    global.lastUpload =
      title: title
      version: version
      directory: directory
    res.redirect 'back'

buildPlist = (url, version, title) ->
  """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>items</key>
  <array>
    <dict>
      <key>assets</key>
      <array>
        <dict>
          <key>kind</key>
          <string>software-package</string>
          <key>url</key>
          <string>#{ url }</string>
        </dict>
      </array>
      <key>metadata</key>
      <dict>
        <key>bundle-identifier</key>
        <string>com.shutterfly.thislife</string>
        <key>bundle-version</key>
        <string>#{ version }</string>
        <key>kind</key>
        <string>software</string>
        <key>title</key>
        <string>#{ title }</string>
      </dict>
    </dict>
  </array>
</dict>
</plist>"""
