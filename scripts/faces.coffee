# Description:
#  Shows random ASCII face
#
# Commands:
#   hubot face - Reply with random ASCII face

cool = require('cool-ascii-faces')

module.exports = (robot) ->
  robot.respond /face$/i, (msg) ->
    msg.send cool()

