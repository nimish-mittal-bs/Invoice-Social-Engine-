<?php
class Invoice_Installer extends Engine_Package_Installer_Module
{

    public function onInstall()
    {
        $db = $this->getDb();
        if($this->_databaseOperationType != 'upgrade'){
            $this->_addInvoiceIndexPage();

        }
        // $this->_addPrivacyColumn();
        parent::onInstall();
    }

    protected function _addInvoiceIndexPage()
    {
        $db = $this->getDb();

        // profile page
        $pageId = $db->select()
            ->from('engine4_core_pages', 'page_id')
            ->where('name = ?', 'invoice_index_manage')
            ->limit(1)
            ->query()
            ->fetchColumn();

        // insert if it doesn't exist yet
        if( !$pageId ) {
            // Insert page
            $db->insert('engine4_core_pages', array(
                'name' => 'invoice_index_manage',
                'displayname' => 'Invoice',
                'title' => 'Invoice',
                'description' => 'This page lists a user\'s invoice entries.',
                'custom' => 0,
            ));
            $pageId = $db->lastInsertId();

     

            // Insert main-middle
            $db->insert('engine4_core_content', array(
                'type' => 'container',
                'name' => 'middle',
                'page_id' => $pageId,
                'parent_content_id' => $mainId,
                'order' => 2,
            ));
            $mainMiddleId = $db->lastInsertId();

            // Insert main-right
            $db->insert('engine4_core_content', array(
                'type' => 'container',
                'name' => 'right',
                'page_id' => $pageId,
                'parent_content_id' => $mainId,
                'order' => 1,
            ));
            $mainRightId = $db->lastInsertId();

            

            // Insert content
            $db->insert('engine4_core_content', array(
                'type' => 'widget',
                'name' => 'core.content',
                'page_id' => $pageId,
                'parent_content_id' => $mainMiddleId,
                'order' => 1,
            ));

            // Insert search
            $db->insert('engine4_core_content', array(
                'type' => 'widget',
                'name' => 'invoice.browse-search',
                'page_id' => $pageId,
                'parent_content_id' => $mainRightId,
                'order' => 1,
            ));

           
        }
    }


    
}
?>