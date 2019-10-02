/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For complete reference see:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	config.language = 'en';
	config.uiColor 	= '#f5f5f5';
	config.filebrowserBrowseUrl 	=	"/admin/filemanager";
	config.filebrowserUploadUrl		=	"/admin/filemanager";
	config.image_previewText 		=  	CKEDITOR.tools.repeat( '', 10 );
	config.image_removeLinkByEmptyURL = false;
	config.pasteFromWordNumberedHeadingToList = true;

  config.filebrowserWindowWidth = '50%';
  config.filebrowserWindowHeight = '50%';
  config.filebrowswerWindowPosition = 'center';
  // The toolbar groups arrangement, optimized for two toolbar rows.
	
	config.toolbarGroups = [
		
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup'] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'JustifyLeft' ] },
		{ name: 'styles' },
    { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing',     groups: [ 'find', 'selection' ] },
		{ name: 'links' },
		{ name: 'insert' },
		{ name: 'forms' },
		{ name: 'tools' },
		{ name: 'document',	   groups: [ 'document', 'doctools' ] },
		{ name: 'others' }
		// { name: 'colors' },
		// { name: 'about' }
	];


	// Remove some buttons provided by the standard plugins, which are
	// not needed in the Standard(s) toolbar.
	config.removeButtons = 'Subscript,Superscript';
	// Set the most common block elements.
	config.format_tags = 'p;h1;h2;h3;pre';

	config.extraPlugins 	= 'filebrowser,image2'; //slideshow,youtube';

	// Simplify the dialog windows.
	config.removeDialogTabs = 'image:advanced;link:advanced';
};
