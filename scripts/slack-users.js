module.exports = function(robot) {
  robot.respond(/show users/i, function(msg) { ->
    var response = "";

    Object.keys(robot.brain.data.users).each(function(user) {
      response += user.id + ' ' + user.name + ' ' + user.email_address + "\n";
    });

    msg.send(response);
  });
}
