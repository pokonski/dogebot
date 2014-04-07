# Description:
#   Display welcoming I'll be your guide image
#
# Dependencies:
#   None
#
# Commands:
#   guide me - Display "I'll be your guide"
#
# Author:
#   Piotrek Okoński

images = [
  "http://i.imgur.com/fpIWurl.png",
  "http://i.imgur.com/87BzOYK.jpg",
  "http://i.imgur.com/GPtpScm.jpg",
  "http://i.imgur.com/ExtE32i.jpg",
  "http://i.imgur.com/bfJhfPx.jpg",
  "http://i.imgur.com/fEiwbww.jpg"
]

module.exports = (robot) ->
  robot.respond /guide (.+)/i, (msg) ->
    query = msg.match[1]
    if query == "me"
      mention = ""
    else
      mention = "@#{query} "

    img = msg.random images
    msg.send "#{mention}#{img}"