<?php
echo $this->form->render($this);
?>

<h2>
	<?php echo $this->htmlLink(array('route' => 'invoice_general'), "Invoices", array()); ?>
	<?php echo $this->translate('&#187;'); ?>
	<?php if($category = $this->invoice->getCategoryItem()): ?>
    <?php echo $this->htmlLink($category->getHref(),$category->category_name, array()); ?>
    <?php echo $this->translate('&#187;'); ?>
  <?php endif; ?>
</h2>
