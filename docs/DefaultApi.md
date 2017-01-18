# CrxPackageManager::DefaultApi

All URIs are relative to *http://localhost:4502/crx/packmgr*

Method | HTTP request | Description
------------- | ------------- | -------------
[**download**](DefaultApi.md#download) | **GET** /download.jsp | Download a package
[**groups**](DefaultApi.md#groups) | **GET** /groups.jsp | List package groups
[**init**](DefaultApi.md#init) | **GET** /init.jsp | Metadata
[**installstatus**](DefaultApi.md#installstatus) | **GET** /installstatus.jsp | Package Installation Status
[**list**](DefaultApi.md#list) | **GET** /list.jsp | List packages
[**screenshot**](DefaultApi.md#screenshot) | **GET** /screenshot.jsp | Get screenshot
[**service_exec**](DefaultApi.md#service_exec) | **POST** /service/exec.json/etc/packages/{group}/{name}-{version}.zip | Generic operation service.
[**service_get**](DefaultApi.md#service_get) | **GET** /service.jsp | Generic operation service.
[**service_post**](DefaultApi.md#service_post) | **POST** /service.jsp | Generic operation service.
[**thumbnail**](DefaultApi.md#thumbnail) | **GET** /thumbnail.jsp | Get package thumbnail


# **download**
> File download(opts)

Download a package

Downloads the package at the specified path. Returns a Tempfile object.

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
  path: "path_example" # String | The path to the package to download.
}

begin
  #Download a package
  result = api_instance.download(opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->download: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **path** | **String**| The path to the package to download. | [optional] 

### Return type

**File**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/zip



# **groups**
> GroupList groups(opts)

List package groups

Returns a list of all package groups available.

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
  compress_version: "compress_version_example", # String | Compress versions; count all versions of the same packages as a single entry.
  include_all: true, # BOOLEAN | Return a total count of all packages. Defaults to false.
  include_root: true, # BOOLEAN | Include the root package. Defaults to false.
  include_my_packages: true, # BOOLEAN | Include the 'my_packages' group. Only applicable if the group has no packages. Defaults to false.
  only_top_level: true # BOOLEAN | Only list top-level groups, ie. do not list all nested groups.
}

begin
  #List package groups
  result = api_instance.groups(opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->groups: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **compress_version** | **String**| Compress versions; count all versions of the same packages as a single entry. | [optional] 
 **include_all** | **BOOLEAN**| Return a total count of all packages. Defaults to false. | [optional] 
 **include_root** | **BOOLEAN**| Include the root package. Defaults to false. | [optional] 
 **include_my_packages** | **BOOLEAN**| Include the &#39;my_packages&#39; group. Only applicable if the group has no packages. Defaults to false. | [optional] 
 **only_top_level** | **BOOLEAN**| Only list top-level groups, ie. do not list all nested groups. | [optional] 

### Return type

[**GroupList**](GroupList.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **init**
> InitData init

Metadata

Display metadata about this package manager.

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

begin
  #Metadata
  result = api_instance.init
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->init: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InitData**](InitData.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **installstatus**
> InstallStatus installstatus

Package Installation Status

Returns a status of the installation of OSGi packages.

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

begin
  #Package Installation Status
  result = api_instance.installstatus
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->installstatus: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InstallStatus**](InstallStatus.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list**
> PackageList list(opts)

List packages

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
  #List packages
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

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **screenshot**
> File screenshot(opts)

Get screenshot

Returns the screenshot at the specified path.

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
  path: "path_example" # String | The path to the screenshot.
}

begin
  #Get screenshot
  result = api_instance.screenshot(opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->screenshot: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **path** | **String**| The path to the screenshot. | [optional] 

### Return type

**File**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/jpg, image/jpeg, image/png



# **service_exec**
> ServiceExecResponse service_exec(cmd, name, group, version)

Generic operation service.

Provides a different API for executing package manipulation commands. Operates on a specific version of the package.

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

cmd = "cmd_example" # String | The command to execute.

name = "name_example" # String | The name of the package on which to execute the command.

group = "group_example" # String | The group of the package on which to execute the command.

version = "version_example" # String | The version of the package on which to execute the command.


begin
  #Generic operation service.
  result = api_instance.service_exec(cmd, name, group, version)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_exec: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cmd** | **String**| The command to execute. | 
 **name** | **String**| The name of the package on which to execute the command. | 
 **group** | **String**| The group of the package on which to execute the command. | 
 **version** | **String**| The version of the package on which to execute the command. | 

### Return type

[**ServiceExecResponse**](ServiceExecResponse.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **service_get**
> String service_get(cmd, opts)

Generic operation service.

Provides endpoint for executing package manipulation commands. Responses are in the format of the ServiceResponse in the defintions section.

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

cmd = "cmd_example" # String | The command to execute.

opts = { 
  name: "name_example", # String | The name of the package on which to execute the command.
  group: "group_example", # String | The group of the package on which to execute the command.
  strict: true # BOOLEAN | Fail on an error.
}

begin
  #Generic operation service.
  result = api_instance.service_get(cmd, opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cmd** | **String**| The command to execute. | 
 **name** | **String**| The name of the package on which to execute the command. | [optional] 
 **group** | **String**| The group of the package on which to execute the command. | [optional] 
 **strict** | **BOOLEAN**| Fail on an error. | [optional] 

### Return type

**String**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/zip, text/plain



# **service_post**
> String service_post(file, opts)

Generic operation service.

Provides endpoint for executing package manipulation commands. Responses are in the format of the ServiceResponse in the defintions section.

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

file = File.new("/path/to/file.txt") # File | Package file to upload

opts = { 
  name: "name_example", # String | The hint for the package's name if the definiton doesn't have one.
  strict: true, # BOOLEAN | Fail on an error.
  force: true, # BOOLEAN | Force the package upload.
  install: true # BOOLEAN | Install the package upon upload
}

begin
  #Generic operation service.
  result = api_instance.service_post(file, opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_post: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **File**| Package file to upload | 
 **name** | **String**| The hint for the package&#39;s name if the definiton doesn&#39;t have one. | [optional] 
 **strict** | **BOOLEAN**| Fail on an error. | [optional] 
 **force** | **BOOLEAN**| Force the package upload. | [optional] 
 **install** | **BOOLEAN**| Install the package upon upload | [optional] 

### Return type

**String**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined



# **thumbnail**
> File thumbnail(opts)

Get package thumbnail

Returns the package's thumbnail image.

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
  path: "path_example" # String | The path to the package.
}

begin
  #Get package thumbnail
  result = api_instance.thumbnail(opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->thumbnail: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **path** | **String**| The path to the package. | [optional] 

### Return type

**File**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/jpg, image/jpeg, image/png



