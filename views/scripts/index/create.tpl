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
 </script>