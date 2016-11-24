# CrxPackageManager::DefaultApi

All URIs are relative to *http://localhost:4502/crx/packmgr*

Method | HTTP request | Description
------------- | ------------- | -------------
[**list**](DefaultApi.md#list) | **GET** /list.jsp | List all available packages.


# **list**
> PackageList list(opts)

List all available packages.

Returns a list of all available packages defined.

### Example
```ruby
# load the gem
require 'crx_packmgr_api_client'
# setup authorization
CrxPackageManager.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = CrxPackageManager::DefaultApi.new

opts = { 
  q: "q_example", # String | Term to search within package names.
  include_versions: true, # BOOLEAN | Include versions of package in results.
  path: "path_example" # String | The path to a specific package definition.
}

begin
  #List all available packages.
  result = api_instance.list(opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->list: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**| Term to search within package names. | [optional] 
 **include_versions** | **BOOLEAN**| Include versions of package in results. | [optional] 
 **path** | **String**| The path to a specific package definition. | [optional] 

### Return type

[**PackageList**](PackageList.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: text/plain, text/html, application/json, application/xml



