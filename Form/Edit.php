<?php
class Invoice_Form_Edit extends Invoice_Form_Create
{
	public function init()
  {
    parent::init();
    $this->setTitle('Edit Invoice Entry')
    ->setDescription('Edit your entry below, then click "Post Entry".');
    
     // Element: submit

    $this->addElement('Button', 'submit', array(
            'label' => 'Post Entry',
            'type' => 'submit',
        ));
      $this->submit->setLabel('Save Changes');
  }
}
?>