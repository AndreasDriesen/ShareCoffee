chai = require 'chai'
sinon = require 'sinon'
chai.should()

require '../src/ShareCoffee.CrossDomain'

root = global ? window

describe 'ShareCoffee.CrossDomain.SharePointRestProperties', ->

  it 'should be an constructor function', ->
    ShareCoffee.CrossDomain.should.have.property 'SharePointRestProperties'
    ShareCoffee.CrossDomain.SharePointRestProperties.should.be.an 'function'

  it 'should have required properties', ->
    sut = new ShareCoffee.CrossDomain.SharePointRestProperties()
    sut.should.have.property 'url'
    sut.should.have.property 'payload'
    sut.should.have.property 'hostWebUrl'
    sut.should.have.property 'eTag'
    sut.should.have.property 'onSuccess'
    sut.should.have.property 'onError'
