<?php
	class Invoice_Form_Create extends Engine_Form{
		public function init(){
			$this->setTitle('Write New Entry')
            ->setDescription('Compose your new Invoice entry below, then click "Post Entry".')
            ->setAttrib('name', 'invoices_create');
            
            //Name
            $this->addElement('Text', 'receiver', array(
            'label' => 'Name(Bill to):',
            'allowEmpty' => false,
            'required' => true,
            'maxlength' => '40',
            'filters' => array(
                new Engine_Filter_Censor(),
                'StripTags',
                new Engine_Filter_StringLength(array('max' => '40'))
            ),
            'autofocus' => 'autofocus',
        ));
        // Address
        $this->addElement('Text', 'address', array(
            'label' => 'Address:',
            'allowEmpty' => false,
            'required' => true,
            'maxlength' => '63',
            'filters' => array(
                new Engine_Filter_Censor(),
                'StripTags',
                new Engine_Filter_StringLength(array('max' => '63'))
            ),
        ));

        // prepare categories
        $categories = Engine_Api::_()->getDbtable('categories', 'invoice')->getCategoriesAssoc();
        if( count($categories) > 0 ) {
            $this->addElement('Select', 'category_id', array(
                'label' => 'Category',
                'multiOptions' => $categories,
            ));
        }

        //Mobile
        $this->addElement('Text', 'contact_no', array(
            'label' => 'Contact Number:',
            'id'=>'phonenum',
            'allowEmpty' => false,
            'required' => true,
            'onfocusout'=>'phonenumber()',
        ));
		//Email
		$this->addElement('Text', 'email', array(
            'label' => 'Email:',
            'id'=>'emailid',
            //'inputtype'=>'email',
            'allowEmpty' => false,
            'required' => true,
            'onfocusout'=>'ValidateEmail()',
        ));

        $this->addElement('Button', 'add_product', array(
            'label' => 'ADD Product',
            'id'=>'add_product',
            'type' => 'button',
            'onclick'=>'addMoreProdElem()',
        ));


         // Select Currency
        $this->addElement('Select', 'currency', array(
          'label' => 'Select Currency',
          'multiOptions' => array(
            '0' => 'USD',
            '1' => 'INR',
          ),
          'onchange' => 'isUSD(this.value);',
        ));

        //Sub Option if INR is choose
        $this->addElement('Select', 'INR', array(
          'label' => 'INR',
          //'description' => "What type of event you want?",
          'multiOptions' => array(
            '0' => 'Haryana',
            '1' => 'out of Haryana',
          ),
          //'onchange' => 'isOnline(this.value);',
        ));

        //Sub Total
        $this->addElement('Text', 'sub_total', array(
            'label' => 'Sub Total:',
            'id'=>'sub_total',
            //'inputtype'=>'email',
            'allowEmpty' => false,
            //'required' => true,
            'onclick'=>'SubTotal()',
        ));

        //Discount
        $this->addElement('Text', 'discount', array(
            'label' => 'Discount:',
            'id'=>'discount',
            //'inputtype'=>'email',
            'allowEmpty' => false,
            //'required' => true,
            //'onfocusout'=>'ValidateEmail()',
        ));

        //Total
        $this->addElement('Text', 'total', array(
            'label' => 'Total:',
            'id'=>'total',
            //'inputtype'=>'email',
            'allowEmpty' => false,
            //'required' => true,
            'onclick'=>'GrandTotal()',
        ));
        $this->addElement('hidden', 'hidden', array(
            'label' => 'Hidden',
            'id'=>'hidden',

            //'inputtype'=>'email',
            //'allowEmpty' => false,
            //'required' => true,
            //'onclick'=>'GrandTotal()',
        ));

        // paid option
        $this->addElement('Select', 'status', array(
            'label' => 'Status',
            'multiOptions' => array("0"=>"unpaid", "1"=>"paid", 2=>"cancelled"),
            'description' => 'If this entry is published, it cannot be switched back to draft mode.'
        ));

         // Element: submit
        $this->addElement('Button', 'submit', array(
            'label' => 'Post Entry',
            'type' => 'submit',
        ));
		}
	}
?>