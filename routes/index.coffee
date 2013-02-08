
###
GET home page.
###

exports.index = (req, res) ->
  res.render 'index',
    title: 'Shutterfly IPA Uploader'

