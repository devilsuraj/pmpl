		
						function LogSheet_receive()
						{
						
                                //alert(document.getElementById("Hid_Rec").value); 						
								///var vechNo,routeNo,FromLoc,FromTime,ToLoc,count;
//								if document.getElementById("txtqty").value = ""
//								alert ("enter Number")
//								fn_Calc();
                                var lfno,partno,itemname,balqty,rate,qty,actqty;
								fn_Inner2_receive();

     							//vechNo=document.getElementById("ddlcat").text;
     							lfno = document.getElementById('txtlfno').value
     							partno = document.getElementById('txtPartNo').value
     							itemname=document.getElementById("ddlitem").value;
     							balqty=document.getElementById("txtbqty").value;
     							actqty=document.getElementById("txtqty").value;
     							///count=document.getElementById("txtcount").value;
     							
     							
//								var start =	document.getElementById("Start_cat_code").value+document.getElementById("txtstNo").value;
//								var end	= document.getElementById("End_cat_code").value+document.getElementById("txtendSNo").value;
								//CheckItemExists(denom,start,end);
								//ert(start)
								////alert(end);
						}
						
							function fn_Inner2_receive()
		                	{
			
				
                            
								var Inner_str	= document.getElementById("Grd_Item").innerHTML;
								//alert(Inner_str);
								//var IvechNo  = document.getElementById("ddlcat").value;
								var lfno = document.getElementById('txtlfno').value;
								var partno = document.getElementById('txtPartNo').value
								var itemname = document.getElementById("ddlitem").value;
								var balqty = document.getElementById("txtbqty").value;
								var qtyinchaln = document.getElementById("txtChallnQty").value;
								var rate = document.getElementById("txtRate").value;
								var actqty = document.getElementById("txtqty").value;
								///var Icount = document.getElementById("txtcount").value;
								
								var isReturnVal = "Delete";
								var isReturnText = "No";
//								if(document.getElementById("chkReturn").checked)
//								{
//								    var isReturnVal = "1";
//								    var isReturnText = "Yes";
//								}
								
				                 if (itemname  != "")
								{
                               
								P_Row	 = document.getElementById('Grd_Item').insertRow(document.getElementById('Grd_Item').rows.length - 1);
								Row_Obj	 = document.getElementById('Grd_Item').rows;
								Cell_Obj = P_Row.cells;

								New_Cell_1 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_2 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_3 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_4 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
						       	New_Cell_5 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_6 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_7 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_8 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
	
											
								New_Cell_1.align = "center";
								New_Cell_2.align = "Center";
								New_Cell_3.align = "Center";
								New_Cell_4.align = "Center";
                                New_Cell_5.align = "Center";
                                New_Cell_6.align = "Center";
                                New_Cell_7.align = "Center";
                                New_Cell_8.align = "Center";
                                                                                        
								//New_Cell_1.innerHTML = IvechNo;
															
					
								New_Cell_1.innerHTML = lfno;
								New_Cell_2.innerHTML = partno
								New_Cell_3.innerHTML = itemname;
								New_Cell_4.innerHTML = balqty; 
								New_Cell_5.innerHTML =  rate;
								New_Cell_6.innerHTML =qtyinchaln;
								New_Cell_7.innerHTML = actqty;
								New_Cell_8.innerHTML = "<IMG Type='Button' class='Button' src='../images/icon_delete.gif' Value='Delete' OnClick= 'Fn_Delete1("+P_Row.rowIndex+")'>"							
								Recs = document.getElementById("Hid_Rec").value ;
							
								//document.getElementById("Hid_Rec").value = Recs +''+ IvechNo + '|' + IrouteNo + '|' + ItoLoc +  '|' + IFromLoc +  '|' + Icount + '^'
								document.getElementById("Hid_Rec").value = Recs +''+ lfno + '|' + partno + '|' + itemname + '|' + balqty +  '|' + qtyinchaln +'|' + rate +'|'+ actqty  +   '^'
								//document.getElementById("txtvehno").value = "";
								//document.getElementById("ddlcat").value = "";
								document.getElementById('txtlfno').value = '';
								document.getElementById('txtPartNo').value ='';
								document.getElementById("ddlitem").value="";
								document.getElementById("txtqty").value="";
								document.getElementById("txtbqty").value="";
								document.getElementById("txtChallnQty").value="";
								document.getElementById("txtRate").value="";
								document.getElementById('txtlfno').focus();
								//document.getElementById("chkReturn").checked=false;
																}
								else
								{
								alert("please enter total quantity")
								return false;
								}
							}
					
					
					
			function Fn_Delete1(val)
			{

				if(confirm('Are you sure you wan`t to delete this Item'))
				{
				
					var Records = document.getElementById("Hid_Rec").value;
					var rec_arr=Records.split("^");
					var item=document.getElementById("Grd_Item").rows(val).innerHTML
					
					for(var i=0;i<=10;i++)
					
					item=item.replace("</TD>","|");
					item=item.replace(/(<\/?p)(?:\s[^>]*)?(>)|<[^>]*>/gi,"");
					item=item.substring(0,item.lastIndexOf("|")-3);
					item=item.replace(/\n/g,"").replace(/\r/g,"");
					document.getElementById("Grd_Item").deleteRow(val);
					var newarr=removeItem(rec_arr,item);
					document.getElementById("Hid_Rec").value=newarr.join("^");
					
					
					
					//fn_Cal_Total();
					//alert(document.getElementById("Hid_Rec").value)
					
				}
				else
				
				return false;
		
			}	
					
					function removeItem(originalArray, itemToRemove)
			 {
		
					var j;
					j = 0;
					while (j < originalArray.length) 
					{
						if (originalArray[j] == itemToRemove)
						{
							originalArray.splice(j, 1);
							
						}
						 else 
						{
							j++;
						}
					}
					return originalArray;
			}
//			


		function Select()
						{
						
								var resultStr = ""; 
								objddl2 =document.getElementById('Select1');
								for(var i = 0; i < objddl2.options.length; i++ )
							{  
									if( objddl2.options[i].selected ) 
								 {    
									resultStr+= (objddl2.options[i].text);
									var objddl1 = document.getElementById('txtitem');
									objddl1.value=resultStr;
									var x=document.getElementById('Select1');
									x.style.display="none";  
									return false;
									//alert(resultStr)
								} 
							} 
							
						}
			
//					
						
						
						

