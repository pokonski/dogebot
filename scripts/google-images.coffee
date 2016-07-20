# Description:
#   A way to interact with the Google Images API.
#
# Commands:
#   hubot image me <query> - The Original. Queries Google Images for <query> and returns a random top result.
#   hubot animate me <query> - The same thing as `image me`, except adds a few parameters to try to return an animated GIF instead.

module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /animate( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[2], true, (url) ->
      msg.send url

imageMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = searchType: 'image', q: query, safe: process.env.GOOGLE_CSE_SAFE_SEARCH, key: process.env.GOOGLE_CSE_KEY, cx: process.env.GOOGLE_CSE_CX
  q.exactTerms = 'gif' if typeof animated is 'boolean' and animated is true
  q.imgType = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('https://www.googleapis.com/customsearch/v1')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.items
      if images?.length > 0
        cb images[0].link
