<?php
class Invoice_Model_Invoice extends Core_Model_Item_Abstract{
	public function getHref($params = array())
    {
        $slug = $this->getSlug();

        $params = array_merge(array(
            'route' => 'invoice_entry_view',
            'reset' => true,
            'user_id' => $this->owner_id,
            'invoice_id' => $this->invoice_id,
            'slug' => $slug,
        ), $params);
        $route = $params['route'];
        $reset = $params['reset'];
        unset($params['route']);
        unset($params['reset']);
        return Zend_Controller_Front::getInstance()->getRouter()
            ->assemble($params, $route, $reset);
    }
}
?>