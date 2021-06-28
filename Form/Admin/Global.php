<?php
class Invoice_Form_Admin_Global extends Engine_Form
{
  public function init()
  {

    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');

    $this->addElement('Text', 'invoice_page', array(
      'label' => 'Entries Per Page',
      'description' => 'How many invoice entries will be shown per page? (Enter a number between 1 and 999)',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.page', 10),
    ));

      $this->addElement('Radio', 'invoice_allow_unauthorized', array(
          'label' => 'Make unauthorized invoices searchable?',
          'description' => 'Do you want to make a unauthorized invoices searchable? (If set to no, invoices that are not authorized for the current user will not be displayed in the invoice search results and widgets.)',
          'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.allow.unauthorized',0),
          'multiOptions' => array(
              '1' => 'Yes',
              '0' => 'No',
          ),
      ));
    
     $this->addElement('Text', 'invoice_cgst', array(
      'label' => 'CGST%',
   	  'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.cgst', 18),
    ));

     $this->addElement('Text', 'invoice_sgst', array(
      'label' => 'SGST%',
   	  'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.sgst', 18),
    ));

     $this->addElement('Text', 'invoice_igst', array(
      'label' => 'IGST%',
   	  'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.igst', 18),
    ));
     
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}

?>