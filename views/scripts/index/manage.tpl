<script type="text/javascript">

function multiDelete()
{
  return confirm("<?php echo $this->translate('Are you sure you want to delete the selected invoice entries?');?>");
}

function selectAll()
{
  var i;
  var multidelete_form = $('multidelete_form');
  var inputs = multidelete_form.elements;
  for (i = 1; i < inputs.length; i++) {
    if (!inputs[i].disabled) {
      inputs[i].checked = inputs[0].checked;
    }
  }
}
</script>


<?php if( count($this->paginator) ): ?>
<form id='multidelete_form' method="post" action="<?php echo $this->url();?>" onSubmit="return multiDelete()">
<table class='admin_table'>
  <thead>
    <tr>
      <th class='admin_table_short'><input onclick='selectAll();' type='checkbox' class='checkbox' /></th>
      <th class='admin_table_short'>ID</th>
      <th><?php echo $this->translate("Date") ?></th>
      <th><?php echo $this->translate("Invoice Number") ?></th>
      <th><?php echo $this->translate("Receiver") ?></th>
      <th><?php echo $this->translate("Creater") ?></th>
      <th><?php echo $this->translate("Status") ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($this->paginator as $item):
     // print_r($item->toArray());
     // die;?>
     <tr>
     <td><input type='checkbox' class='checkbox' name='delete_<?php echo $item['invoice_id']; ?>' value="<?php echo $item['invoice_id']; ?>" /></td>
     
        <td><?php echo $item['invoice_id'] ?></td>
        <td><?php echo $item['date'] ?></td>
        <td><?php echo $item['invoice_number'] ?></td>
        <td><?php echo $item['receiver'] ?></td>
        <td><?php echo $item['owner_type'] ?></td>
        <td><?php echo $item['status'] ?></td>
        <td>
          <?php echo $this->htmlLink(array('route' => 'invoice_specific','action' => 'view', 'invoice_id' => $item->invoice_id),
                $this->translate("view")) ?>
          |
          <?php echo $this->htmlLink(array('route' => 'invoice_specific','action' => 'edit', 'invoice_id' => $item->invoice_id),
                $this->translate("edit")) ?>
          
          |
          <?php echo $this->htmlLink(
                array('route' => 'invoice_specific','action' => 'delete', 'invoice_id' => $item->invoice_id),
                $this->translate("delete"),
                array('class' => 'smoothbox')) ?>
        </td>
      </tr>
    <?php endforeach; ?>
  </tbody>
</table>

<br />

<div class='buttons'>
  <button type='submit'><?php echo $this->translate("Delete Selected") ?></button>
</div>
</form>

<br/>
<div>
  <?php echo $this->paginationControl($this->paginator); ?>
</div>

<?php else: ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("There are no blog entries by your members yet.") ?>
    </span>
  </div>
<?php endif; ?>
