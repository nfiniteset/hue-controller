{exec} = require "child_process"

REPORTER = "dot"

task "test", "run tests", ->
  exec "NODE_ENV=test ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --recursive
    --reporter #{REPORTER}
    --require coffee-script
    --require test/support/test_helper.coffee
    --colors
  ", (err, output) ->
    console.log output
    throw err if err