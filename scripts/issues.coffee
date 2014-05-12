# Description:
#   Shortcuts for linking GitHub issues
#
# Commands:
#   hubot repo users/repo - sets your default repo
#   hubot issues <number> - replies with a full URL to the issue
#

module.exports = (robot) ->

  robot.respond /repo (.+)\/(.+)/i, (msg) ->
    repo = "https://github.com/#{msg.match[1]}/#{msg.match[2]}"
    robot.brain.set "repo-#{msg.message.user.id}", repo
    msg.send "Setting repo to #{repo}"

  robot.respond /repo$/i, (msg) ->
    repo = robot.brain.get("repo-#{msg.message.user.id}")
    if repo
      msg.send "Your default repo is: #{repo}"
    else
      msg.send "You haven't set your default repository yet."

  robot.respond /i(ssue)? ([0-9]+)/i, (msg) ->
    repo = robot.brain.get("repo-#{msg.message.user.id}")
    issue = msg.match[2]
    console.log msg.match
    if repo
      msg.send "#{repo}/issues/#{issue}"
    else
      msg.send "Set your default repository with `repo` command."
