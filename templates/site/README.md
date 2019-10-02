
# Data structure for ORB_CMS to build dynamic UI
  The inteface below shows how each widget, page, menu and more play together to create a dynamic view with the php twig template engine 

### A template file has a context containing the following

    
    * page u
    * widgets (local and global) 
    * menu 
      * internalmenu 
      * externalmenu 
    * link (the url path) 


# Page 
    page has the following structure during creation 
  ```php 
  // example way to use the page data 

    page["name"] 
    page["content"] 
    
  ```
* Page `{Any}`
  * Title `{String}`
  * Url `{String}`
  * Template (name of the file to render) `{String}`
  * Published (status to determine its visibility) `{Boolean}`
  * Publish Date (date to set the page as published) `{Time|String}`
  * Page Type (index|regular) (Page type - index can't be deleted) `{String}` 
  * Seo keywords `{String}`
  * Seo Description `{String}`
  * Linked widgets @Widget `{Array of widgets}` 
  * Unlinked widgets @Widget `{Array}` |not needed to build a UI|
  * Content (texts, images ... from the editor) `{String}` 

# Widget 
    (widgets) is composed of the following ( it is recursive, it is recommended to not use a deeply recursive widgets children )
  ```php 
  // example way to use the widgets available to a page ( key => Widget Value )
  return widgets["name"]
  // to access images in a widget 
  return widgets["name"]["images"]["url"]
  ```

* Widget `{Any}`
  * Name (name) `{String}`
  * Heading (heading) `{String}`
  * Scope (Local or Global) `{Integer}`
  * Image List (images) @Image`{Array of images}` 
  * Attributes 
    * Attribute1
    * Attribute2 
    * Attribute3
  * Content (texts, images ... from the editor) `{String}`
  * Children Widgets (children) @Widget `{Array of widgets}` 

# Image 
    Images are accessed using the filename of the image as a key

* Image `{Any}` 
  * Name (name, internal use) `{String}`
  * Url (url -- is same value as the filename) `{String}`
  * Size `{Integer}`

# Link 
    The path[0] of a given url path [ split with a ['/' delimiter ] ]
  
  * Link (link) `{String}` 


# External and Internal Menu
    The menu available to the CMS external eg. Social Media Links,
    and internal eg. Links that references a created page 

  * ExternalMenu (externalmenu) @Menu `{Array of menu}` 
  * InternalMenu (internalmenu) @Menu `{Array of menu}`


# Menu 
  
  * Menu 
    * Name (name) `{String}`
    * Url (url) `{String}`




| Tables | Are | Cool |
| ------ |:---:| ----:|
| col 3 is| right-aligned |$15000|
| col 2 is| is centerd | $12 |
| zebra stripes | are neat | $1 | 

