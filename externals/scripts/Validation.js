console.log("hello");

// Phone Number Validation
function phonenumber(param)
{
  as=document.getElementById('phonenum');
   if (as.value == "" || as.value == null)
  {
    alert("Please enter your Mobile No.");
    return false;
  }
  if (as.value.length < 10 || as.value.length > 10) 
  {
    alert("Mobile No. is not valid, Please Enter 10 Digit Mobile No.");
    return false;
  }      
}

// Email Validation
function ValidateEmail(mail) 
{
  asd=document.getElementById('emailid');
  aasd=asd.value

  atpos = aasd.indexOf("@");
  dotpos = aasd.lastIndexOf(".");
         
  if (atpos < 1 || ( dotpos - atpos < 2 )) 
  {
    alert("Please enter correct email ID")
    //document.myForm.EMail.focus() ;
    return false;
  }
  return( true );
}

let room=1;
 document.getElementById('hidden').value=room;
function addMoreProdElem()
{

 room++;
    //totalfiels++;
    let objTo = document.getElementById('intaldiv');
    let divtest = document.createElement("div");
    divtest.setAttribute('id',room);
    divtest.innerHTML = `<div class="label"></div><div class="content"><span><input type="text" style="height:40px;width:300px;" name="p_name${room}"value="" placeholder="Product Name"/></span>&nbsp;<span><input type="number" step ="any" style="height:40px;width:80px;" name="quantity${room}" value="0" placeholder="Quantity"/></span>&nbsp;<span><input type="number" step ="any" style="height:40px;width:80px;" name="price${room}" onkeyup="total_price(this)" placeholder="Price"/></span>&nbsp;<span><input type="number" step ="any" style="height:40px;width:80px;" name="total${room}" value="" placeholder="Total"/></span>&nbsp;<span><button onclick="remove_product(this)" id="row${room}" style="height:40px; ">x</button></span></div>`;

    objTo.append(divtest);
    //document.getElementById('room').value=room;
    //console.log(divtest);
    document.getElementById('hidden').value=room;
}

function remove_product(element)
{
  //totalfiels--;
  let id = element.id.substring(3);
  let elem = document.getElementById(id);
  elem.remove();
  //document.getElementById('hidden').value=room-1;
}
let sub_total=0;

function total_price(element)
{
  let id = element.name.substring(5);
  c='price'+id;
  d='quantity'+id;
  e='total'+id;
  
  let val1=document.getElementsByName(c)[0].value;
  
  let val2=document.getElementsByName(d)[0].value;
 let val3=document.getElementsByName(e)[0].value= val1*val2;
 
}

function SubTotal()
{
  val5=0;
  val8=parseInt(val5);
for (let i=1; i<=room;i++)
{
  f="total"+i;
  let val6=document.getElementsByName(f)[0].value;
  val7=parseInt(val6);
  val8=val8+val7;
}
document.getElementById('sub_total').value= val8;

}


// function GrandTotal(){
//   console.log("hey");
//   val5=0;
//   val8=parseInt(val5);
// for (let i=1; i<=room;i++){
//   f="total"+i;
//   let val6=document.getElementsByName(f)[0].value;
//   val9=document.getElementById('discount').value;
//   val9=parseInt(val9);
//   val6=parseInt(val6);
//   val10=(100-val9)/100;
//   val11=val6*val10;
//   //console.log(val11);
//   }
// document.getElementById('total').value= val11;

// }