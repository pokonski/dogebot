# Description:
#  Shows organization leaderboard
#
# Commands:
#   hubot leaderboard - Show the list of users and their message counts on HipChat

cool = require('cool-ascii-faces')

module.exports = (robot) ->
  robot.respond /face$/i, (msg) ->
    msg.send cool()

