# Description:
#  Global natural language processing module
#

moment = require 'moment'

replies = [
  "That's nonsense!",
  "I don't know what this means.",
  "Now you are just making things up.",
  "I'm afraid I can't do that.",
  "I don't quite understand...",
  "Hmm?",
  "Say what?",
  "That doesn't ring a bell."
]

greetings = [
  "Ahoy",
  "G'day",
  "Good evening",
  "Good morning",
  "Good afternoon",
  "Greetings for the day",
  "Hello",
  "Hello there",
  "Hey",
  "Hi",
  "Hi there",
  "How are you?",
  "Thank You",
  "How are you doing?",
  "Howdy",
  "How's it going?",
  "How's it hanging?",
  "Salutations",
  "Sup",
  "Wazzup?",
  "What Doing?",
  "What's Poppin'"
]

class WitAI
  constructor: (robot, msg) ->
    @msg = msg
    @robot = robot
    @message = msg.envelope.message

  incorrect: ->
    @msg.send @msg.random(replies)

  weather: (outcome) ->
    @message.text = "!weather #{outcome.entities.location[0].value}"
    @robot.receive(@message)

  greetings: (outcome) ->
    @msg.send(@msg.random(greetings))

  remind: (outcome) ->
    text = outcome.entities.reminder[0].value
    time = outcome.entities.datetime[0].value.from
    time = Math.abs(parseInt((moment() - moment(time)) / 1000))

    if text && time
      @message.text = "!remind me in #{time} seconds to #{text}"
      @robot.receive(@message)

module.exports = (robot) ->
  robot.respond /! ?(.+)$/i, (msg) ->
    url = "https://api.wit.ai/message?q=#{encodeURIComponent(msg.match[1])}"
    robot.http(url)
      .header('Authorization', "Bearer #{process.env.WITAI_KEY}")
      .header('Accept', "application/vnd.wit.20140919")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        console.log body
        for outcome in data.outcomes
          wit = new WitAI(robot, msg)
          wit[outcome.intent](outcome)
