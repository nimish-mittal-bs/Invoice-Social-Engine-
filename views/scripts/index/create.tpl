

<?php 
echo $this->form->render($this);
$this->headScript()
      ->appendFile($this->layout()->staticBaseUrl . '/application/modules/Invoice/externals/scripts/Validation.js');
?>

<script>
	scriptJquery(document).ready(function() {
    //totalfiels++;
    let objTo = document.getElementById('email-wrapper');
    let divtest = document.createElement("div");
    divtest.setAttribute('id','intaldiv');
    divtest.innerHTML = `<div class="label"></div><div class="content"><span><input type="text" style="height:40px;width:300px;" name="p_name1"value="" placeholder="Product Name"/></span>&nbsp;<span><input type="number" step ="any" style="height:40px;width:80px;" name="quantity1" value="0" placeholder="Quantity"/></span>&nbsp;<span><input type="number" step ="any" style="height:40px;width:80px;"  name="price1" onkeyup="total_price(this)" placeholder="Price"/></span>&nbsp;<span><input type="number" step ="any" style="height:40px;width:80px;" name="total1" value="" placeholder="Total"/></span></div>`;

    function total_price(element){
      let id = element.name.substring(5);
      c='price'+id;
      d='quantity'+id;
      e='total'+id;
      let val1=document.getElementsByName(c)[0].value;
      let val2=document.getElementsByName(d)[0].value;
      let val3=document.getElementsByName(e)[0].value= val1*val2;
    }


    objTo.append(divtest);
    isUSD(0);
  });
  
  function isUSD(value) {
    if(value == 1) {
      scriptJquery('#INR-wrapper').show();
      scriptJquery('#location-wrapper').hide();
      scriptJquery('#location').val('');
    } else {
      scriptJquery('#INR-wrapper').hide();
      scriptJquery('#location-wrapper').show();
      scriptJquery('#INR').val('');
    }
  }

  function GrandTotal(){
    console.log("hey");
    val5=0;
    val8=parseInt(val5);
    // for (let i=1; i<=10;i++){
    //   f="total"+i;

      //let val6=document.getElementsByName(f)[0].value;
      val12=document.getElementById('sub_total').value
      val9=document.getElementById('discount').value
      val13=document.getElementById('currency').value
      val9=parseInt(val9);
      val12=parseInt(val12);
      val10=(100-val9)/100;
      val11=val12*val10;
      if (val13==0)
      {
        document.getElementById('total').value=val11;

        //console.log("USD");
      }
      else
      {
        // val16="<?php echo $CGST ?>";
        // console.log(val16);
        val14=document.getElementById('inr').value
        if (val14==0)
        {
          document.getElementById('total').value=val11;
        }
        else
        {
          document.getElementById('total').value=val11;
        }
      }
      //console.log(val13);
      
    //    //}
     
  }
 </script>



     <!--  <h2>Bank Details:</h2>

      <p>Account Name:<?=$details['account.name']?></p>
      <p>Account No:<?=$details['account.no']?></p>
      <p>Bank:<?=$details['bank.name']?></p>
      <p>Account Address:<?=$details['account.address']?></p>
      <p>IFSC Code:<?=$details['ifsc.code']?></p>
 -->

<?php
$PAN=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.pan', 18);
$GST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.gst', 18);
$LUT=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.lut', 18);
$CGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.cgst', 18);
$SGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.sgst', 18);
$IGST=Engine_Api::_()->getApi('settings', 'core')->getSetting('invoice.igst', 18);

 ?>
<p>PAN No:<?=$PAN?></p>
      <p>GST No:<?=$GST?></p>
      <p>LUT No:<?=$LUT?></p> 