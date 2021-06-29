<?php
$table = Engine_Api::_()->getDbtable('invoices', 'invoice');
$rName = $table->info('name');

$select = $table->select()
  ->where("owner_id = ?",$viewerId);           

?>

<h2>
	<?php echo $this->htmlLink(array('route' => 'invoice_general'), "Invoices", array()); ?>
	<?php echo $this->translate('&#187;'); ?>
    <?php echo 
    <?php echo $this->translate('&#187;'); ?>
</h2>
