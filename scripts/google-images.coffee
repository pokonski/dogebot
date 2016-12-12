# Description:
#   A way to interact with the Google Images API.
#
# Commands:
#   hubot image me <query> - The Original. Queries Google Images for <query> and returns a random top result.
#   hubot animate me <query> - The same thing as `image me`, except adds a few parameters to try to return an animated GIF instead.

module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], false, (url) ->
      msg.send url

  robot.respond /animate( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[2], true, (url) ->
      msg.send url

imageMe = (msg, query, animated, cb) ->
  q = searchType: 'image', q: query, safe: process.env.GOOGLE_CSE_SAFE_SEARCH || "medium", key: process.env.GOOGLE_CSE_KEY, cx: process.env.GOOGLE_CSE_CX
  if typeof animated is 'boolean' and animated is true
    q.fileType = 'gif'
    q.hq = 'animated'
    q.tbs = 'itp:animated'

  msg.http('https://www.googleapis.com/customsearch/v1')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.items
      if images?.length > 0
        cb images[0].link
