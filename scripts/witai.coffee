# Description:
#  Global natural language processing module
#

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
module.exports = (robot) ->
  robot.respond /! ?(.+)$/i, (msg) ->
    message = msg.envelope.message
    url = "https://api.wit.ai/message?q=#{encodeURIComponent(msg.match[1])}"
    robot.http(url)
      .header('Authorization', "Bearer #{process.env.WITAI_KEY}")
      .header('Accept', "application/vnd.wit.20140919")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        console.log data
        for outcome in data.outcomes
          if outcome.intent == "incorrect"
            msg.send msg.random(replies)
          if outcome.intent == "weather"
            console.log JSON.stringify(outcome.entities.location)
            message.text = "!weather #{outcome.entities.location.value}"
            robot.receive(message)
          if outcome.intent == "greetings"
            msg.send(msg.random(greetings))
          if outcome.intent == "remind"
            text = outcome.entities.reminder.body
            time = outcome.entities.datetime.body.replace("in ", "")
            if text && time
              message.text = "!remind me in #{time} to #{text}"
              robot.receive(message)
