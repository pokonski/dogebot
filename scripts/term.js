// Description:
//   A way to define terms and print their definitions later.
//
// Commands:
//  add <term> <definition> - Add definition
//  <term> - Print randomly selected definition
//  describe <term> - List all definitions

function getDefinitions(robot, term) {
  var definitions = robot.brain.get('term-' + term);

  if (definitions !== null) {
    return JSON.parse(definitions);
  } else {
    return [];
  }
}

function addDefinition(robot, term, definition) {
  var definitions = getDefinitions(robot, term).concat(definition);
  robot.brain.set('term-' + term, JSON.stringify(definitions));
}

function getRandom(definitions) {
  return definitions[Math.floor(Math.random() * definitions.length)];
}

module.exports = function(robot) {
  robot.respond(/add (\S*) (.*)/i, function(msg) {
    var term = msg.match[1];
    var def  = msg.match[2];

    addDefinition(robot, term, def);
    msg.reply('Added definition for term "' + term + '"');
  });

  robot.respond(/describe (\S*).*/i, function(msg) {
    var term = msg.match[1];
    var defs = getDefinitions(robot, term).map(function(d) { return '- ' + d; });
    var r = ['I heard "' + term + '" is:'].concat(defs);
    msg.reply(r.join("\n"));
  });

  robot.respond(/(\S*).*/i, function(msg) {
    var term = msg.match[1];
    var defs = getDefinitions(robot, term);

    if (defs.length !== 0) {
      msg.reply(getRandom(defs));
    }
  });
}
