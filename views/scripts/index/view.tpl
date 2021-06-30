<div class="layout_middle">
    <div class="generic_layout_container">
      <div class="headline">
        <h2>
          <?php echo $this->translate('Invoices');?>
        </h2>
        <div class="tabs">
          <?php
          //Render the menu
          // echo $this->navigation()
          // ->menu()
          // ->setContainer($this->navigation)
          // ->render();
          ?>
        </div>
      </div>
    </div>
  </div>

<?php      
$invoice_number=$this->$invoice_number;
$currency="USD";
$igst=$cgst=$sgst='';
$c='$';
if($this->invoice_details['currency']==1)
{
    $c='<span>&#x20B9;<span>';
    $currency="INR";
    // if($this->invoice_details['state']=='Haryana'){
    //     $sgst=$this->invoice_details['sgst'];
    //     $cgst=$this->invoice_details['cgst'];
    // }
    // else{
    //  $igst=$this->invoice_details['igst'];   
    // }
}

?>
<script type="text/javascript">

    window.jsPDF = window.jspdf.jsPDF;
        function printDiv(divName) {
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;

     document.body.innerHTML = printContents;

     window.print();

     document.body.innerHTML = originalContents;
}
 
var doc = new jsPDF();
    var specialElementHandlers = {
        '#editor': function (element, renderer) {
            return true;
        }
    };

    $('#save').click(function () {
        doc.fromHTML($('#container').html(), 15, 15, {
            'width': 170,
                'elementHandlers': specialElementHandlers
        });
        doc.save('sample-file.pdf');
    });


    </script>
<html>
<head>
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta.2/css/bootstrap.css'>
<script src = "https://raw.githubusercontent.com/MrRio/jsPDF/master/dist/jspdf.debug.js"></script>
</head>
<body>
    <script src = "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

    <div class="container" id="container">
        <div class="card">
            <div class="card-header">
                Invoice 
                <strong><?php echo $this->invoice_details['invoice_number']?></strong>
                <button class="btn btn-sm btn-secondary float-right mr-1 d-print-none" h onclick="printDiv('print')" data-abc="true">
                        <i class="fa fa-print"></i> Print</button>
                    <button id="save" class="btn btn-sm btn-info float-right mr-1 d-print-none"  data-abc="true">
                        <i class="fa fa-save"></i> Save</button>
               
            </div>
            <div id='print'>
            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-sm-4">
                        <h6 class="mb-3">From:</h6>
                        <div>
                            <strong>Bigstep Technologies Private Limited</strong>
                        </div>
                        <div>Justdail Complex Sector 15</div>
                        <div>Gurgaon-122001, Haryana, India</div>
                        <div>Email: info@bigstep.com</div>
                        <div>CIN: U72200HR2009PTC038717</div>
                        <div>Phone: +91 9136773059</div>
                    </div>
                    <div class="col-sm-4">
                        <h6 class="mb-3">To:</h6>
                        <div>
                            <strong><?php echo $this->invoice_details['name']?></strong>
                        </div>
                        <div>Email: <?php echo $this->invoice_details['email']?></div>
                        <div>Phone: <?php echo $this->invoice_details['number']?></div>
                        <div>Address: <?php echo $this->invoice_details['address']?></div>
                    </div>

                    <div class="col-sm-4">
                        <h6 class="mb-3">Details</h6>
                        <div>Invoice
                            <strong><?php echo $this->invoice_details['invoice_number']?></strong>
                        </div>
                        <div>Created By:  <?php echo "  ".$this->invoice_details['creator']?></div>
                        <div>Date:  <?php echo "  ".$this->invoice_details['date']?></div>
                        <div>Currency:  <?php echo "  ".$currency?></div>
                        <div>Status: <?php echo "    ".$this->invoice_details['status']?></div>
                        <div>Last Update:  <?php echo "    ".$this->invoice_details['modified_date']?></div>
                    </div>

                </div>

<div class="table-responsive-sm">
                    <table class="table table-striped" id='items'>
                        <thead>
                            <tr>
                                <th class="center">#</th>
                                <th>Item</th>

                                <th class="right">Quantity</th>
                                <th class="center">Unit Cost</th>
                                <th class="right">Total</th>
                            </tr>
                        </thead>
                        <tbody><?php 
                        $i=0;
                        while($row = mysqli_fetch_assoc($result)) {$i++;

                        echo'
                            <tr>
                                <td class="center">'.$i.'</td>
                                <td class="left strong">'.$row["product_name"].'</td>
                            

                                <td class="right">'.$row["quantity"].'</td>
                                <td class="center">'.$c.$row["price"].'</td>
                                <td class="right">'.$c.$row["total"].'</td>
                            </tr>';
                          }
                            ?>
                           
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-5">

                    </div>

                    <div class="col-lg-4 col-sm-5 ml-auto">
                        <table class="table table-clear">
                            <tbody>
                                <tr>
                                    <td class="left">
                                        <strong>Subtotal</strong>
                                    </td>
                                    <td class="right"> <?php echo $c.$this->invoice_details['subtotal']?></td>
                                </tr>
                                <tr>
                                    <td class="left">
                                        <strong>Discount</strong>
                                    </td>
                                    <td class="right"> <?php echo $this->invoice_details['discount']?>%</td>
                                </tr>
                                <?php
                                if($this->invoice_details['currencies']==1){
                                    if($igst){
                                        echo '
                                    <tr>
                                    <td class="left">
                                        <strong>IGST</strong>
                                    </td>
                                    <td class="right">'.$igst.'%</td>
                                    </tr>
                                        ';
                                    }
                                    else{
                                         echo '
                                    <tr>
                                    <td class="left">
                                        <strong>CGST</strong>
                                        </td>
                                        <td class="left">
                                        <strong>'.$cgst.'%</strong>
                                    </td>
                                    </tr>
                                    <tr>
                                    <td class="left">
                                        <strong>SGST</strong>
                                        </td>
                                        <td class="left">
                                        <strong>'.$sgst.'%</strong>
                                    </td>
                                    </tr>
                                        ';

                                    }
                                }
?>
                                <tr>
                                    <td class="left">
                                        <strong>Total</strong>
                                    </td>
                                    <td class="right">
                                        <strong> <?php echo $c.$this->invoice_details['total']?></strong>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
    <div id="editor"></div>
</body>
</html>

