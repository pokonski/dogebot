// Description:
//   A way to eval JS code
//
// Commands:
//  eval <code> - Eval code and return result
var util = require("util");

module.exports = function(robot) {
  robot.respond(/eval (.*)/i, function(msg) {
    var code = msg.match[1];

    if (robot.auth.isAdmin(msg.envelope.user)) {
      msg.send(util.inspect(eval(code)));
    } else {
      msg.reply('-EPERM');
    }
  });
}
