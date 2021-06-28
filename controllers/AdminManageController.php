<?php
class Invoice_AdminManageController extends Core_Controller_Action_Admin{
	public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('invoice_admin_main', array(), 'invoice_admin_main_manage');

    if ($this->getRequest()->isPost()) {
      $values = $this->getRequest()->getPost();
      foreach ($values as $key => $value) {
        if ($key == 'delete_' . $value) {
          $invoice = Engine_Api::_()->getItem('invoice', $value);
          $invoice->delete();
        }
      }
    }
}
}