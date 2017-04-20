		
						function LogSheet2()
						{
                            
                                var lfno,partno,itemname,balqty,bus,qty;
								fn_Inner2_issue();

  							
     										}
						
							function fn_Inner2_issue()
		                	{
			
			
                             
								var Inner_str	= document.getElementById("Grd_Item").innerHTML;
								//alert(Inner_str);
								//var IvechNo  = document.getElementById("ddlcat").value;
								var lfno = document.getElementById('txtlfno').value;
								var partno = document.getElementById('txtPartNo').value
								var itemname = document.getElementById("ddlitem").value;
								var qty = document.getElementById("txtqty").value;
							
								var isReturnVal = "Delete";
								var isReturnText = "No";
//								if(document.getElementById("chkReturn").checked)
//								{
//								    var isReturnVal = "1";
//								    var isReturnText = "No";
//								}
								
								
								///var Icount = document.getElementById("txtcount").value;
								
				                 if (itemname  != "")
								{
                               
								P_Row	 = Grd_Item.insertRow(Grd_Item.rows.length - 1);
								Row_Obj	 = Grd_Item.rows;
								Cell_Obj = P_Row.cells;
								
								New_Cell_1 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_2 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_3 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_4 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								New_Cell_5 = Row_Obj(P_Row.rowIndex).insertCell(Cell_Obj.length);
								
						
													
								New_Cell_1.align = "center";
								New_Cell_2.align = "Center";
								New_Cell_3.align = "Center";
								New_Cell_4.align = "Center";
                                New_Cell_5.align = "Center";
                              

                                var lfno = document.getElementById('txtlfno').value;
								var partno = document.getElementById('txtPartNo').value
								var itemname = document.getElementById("ddlitem").value;
								var qty = document.getElementById("txtqty").value;
                                 
                                New_Cell_1.innerHTML = lfno;
								New_Cell_2.innerHTML = partno                               
								New_Cell_3.innerHTML = itemname;
								New_Cell_4.innerHTML = qty;
        						New_Cell_5.innerHTML = "<IMG Type='Button' class='Button' src='../images/icon_delete.gif' Value='Delete' OnClick= 'Fn_Delete1("+P_Row.rowIndex+")'>"
								Recs = document.getElementById("Hid_Rec").value ;
//								document.getElementById("Hid_Rec").value = Recs +''+ IvechNo + '|' + IrouteNo + '|' + ItoLoc +  '|'  + IFromLoc +  '|' + refNo +  '|' + isReturnVal +  '^'
                                document.getElementById("Hid_Rec").value = Recs +''+ lfno + '|' + partno + '|' + itemname +  '|' + qty +  '^'
								//document.getElementById("txtvehno").value = "";
								document.getElementById('txtlfno').value = "";
								document.getElementById('txtPartNo').value = ""
								document.getElementById("ddlitem").value="";
								document.getElementById("txtqty").value="";
								document.getElementById('txtlfno').focus();
			
							
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
						
						
						
