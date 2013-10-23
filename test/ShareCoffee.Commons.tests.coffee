chai = require 'chai'
sinon = require 'sinon'
chai.should()

require '../src/ShareCoffee.Commons'
describe 'ShareCoffee.Commons', ->

  beforeEach () ->
    expected = webAbsoluteUrl : 'https://dotnetrocks.sharepoint.com'
    global._spPageContextInfo = expected
  
  afterEach () ->
    global._spPageContextInfo = undefined

  describe 'GetAppWebUrl', ->
  
    it 'should return proper AppWebUrl', ->
      ShareCoffee.Commons.getAppWebUrl().should.equal 'https://dotnetrocks.sharepoint.com'
  
    it 'should return an empty string if Context or webAbsoluteUrl arent present', ->
      global._spPageContextInfo = undefined
      ShareCoffee.Commons.getAppWebUrl().should.be.empty
  
    it "should print the error to the console if _spPageContextInfo isn't present", ->
      global._spPageContextInfo = undefined
      spy = sinon.spy console, "error"   
      ShareCoffee.Commons.getAppWebUrl()
      spy.calledWithExactly("_spPageContextInfo is not defined").should.be.ok
  
  describe 'GetApiRootUrl', ->
    
    it 'should return proper API root Url',->
      ShareCoffee.Commons.getApiRootUrl().should.equal "https://dotnetrocks.sharepoint.com/_api/"

  describe 'buildGetRequest', ->
    
    it 'should create a proper get request properties',->
      expected = 
        url : "https://dotnetrocks.sharepoint.com/_api/web/lists/?$Select=Title",
        type: "GET",
        headers: { 'Accepts' : 'application/json;odata=verbose'}
      ShareCoffee.Commons.buildGetRequest("web/lists/?$Select=Title").should.be.deep.equal expected
