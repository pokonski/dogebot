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
]

module.exports = (robot) ->
  robot.respond /guide me/i, (msg) ->
    msg.send msg.random images