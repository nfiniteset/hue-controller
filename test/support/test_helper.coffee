chai = require('chai')
spies = require('chai-spies')
chai.use(spies)

global.expect = chai.expect
global.MockLightGroup = require("./mock_light_group.coffee")
