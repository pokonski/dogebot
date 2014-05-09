# Description:
#  Global natural language processing module
#


module.exports = (robot) ->
  robot.respond /! ?(.+)$/i, (msg) ->
    message = msg.envelope.message
    url = "https://api.wit.ai/message?q=#{encodeURIComponent(msg.match[1])}"
    robot.http(url)
      .header('Authorization', "Bearer #{process.env.WITAI_KEY}")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        console.log data
        if data.outcome.intent == "weather"
          console.log JSON.stringify(data.outcome.entities.location)
          message.text = "hubot weather #{data.outcome.entities.location.value}"
          robot.receive(message)


