# Description:
#   Get dank youtube videos matching the query
#
# Commands:
#   hubot youtube|yt <query> - Get the top result for YT with query

module.exports = (robot) ->
  robot.respond /(youtube|yt)( me)? (.*)/i, (msg) ->
    youtube msg, msg.match[3], (url) ->
      msg.send url

youtube = (msg, query, cb) ->
  q = q: query, part: 'id', key: process.env.YOUTUBE_API_KEY, type: 'video'
  msg.http('https://www.googleapis.com/youtube/v3/search')
    .query(q)
    .get() (err, res, body) ->
      items = JSON.parse(body).items
      if items?.length > 0
        cb "https://www.youtube.com/watch?v=#{items[0].id.videoId}"
      else
        cb "Ooops, no results!"
