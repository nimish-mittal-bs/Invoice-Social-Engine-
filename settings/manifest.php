<?php 
  return array (
  'package' => 
  array (
    'type' => 'module',
    'name' => 'invoice',
    'version' => '5.0.0',
    'path' => 'application/modules/Invoice',
    'title' => 'Invoice',
    'description' => 'Invoice',
    'author' => 'Nimish',
    
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'enable',
      4 => 'disable',
    ),
     'callback' => array(
      'path' => 'application/modules/Invoice/settings/install.php',
      'class' => 'Invoice_Installer',
    ),
    'directories' => 
    array (
      0 => 'application/modules/Invoice',
    ),
    'files' => 
    array (
      0 => 'application/languages/en/invoice.csv',
    ),
  ),
  // Items ---------------------------------------------------------------------
  'items' => array(
    'invoice','invoice_product',
    'invoice_category','invoice_value',
  ),

  // Hooks ---------------------------------------------------------------------
  'hooks' => array(
    array(
      'event' => 'onUserDeleteBefore',
      'resource' => 'Invoice_Plugin_Core',
    ),
  ),

  // Routes --------------------------------------------------------------------
  'routes' => array(
    // Public
    'invoice_specific' => array(
      'route' => 'invoices/:action/:invoice_id/*',
      'defaults' => array(
        'module' => 'invoice',
        'controller' => 'index',
        'action' => 'index',
      ),
      'reqs' => array(
        'invoice_id' => '\d+',
        'action' => '(delete|edit|view)',
      ),
    ),
    'invoice_general' => array(
      'route' => 'invoices/:action/*',
      'defaults' => array(
        'module' => 'invoice',
        'controller' => 'index',
        'action' => 'index',
      ),
      'reqs' => array(
        'action' => '(index|create|manage)',
      ),
    ),
    // 'invoice_view' => array(
    //   'route' => 'invoices/:user_id/*',
    //   'defaults' => array(
    //     'module' => 'invoice',
    //     'controller' => 'index',
    //     'action' => 'list',
    //   ),
    //   'reqs' => array(
    //     'user_id' => '\d+',
    //   ),
    // ),
    // 'invoice_entry_view' => array(
    //   'route' => 'invoices/:user_id/:invoice_id/:slug',
    //   'defaults' => array(
    //     'module' => 'invoice',
    //     'controller' => 'index',
    //     'action' => 'view',
    //     'slug' => '',
    //   ),
    //   'reqs' => array(
    //     'user_id' => '\d+',
    //     'invoice_id' => '\d+'
    //   ),
    // ),
  ),
); ?>