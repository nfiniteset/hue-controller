'use strict'

assert = require("assert")
exec = require('child_process').exec
path = require('path')

describe 'hue-controller bin', ->
  cmd = "node #{path.join(__dirname, '../../bin/hue-controller')} "
  console.log(cmd)

  it '--help should run without errors', (done) ->
    exec cmd+'--help', (error, stdout, stderr) ->
      assert(!error)
      done()

  it '--version should run without errors', (done) ->
    exec cmd+'--version', (error, stdout, stderr) ->
      assert(!error)
      done()

  it 'should return error on missing command', (done) ->
    this.timeout(4000)

    exec cmd, (error, stdout, stderr) ->
      assert(error)
      assert.equal(error.code,1)
      done()

  it 'should return error on unknown command', (done) ->
    this.timeout(4000)

    exec cmd+'junkcmd', (error, stdout, stderr) ->
      assert(error)
      assert.equal(error.code,1)
      done()
