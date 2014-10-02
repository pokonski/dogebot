# Description:
#   Search Spotify for tracks
#
# Dependencies:
#   None
#
# Commands:
#   spotify <query> - Return URL to the track matching query
#
# Author:
#   Piotrek Okoński

module.exports = (robot) ->
  robot.respond /spotify ?(.+)$/i, (msg) ->
    url = "https://api.spotify.com/v1/search?q=#{encodeURIComponent(msg.match[1])}&type=track&limit=1"
    robot.http(url)
      .get() (err, res, body) ->
        data = JSON.parse(body)
        if data.tracks.items.length > 0
          for song in data.tracks.items
            msg.send(song.external_urls.spotify)
        else
          msg.send "No tracks found on Spotify!"
