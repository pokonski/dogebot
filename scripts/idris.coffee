# Description:
#   Evaluate one line of Idris
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot idris <script> - Evaluate one line of Idris
#
# Author:
#   puffnfresh

module.exports = (robot) ->
  robot.respond /(idr)\s+(.*)/i, (msg)->
    script = msg.match[2]

    msg.http("http://www.tryidris.org/interpret")
      .post(JSON.stringify {expression: script}) (err, res, body) ->
        switch res.statusCode
          when 200
            result = JSON.parse(body)
            msg.send result[0][1][1]
          else
            msg.send "Unable to evaluate script: #{script}. Request returned with the status code: #{res.statusCode}"