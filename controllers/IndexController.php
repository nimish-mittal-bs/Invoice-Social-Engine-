<?php

class Invoice_IndexController extends Core_Controller_Action_Standard
{
  public function indexAction()
  {
    //$this->view->someVar = 'someVal';
    // Prepare data
        $viewer = Engine_Api::_()->user()->getViewer();
        // Permissions
        $this->view->canCreate = $this->_helper->requireAuth()->setAuthParams('invoice', null, 'create')->checkRequire();

        // Make form
        // Note: this code is duplicated in the invoice.browse-search widget
        $this->view->form = $form = new Invoice_Form_Search();

         // Process form
        $defaultValues = $form->getValues();
        if( $form->isValid($this->_getAllParams()) ) {
            $values = $form->getValues();
        } else {
            $values = $defaultValues;
        }
        $this->view->formValues = array_filter($values);

        // Get invoices
        $paginator = Engine_Api::_()->getItemTable('invoice')->getInvoicesPaginator($values)  ;

        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->invoice_page;
        $paginator->setItemCountPerPage($items_per_page);

        $this->view->paginator = $paginator->setCurrentPageNumber($this->_getParam('page'));

        if( !empty($values['category']) ) {
            $this->view->categoryObject = Engine_Api::_()->getDbtable('categories', 'invoice')
                ->find($values['category'])->current();
        }


  }

  public function manageAction()
  {
    if( !$this->_helper->requireUser()->isValid() ) return;
    // Render
        $this->_helper->content
            //->setNoRender()
            ->setEnabled()
        ;

        // Prepare data
    $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->form = $form = new Invoice_Form_Search();
    //print_r($this->getAllParams());
    // $this->view->canCreate = $this->_helper->requireAuth()->setAuthParams('invoice', null, 'create')->checkRequire();

    //process form
    $defaultValues = $form->getValues();
        if( $form->isValid($this->_getAllParams()) ) {
            $values = $form->getValues();
        } else {
            $values = $defaultValues;
        }
        $this->view->formValues = array_filter($values);
        $values['user_id'] = $viewer->getIdentity();

        print_r($values);
        // die;
        // Get paginator
        $this->view->paginator = $paginator = Engine_Api::_()->getItemTable('invoice')->getInvoicesPaginator($values);

        $items_per_page=Engine_Api::_()->getApi('settings', 'core')->invoice_page;
        $paginator->setItemCountPerPage($items_per_page);
        $this->view->paginator = $paginator->setCurrentPageNumber($this->_getParam('page')); 

  }
  public function createAction()
  {
    if( !$this->_helper->requireUser()->isValid() ) return;
    //if( !$this->_helper->requireAuth()->setAuthParams('invoice', null, 'create')->isValid()) return;
    $this->view->form = $form = new Invoice_Form_Create();
    
 	// Process
    if (!$this->getRequest()->isPost()) {
      return;
    }

    if (!$form->isValid($this->getRequest()->getPost())) {
      return;
    }


    $data=$this->getRequest()->getPost();
    $table = Engine_Api::_()->getItemTable('invoice_product');
    $db = $table->getAdapter();
    $db->beginTransaction();

        $category_id=$data['category_id'];
    $invoice_number = Engine_Api::_()->getItemTable('invoice')->getInvoiceNumber($category_id);
    
    try {
      $viewer = Engine_Api::_()->user()->getViewer();
      //$formValues = $form->getValues();

    
      for($i=1;$i<=$data['hidden'];$i++){
        if(!empty($data['p_name'.$i])){
          $product = $table->createRow();
          $product->invoice_id=$invoice_number;
          $product->description=$data['p_name' .$i];
          $product->quantity=$data['quantity'.$i];
          $product->price=$data['price' . $i];
          $product->amount=$data['total'.$i];
          $product->save();
        }
      }
    // Commit
      $db->commit();
    } catch( Exception $e ) {
        return $this->exceptionWrapper($e, $form, $db);
    }

    $table = Engine_Api::_()->getItemTable('invoice');

    $db = $table->getAdapter();

    $db->beginTransaction();
    
   try {
      $formValues = $form->getValues();
    
    $values = array_merge($formValues, array(
                'owner_type' => $viewer->getType(),
                'owner_id' => $viewer->getIdentity(),
                'view_privacy' => $formValues['auth_view'],
    ));

    //mobile number
    // $regex =  "/^(\+\d{1,3}[- ]?)?\d{10}$/";

    //     $mobile = $values['number'];
    //    $isValid = preg_match($regex,$mobile);

    //     if(!$isValid) return $form->addError('Mobile is not valid');

    // Create a new row
    $invoice = $table->createRow();
    // Get all the values
    
    $invoice->date=date("d/m/Y") ;
    $invoice->invoice_number=$invoice_number;
    
    $invoice->owner_type=$values['owner_type'];

    $invoice->owner_id=$values['owner_id'];

    $invoice->receiver=$values['receiver'];
    
    $invoice->category_id=$values['category_id'];
    $invoice->address=$values['address'];
    $invoice->contact_no=$values['contact_no'];

    $invoice->email=$values['email'];
    
    $invoice->currency=$values['currency'];
   $invoice->CGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.cgst', 18);
   $invoice->SGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.sgst', 18);
   $invoice->IGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.igst', 18);
 
    $invoice->sub_total=$values['sub_total'];
    $invoice->discount=$values['discount'];
    $invoice->total=$values['total'];
    $invoice->modified_date="";
    $invoice->status=$values['status'];
    
    $invoice->save();
    
        // Commit
            $db->commit();
    } catch( Exception $e ) {
        return $this->exceptionWrapper($e, $form, $db);
    }
      return $this->_helper->redirector->gotoRoute(array('action' => 'create'));
  }

  public function editAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $invoice = Engine_Api::_()->getItem('invoice', $this->getRequest()->getParam('invoice_id'));
    
    $this->view->invoice_details = $invoice->toArray();
    $this->view->invoice_number = $invoice['invoice_number'];
    // Prepare form
    $this->view->form = $form = new Invoice_Form_Edit();
    
    // Populate form
    $form->populate($invoice->toArray());
    
    // Process
    if (!$this->getRequest()->isPost()) {
      return;
    }

    if (!$form->isValid($this->getRequest()->getPost())) {
      return;
    }


    $data=$this->getRequest()->getPost();
    $table = Engine_Api::_()->getItemTable('invoice_product');
    $db = $table->getAdapter();
    $db->beginTransaction();
    

    try {
      $viewer = Engine_Api::_()->user()->getViewer();
      //$formValues = $form->getValues();

    
      for($i=1;$i<=$data['hidden'];$i++){
        if(!empty($data['p_name'.$i])){
          $product->description=$data['p_name' .$i];
          $product->quantity=$data['quantity'.$i];
          $product->price=$data['price' . $i];
          $product->amount=$data['total'.$i];
          $product->save();
        }
      }
    // Commit
      $db->commit();
    } catch( Exception $e ) {
        return $this->exceptionWrapper($e, $form, $db);
    }

    $table = Engine_Api::_()->getItemTable('invoice');

    $db = $table->getAdapter();

    $db->beginTransaction();
    
   try {
      $formValues = $form->getValues();
    
    $values = array_merge($formValues, array(
                'owner_type' => $viewer->getType(),
                'owner_id' => $viewer->getIdentity(),
                'view_privacy' => $formValues['auth_view'],
    ));     
    // Get all the values
    
    $invoice->date=date("d/m/Y") ;
    
    $invoice->owner_type=$values['owner_type'];

    $invoice->owner_id=$values['owner_id'];

    $invoice->receiver=$values['receiver'];
    
    $invoice->category_id=$values['category_id'];
    $invoice->address=$values['address'];
    $invoice->contact_no=$values['contact_no'];

    $invoice->email=$values['email'];
    
    $invoice->currency=$values['currency'];
$invoice->CGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.cgst', 18);
   $invoice->SGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.sgst', 18);
   $invoice->IGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.igst', 18);
 
    $invoice->sub_total=$values['sub_total'];
    $invoice->discount=$values['discount'];
    $invoice->total=$values['total'];
    $invoice->modified_date=date("d/m/Y");

    $invoice->status=$values['status'];
    
    $invoice->save();
    
    // Commit
            $db->commit();
    } catch( Exception $e ) {
        return $this->exceptionWrapper($e, $form, $db);
    }
    
   
        // return $this->_helper->redirector->gotoRoute(array('action' => 'manage'));
}

    public function viewAction()
    {   

        // Check permission
        $viewer = Engine_Api::_()->user()->getViewer();
        $invoice = Engine_Api::_()->getItem('invoice', $this->_getParam('invoice_id'));

        

        // Prepare data
        $invoiceTable = Engine_Api::_()->getDbtable('invoices', 'invoice');
        // if (strpos($invoice->body, '<') === false) {
        //     $invoice->body = nl2br($invoice->body);
        // }

        $this->view->invoice_details = $invoice->toArray();
        $this->view->invoice_number = $invoice['invoice_number'];
        // print_r($a);
        // die;
        $this->view->viewer = $viewer;
        // Get category
        if( !empty($invoice->category_id) ) {
            $this->view->category = Engine_Api::_()->getDbtable('categories', 'invoice')
                ->find($invoice->category_id)->current();
        }
    }
  
  // if( !$this->_helper->requireAuth()->setAuthParams('bill', null, 'view')->isValid()) return;

  // $bill = Engine_Api::_()->getItem('bill', $this->_getParam('bill_id'));
  //         // print_r($bill->toArray());
  //         // die();
  // $this->view->bill_details = $bill->toArray();
  // $this->view->$bill_number = $bill['bill_number'];

  public function deleteAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $invoice = Engine_Api::_()->getItem('invoice', $this->getRequest()->getParam('invoice_id'));
    
        // In smoothbox
        $this->_helper->layout->setLayout('default-simple');

        $this->view->form = $form = new Invoice_Form_Delete();

        if( !$invoice ) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invoice entry doesn't exist or not authorized to delete");
            return;
        }

        if( !$this->getRequest()->isPost() ) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid request method');
            return;
        }

        $db = $invoice->getTable()->getAdapter();
        $db->beginTransaction();

        try {
            $invoice->delete();

            $db->commit();
        } catch( Exception $e ) {
            $db->rollBack();
            throw $e;
        }

        $this->view->status = true;
        $this->view->message = Zend_Registry::get('Zend_Translate')->_('Your invoice entry has been deleted.');
        return $this->_forward('success' ,'utility', 'core', array(
            'parentRedirect' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'manage'), 'invoice_general', true),
            'messages' => Array($this->view->message)
        ));


  }
}


