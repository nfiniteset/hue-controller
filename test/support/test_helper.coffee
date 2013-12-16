chai = require('chai')
sinonChai = require('sinon-chai')
chai.use(sinonChai)

global.sinon = require('sinon')
global.expect = chai.expect
global.should = chai.should()
