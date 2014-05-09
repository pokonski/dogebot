# Description:
#  Global natural language processing module
#


module.exports = (robot) ->
  robot.respond /w (.+)$/i, (msg) ->
    msg.send "1"
    m = new TextMessage(message.user, "hubot help", message.id)
    msg.send "2"
    robot.receive(m)
    msg.send "3"


