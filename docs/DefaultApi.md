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
[**service**](DefaultApi.md#service) | **GET** /service.jsp | Generic operation service.
[**thumbnail**](DefaultApi.md#thumbnail) | **GET** /thumbnail.jsp | Get package thumbnail
[**update**](DefaultApi.md#update) | **POST** /update.jsp | Update a package


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
  include_all: true, # BOOLEAN | Return a total count of all packages. Default to false.
  include_root: true, # BOOLEAN | Include the root package. Defaults to false.
  include_my_packages: true, # BOOLEAN | Include the 'my_packages' group. Only applicable if the group has no packages. Default to false.
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
 **include_all** | **BOOLEAN**| Return a total count of all packages. Default to false. | [optional] 
 **include_root** | **BOOLEAN**| Include the root package. Defaults to false. | [optional] 
 **include_my_packages** | **BOOLEAN**| Include the &#39;my_packages&#39; group. Only applicable if the group has no packages. Default to false. | [optional] 
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



# **service**
> String service(cmd, opts)

Generic operation service.

Provides endpoint for

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
  strict: true # BOOLEAN | Fail on an error
}

begin
  #Generic operation service.
  result = api_instance.service(cmd, opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cmd** | **String**| The command to execute. | 
 **name** | **String**| The name of the package on which to execute the command. | [optional] 
 **group** | **String**| The group of the package on which to execute the command. | [optional] 
 **strict** | **BOOLEAN**| Fail on an error | [optional] 

### Return type

**String**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/zip, text/plain



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



# **update**
> String update(path, package_name, opts)

Update a package

Updates a package definition. Returns an UpdateStatus definition, but must be manually parsed due to MIME type incompatibilities. Note that if the name, group or version changes, this changes the path to the package for the next update or listing.

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

path = "path_example" # String | The path to the package which needs updating.

package_name = "package_name_example" # String | The package's name.

opts = { 
  group_name: "group_name_example", # String | The package's group.
  version: "version_example", # String | The version for the package.
  description: "description_example", # String | The description for the package.
  thumbnail: File.new("/path/to/file.txt"), # File | The thumbnail for the package.
  filter: "filter_example", # String | The filters for the package. The structure is specified in FilterData definition.
  tested_with: "tested_with_example", # String | Product name and version this package is targeted for or is compatible with. eg: CQ 5.3
  fixed_bugs: "fixed_bugs_example", # String | List of fixed bugs or issues.
  dependencies: ["dependencies_example"], # Array<String> | Packages on which this one depends.
  replaces: ["replaces_example"], # Array<String> | List of packages this one replaces.
  provider_name: "provider_name_example", # String | Name of the provider. eg: Adobe Systems Incorporated
  provider_url: "provider_url_example", # String | URL of the provider. eg: http://www.adobe.com
  provider_link: "provider_link_example", # String | Package specific link to a provider page. eg: http://www.adobe.com/mypackage.html
  requires_root: true, # BOOLEAN | Specifies if this package requires root to install.
  requires_restart: true, # BOOLEAN | Specifies if this package requires a restart upon installation.
  ac_handling: "ac_handling_example", # String | How to handle ACL rules when installing the package.
  screenshot: File.new("/path/to/file.txt"), # File | Screen shot images for this package
  screenshot_config: "screenshot_config_example" # String | Configuration details for existing screenshots. The structure is specified in ScreenshotConfig definition.
}

begin
  #Update a package
  result = api_instance.update(path, package_name, opts)
  p result
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->update: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **path** | **String**| The path to the package which needs updating. | 
 **package_name** | **String**| The package&#39;s name. | 
 **group_name** | **String**| The package&#39;s group. | [optional] 
 **version** | **String**| The version for the package. | [optional] 
 **description** | **String**| The description for the package. | [optional] 
 **thumbnail** | **File**| The thumbnail for the package. | [optional] 
 **filter** | **String**| The filters for the package. The structure is specified in FilterData definition. | [optional] 
 **tested_with** | **String**| Product name and version this package is targeted for or is compatible with. eg: CQ 5.3 | [optional] 
 **fixed_bugs** | **String**| List of fixed bugs or issues. | [optional] 
 **dependencies** | [**Array&lt;String&gt;**](String.md)| Packages on which this one depends. | [optional] 
 **replaces** | [**Array&lt;String&gt;**](String.md)| List of packages this one replaces. | [optional] 
 **provider_name** | **String**| Name of the provider. eg: Adobe Systems Incorporated | [optional] 
 **provider_url** | **String**| URL of the provider. eg: http://www.adobe.com | [optional] 
 **provider_link** | **String**| Package specific link to a provider page. eg: http://www.adobe.com/mypackage.html | [optional] 
 **requires_root** | **BOOLEAN**| Specifies if this package requires root to install. | [optional] 
 **requires_restart** | **BOOLEAN**| Specifies if this package requires a restart upon installation. | [optional] 
 **ac_handling** | **String**| How to handle ACL rules when installing the package. | [optional] 
 **screenshot** | **File**| Screen shot images for this package | [optional] 
 **screenshot_config** | **String**| Configuration details for existing screenshots. The structure is specified in ScreenshotConfig definition. | [optional] 

### Return type

**String**

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: text/html



