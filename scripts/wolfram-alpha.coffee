# Description:
#   Allows hubot to answer almost any question by asking Wolfram Alpha
#
# Dependencies:
#   "wolfram": "0.2.2"
#
# Configuration:
#   HUBOT_WOLFRAM_APPID - your AppID
#
# Commands:
#   hubot question <question> - Searches Wolfram Alpha for the answer to the question
#
# Notes:
#   This may not work with node 0.6.x
#
# Author:
#   dhorrigan

Wolfram = require('wolfram').createClient(process.env.HUBOT_WOLFRAM_APPID)

module.exports = (robot) ->
  robot.respond /(wolfram|wfa) (.*)$/i, (msg) ->
    console.log msg.match
    Wolfram.query msg.match[2], (e, results) ->
      console.log results
      console.log "-------"
      output = ""
      if results and results.length > 0
        for result in results
          if result.title == "Result"
            for subpod in result.subpods
              console.log subpod
              console.log "---"
              if subpod.value.length > 0
                output += subpod.value
              else
                output += subpod.image
              output += "\n"
        msg.send output
      else
        msg.send 'Hmm...not sure'
