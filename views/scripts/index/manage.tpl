


<style type="text/css">
  /*
  .product-item > input {
    width: 100px;
    }*/

    .product-item > input,
    .product-item > h4 {
      height: 40px;
      margin: 0px 4px;
    }

    .product{
      width: 240px;
    }

    .quantity{
      width: 80px;
    }

    .amount{
      width: 100px;
    }

    .product-item{
      margin: 8px 0px;
    }

  </style>
<style type="text/css">
  #global_wrapper{
    background-color: #fcfcfc !important;
    border-top: 1px solid gray;
}

table{
    /border: 1px solid black;/
    width: 100%;

    border-radius: 25px;
}

.table-heading{
    background-color: #f5f5f5;
}
th{
    font-size: 18px;
    font
}
th,td{
    padding: 10px;
    color: black;
}
tr:nth-child(even) {
    background-color: white;
}
.item-row{
    border-bottom: 1px solid #fae1e1;
}


</style>



<?php if( count($this->paginator) ): ?>
<form id='multidelete_form' method="post" action="<?php echo $this->url();?>">
<table class='admin_table'>
  <thead>
    <tr>
      </th>
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

</form>

<br/>
<div>
  <?php echo $this->paginationControl($this->paginator); ?>
</div>

<?php else: ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("There are no invoice entries by your members yet.") ?>
    </span>
  </div>
<?php endif; ?>
