root = window ? global

root.ShareCoffee or = {}

root.ShareCoffee.SettingsLink = (url, title, appendQueryStringToUrl = false) ->
  linkUrl: if appendQueryStringToUrl then "#{url}?#{ShareCoffee.Commons.getQueryString()}" else url
  displayName: title 

root.ShareCoffee.ChromeSettings = (iconUrl, title,helpPageUrl, settingsLinkSplat...) ->
  appIconUrl: iconUrl
  appTitle: title
  appHelpPageUrl: helpPageUrl
  settingsLinks: settingsLinkSplat

root.ShareCoffee.UI = class
  
  @showNotification = (message, isSticky = false) ->
    condition = () ->
      SP? and SP.UI? and SP.UI.Notify? and SP.UI.Notify.addNotification?
    
    ShareCoffee.Core.checkConditions "SP, SP.UI or SP.UI.Notify is not defined (check if core.js is loaded)", condition
    SP.UI.Notify.addNotification message, isSticky

  @removeNotification = (notificationId) ->
    return unless notificationId?
    condition = () ->
      SP? and SP.UI? and SP.UI.Notify? and SP.UI.Notify.removeNotification?

    ShareCoffee.Core.checkConditions "SP, SP.UI or SP.UI.Notify is not defined (check if core.js is loaded)", condition
    SP.UI.Notify.removeNotification notificationId

  @showStatus = (title, contentAsHtml, showOnTop = false, color = 'blue') ->
    condition = () ->
      SP? and SP.UI? and SP.UI.Status? and SP.UI.Status.addStatus? and SP.UI.Status.setStatusPriColor?
    
    ShareCoffee.Core.checkConditions "SP, SP.UI or SP.UI.Status is not defined! (check if core.js is loaded)", condition
    statusId = SP.UI.Status.addStatus title, contentAsHtml, showOnTop
    SP.UI.Status.setStatusPriColor statusId, color
    statusId

  @removeStatus = (statusId) ->
    return unless statusId?
    condition = () ->
      SP? and SP.UI? and SP.UI.Status? and SP.UI.Status.removeStatus? 
    
    ShareCoffee.Core.checkConditions "SP, SP.UI or SP.UI.Status is not defined! (check if core.js is loaded)", condition
    SP.UI.Status.removeStatus statusId

  @removeAllStatus = () ->
    condition = () ->
      SP? and SP.UI? and SP.UI.Status? and SP.UI.Status.removeAllStatus? 

    ShareCoffee.Core.checkConditions "SP, SP.UI or SP.UI.Status is not defined! (check if core.js is loaded)", condition
    SP.UI.Status.removeAllStatus()

  @setStatusColor = (statusId, color='blue') ->
    return unless statusId?
    condition = () ->
      SP? and SP.UI? and SP.UI.Status? and SP.UI.Status.setStatusPriColor? 

    ShareCoffee.Core.checkConditions "SP, SP.UI or SP.UI.Status is not defined! (check if core.js is loaded)", condition
    SP.UI.Status.setStatusPriColor statusId, color

  @onChromeLoadedCallback = null

  @loadAppChrome = (placeHolderId, chromeSettings, onAppChromeLoaded = undefined) ->
    if onAppChromeLoaded?
      ShareCoffee.UI.onChromeLoadedCallback = onAppChromeLoaded
      chromeSettings.onCssLoaded = "ShareCoffee.UI.onChromeLoadedCallback()"

    onScriptLoaded = () =>
      chrome = new SP.UI.Controls.Navigation placeHolderId, chromeSettings
      chrome.setVisible true

    scriptUrl = "#{ShareCoffee.Commons.getHostWebUrl()}/_layouts/15/SP.UI.Controls.js"

    ShareCoffee.Core.loadScript scriptUrl, onScriptLoaded, ()->
      throw "Error loading SP.UI.Controls.js"
    

