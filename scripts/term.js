// Description:
//   A way to define terms and print their definitions later.
//
// Commands:
//  add <term> <definition> - Add definition
//  <term> - Print randomly selected definition
//  describe <term> - List all definitions
//  terms - List all known terms


function getDefinitions(robot, term) {
  var terms = getTerms(robot);
  if (terms === undefined || terms === null)
    return [];

  var definitions = terms[term];

  if (definitions !== undefined) {
    return definitions;
  } else {
    return [];
  }
}

function setDefinitions(robot, term, definitions) {
  var terms = getTerms(robot);
  if (terms === undefined || terms === null)
    terms = {}

  if (definitions.length === 0) {
    delete terms[term];
  } else {
    terms[term] = definitions;
  }

  setTerms(robot, terms);
}

function addDefinition(robot, term, definition) {
  var definitions = getDefinitions(robot, term).concat(definition);
  setDefinitions(robot, term, definitions);
}

function removeDefinition(robot, term, index) {
  var definitions = getDefinitions(robot, term);
  definitions.splice(index, 1);
  setDefinitions(robot, term, definitions);
}

function getRandom(definitions) {
  return definitions[Math.floor(Math.random() * definitions.length)];
}

function getTerms(robot) {
  return robot.brain.get('terms');
}

function setTerms(robot, terms) {
  return robot.brain.set('terms', terms);
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
    var defs = getDefinitions(robot, term).map(function(d, i) { return '- [' + i + '] ' + d; });
    var r = ['I heard "' + term + '" is:'].concat(defs);
    msg.send(r.join("\n"));
  });

  robot.respond(/(\S*).*/i, function(msg) {
    var term = msg.match[1];
    var defs = getDefinitions(robot, term);

    if (defs.length !== 0) {
      msg.send(getRandom(defs));
    }
  });

  robot.respond(/remove (\S*) (\d*).*/i, function(msg) {
    var term = msg.match[1];
    var idx  = parseInt(msg.match[2]);

    if (robot.auth.isAdmin(msg.envelope.user)) {
      removeDefinition(robot, term, idx);
      msg.reply('Removed definition for term "' + term + '"');
    } else {
      msg.reply('Go away!');
    }
  });

  robot.respond(/terms.*/i, function(msg) {
    var terms = Object.keys(getTerms(robot)).map(function(t) { return '- ' + t; });
    var r = ['I heard about these things:'].concat(terms);
    msg.send(r.join("\n"));
  });
}
