<?php
class Invoice_Model_DbTable_Invoices extends Core_Model_Item_DbTable_Abstract{

	public function getInvoicesSelect($params = array())
    {
    $viewer = Engine_Api::_()->user()->getViewer();

    $viewerId = $viewer->getIdentity();


    $table = Engine_Api::_()->getDbtable('invoices', 'invoice');
    $rName = $table->info('name');

    // if($params['all'])
    //     return $table->select()->order(!empty($params['orderby'])
    //         ? $rName.'.'.$params['orderby'].' DESC': $rName.'invoice_id DESC');


    $select = $table->select()
    ->where("owner_id = ?",$viewerId);           

     return $select;
    }

	 public function getInvoicesPaginator($params = array())
    {
        $paginator = Zend_Paginator::factory($this->getInvoicesSelect($params));
        if( !empty($params['page']) )
        {
            $paginator->setCurrentPageNumber($params['page']);
        }
        if( !empty($params['limit']) )
        {
            $paginator->setItemCountPerPage($params['limit']);
        }

        if( empty($params['limit']) )
        {
            $page = (int) Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.page', 10);
            $paginator->setItemCountPerPage($page);
        }
        return $paginator;
    }


    private function getNumber($invoice_number,$category_id){
        //broke the invoice number
        //$abc=strval($invoice_number); 
        //$abc=$invoice_number;
        // $temp_invoice = $invoice_number;
        // print_r($invoice_number);
        // die;
        $arr = explode("|",$invoice_number['invoice_number']);
        // var_dump($arr);
        // die;
        $stEndAr = explode('|',$arr[2]);
        $start = $stEndAr[0];
        $yearArr =explode('-',$start);
        $d_year=$yearArr[0];
        $d_id=$arr[0];

        $id=$d_id+1;
        // print_r($arr);
        // die;
        $id=str_pad($id,4,"0",STR_PAD_LEFT); 

        //to find year and month
        $cur_year = date("y");
        $cur_month=date('m');
        if ($cur_month>=4)
        {
            $nex_year=$cur_year+1;
            $year=$cur_year.'-'.$nex_year;
        }else{
            $pre_year=$cur_year-1;
            $year=$pre_year."-".$cur_year;
        }
        $table = Engine_Api::_()->getDbtable('categories', 'invoice');
        $stmt=$table->select()
                ->from($table, 'category_name')
                ->where('category_id=?',$category_id)
                ->query();
        $d_category=$stmt->fetch();
        $category=$d_category['category_name'];
        //print_r($category);
        $invoice_number=$id.'|'.$category.'|'.$year;

        return $invoice_number;
        
        

        // xxxx|name|year
    }

	public function getInvoiceNumber($category_id)
    {
        $viewer = Engine_Api::_()->user()->getViewer();
	    $viewerId = $viewer->getIdentity();
	    $table = Engine_Api::_()->getDbtable('invoices', 'invoice');
		
	     $stmt = $this->select()
		     	->from($this, array('Max(invoice_id) as id'))
		     	->where('category_id=?',$category_id) 
		    	->query();
		    	$id = $stmt->fetch();

                $stmt = $this->select()
                ->from($this,array('invoice_number'))
                ->where('invoice_id = ?',$id)
                ->query();

                $invoice_number = $stmt->fetch();
                


                return $this->getNumber($invoice_number, $category_id);

		  //   	echo "<pre>";
	   //  		print_r($stmt);
	   // AND (('right(Value,5)=?' $year))




	    
    }

}
?>
