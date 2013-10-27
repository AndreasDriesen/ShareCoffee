root = window ? global
root.ShareCoffee or = {}

root.ShareCoffee.RESTFactory = class
  constructor: (@method) ->
  
  jQuery: (url, options) =>
  angularJS: (url, options) =>
  reqwest: (url, options)=>

root.ShareCoffee.REST = class 

  @applicationType = "application/json;odata=verbose"

  @build = 
    create: 
      for: new ShareCoffee.RESTFactory 'POST'
    read: 
      for: new ShareCoffee.RESTFactory 'GET'
    update : 
      for: new ShareCoffee.RESTFactory 'POST'
    delete: 
      for: new ShareCoffee.RESTFactory 'DELETE'

  @buildGetRequest = (url) ->
    url: "#{ShareCoffee.Commons.getApiRootUrl()}#{url}", 
    type: "GET",
    headers:
      'Accepts' : ShareCoffee.REST.applicationType

  @buildDeleteRequest = (url) ->
    url :"#{ShareCoffee.Commons.getApiRootUrl()}#{url}",
    type: "DELETE",
    contentType: ShareCoffee.REST.applicationType,
    headers:
      'Accept': ShareCoffee.REST.applicationType,
      'If-Match': '*',
      'X-RequestDigest': ShareCoffee.Commons.getFormDigest()

  @buildUpdateRequest = (url, eTag, requestPayload) ->
    url: "#{ShareCoffee.Commons.getApiRootUrl()}#{url}",
    type: 'POST',
    contentType: ShareCoffee.REST.applicationType,
    headers:
      'Accept' : ShareCoffee.REST.applicationType,
      'X-RequestDigest': ShareCoffee.Commons.getFormDigest(),
      'X-HTTP-Method': 'MERGE',
      'If-Match': eTag
    data: requestPayload

  @buildCreateRequest = (url, requestPayload) ->
    url: "#{ShareCoffee.Commons.getApiRootUrl()}#{url}",
    type: 'POST',
    contentType: ShareCoffee.REST.applicationType,
    headers:
      'Accept': ShareCoffee.REST.applicationType,
      'X-RequestDigest' : ShareCoffee.Commons.getFormDigest()
    data: requestPayload
