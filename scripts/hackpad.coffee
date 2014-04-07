# Description:
#   Search company Hackpad for pads
#
# Dependencies:
#   None
#
# Commands:
#   hackpad <query> - Return hackpads matching query
#
# Author:
#   Piotrek Okoński

Hackpad = require('hackpad');
site = "gorailsgo"

module.exports = (robot) ->
  robot.respond /hackpad (.+)/i, (msg) ->
    query = msg.match[1]
    client = new Hackpad(process.env.HACKPAD_CLIENT_ID, process.env.HACKPAD_TOKEN, {site: site})
    client.search query, 0, 3, (error, response) ->
      if response.length > 0
        for pad in response
          msg.send "#{pad.title} - http://#{site}.gorailsgo.com/#{pad.id}"
      else
        msg.send "No hackpads found!"