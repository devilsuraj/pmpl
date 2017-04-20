<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="PO_Master.aspx.vb" Inherits="KDMT.PO_Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet">
   <script src="../scripts/jquery-1.11.0.min.js"></script>
            <script src="../scripts/jquery-ui.js"></script>
</asp:Content>
<%@ Register Assembly="BasicFrame.WebControls.BasicDatePicker" Namespace="BasicFrame.WebControls"
    TagPrefix="BDP" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" ClientIDMode="Static" EnableViewState="true" runat="Server">
    <div class="breadcrumbs">
        <h1>Purchase Order (  
            <asp:Label ID="lbldepttype" Text="" ForeColor="red" runat="server"></asp:Label>)</h1>
        <!-- Sidebar Toggle Button -->
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".page-sidebar">
            <span class="sr-only">Toggle navigation</span>
            <span class="toggle-icon">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </span>
        </button>
        <input id="hdnID" runat="server" type="hidden" name="hdnID" />
        <input id="hdnrwcnt" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnsrno" runat="server" type="hidden" name="hdnsrno" />
        <input id="hdndetail" runat="server" type="hidden" name="hdnrwcnt" />
        <input id="hdnrwcntother" runat="server" type="hidden" name="hdnrwcntother" />
        <input id="hdnsrnoother" runat="server" type="hidden" name="hdnsrnoother" />
        <input id="hdndetailother" runat="server" type="hidden" name="hdndetailother" />
        <!-- Sidebar Toggle Button -->
    </div>
    <div class="page-content-container">
        <div class="page-content-row form-horizontal">
            <div class="page-content-col">
                <!-- BEGIN PAGE BASE CONTENT -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box">
                            <div class="portlet-body form">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Vendor Name</label>
                                            <div class="col-md-3">
                                                <asp:TextBox ID="ddlvendor" runat="server" class="form-control input-sm" placeholder="Vendor Name">
                                                </asp:TextBox>
                                            </div>
                                            <label class="col-md-2 control-label">Category</label>
                                            <div class="col-md-3">
                                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">PO Date</label>
                                            <div class="col-md-3">
                                              
                                                 <asp:TextBox ID="dtPODate" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="dtPODate"
                                                    PopupButtonID="dtPODate" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                <asp:ScriptManager ID="Scriptmanager1" runat="server">
                                                </asp:ScriptManager>
                                            </div>
                                            <label class="col-md-2 control-label">PO No</label>
                                            <div class="col-md-3">
                                                <select id="ddlPONo" runat="server" style="width: 140px">
                                                    <option value="RC">RC</option>
                                                    <option value="SP">SP</option>
                                                    <option value="PA">PA</option>
                                                    <option value="T">T&C</option>
                                                    <option value="PB">PB</option>
                                                    <option value="PMT">PMT</option>
                                                    <option value="STN">STN</option>
                                                </select>
                                                <span lang="en-us">
                                                    <%--   <input type="text" id="txtPONo" name="txtPONo" size="5px" onclick="return txtPONo_onclick()"
                                    />--%>
                                                    <asp:TextBox ID="txtPONo" Width="70%" onblur="poexists();" runat="server"></asp:TextBox>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Our Ref No</label>
                                            <div class="col-md-3">
                                                <input type="text" id="txtOurRefNo" name="txtOurRefNo" class="form-control input-sm" placeholder="Our Ref No" />
                                            </div>
                                            <label class="col-md-2 control-label">Our Ref Date</label>
                                            <div class="col-md-3">
                                             

                                                 <asp:TextBox ID="dtOurRefNo" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="dtOurRefNo"
                                                    PopupButtonID="dtOurRefNo" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Your Ref No</label>
                                            <div class="col-md-3">
                                                <input type="text" id="txtYourRefNo" name="txtYourRefNo" class="form-control input-sm" placeholder="Your Ref No" />
                                            </div>
                                            <label class="col-md-2 control-label">Your Ref Date</label>
                                            <div class="col-md-3">
                                             
                                                  <asp:TextBox ID="dtYourRefNo" Width="180px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="dtYourRefNo"
                                                    PopupButtonID="dtYourRefNo" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Ref ASRTU </label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input-sm" id="txtref_asrtu" name="txtref_asrtu" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Special Discount (%) </label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control input-sm" id="txtspdisc" name="txtspdisc" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">VAT (%)</label>
                                            <div class="col-md-3">
                                                <input type="text" id="txtvat" class="form-control input-sm" value='0' name="txtvat" />
                                            </div>
                                            <label class="col-md-2 control-label">ED (%)</label>
                                            <div class="col-md-3">
                                                <input type="text" id="txtED" value='0' name="txtED" onblur="setfocus()" class="form-control input-sm" placeholder="0" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="portlet box">
                                    <div class="portlet-title">
                                    </div>
                                    <div class="portlet-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead style="background-color: #CCC;">
                                                    <tr>
                                                        <th>SR No. </th>
                                                        <th>LF No. </th>
                                                        <th>Part No. </th>
                                                        <th>Nomenclature</th>
                                                        <th>Rate </th>
                                                        <th>No of Qty	</th>
                                                        <th>Per Qty Rate</th>
                                                        <th>Quantity</th>
                                                        <th>Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="text" id="lblsrno" style="width: 20px" readonly="readonly" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtlfno" style="width: 40px" size="10" onblur="emptytext();itemsearch()" />
                                                        <td>
                                                            <input type="text" id="txtCodeNo" onblur="emptytextpart();itemsearch();" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtNomenclature" onpropertychange="itemsearch()" onblur="fillitem();check1();" />
                                                            <asp:ListBox ID="Select1" Style="display: none;" onclick="Select();"
                                                                runat="server"></asp:ListBox>
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtbaserate" style="width: 70px" maxlength="10" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtbaseqty" onblur="return calculate();" style="width: 70px"
                                                                maxlength="10" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtRate" readonly="readonly" style="width: 70px" size="15" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtQuantity" style="width: 70px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtAmount" onfocus="return Amount();" size="20" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead style="background-color: #CCC;">
                                                    <tr>
                                                        <th>SR No. </th>
                                                        <th>Item No. </th>
                                                        <th>APR </th>
                                                        <th>MAY</th>
                                                        <th>JUNE </th>
                                                        <th>JULY	</th>
                                                        <th>AUG</th>
                                                        <th>SEP</th>
                                                        <th>OCT</th>
                                                        <th>NOV</th>
                                                        <th>DEC</th>
                                                        <th>JAN</th>
                                                        <th>FEB</th>
                                                        <th>MAR</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="text" id="lblsrnoother" style="width: 20px" readonly="readonly" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtsrno1" style="width: 50px; text-align: center" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon1" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon2" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon3" style="width: 50px"
                                                                size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon4" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon5" style="width: 50px"
                                                                size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon6" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon7" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon8" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon9" style="width: 50px"
                                                                size="10" /></td>
                                                        <td>
                                                            <input type="text" id="txtmon10" style="width: 50px" size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon11" style="width: 50px"
                                                                size="10" />
                                                        </td>
                                                        <td>
                                                            <input type="text" id="txtmon12" style="width: 50px"
                                                                size="10" onblur="addPODetailsother();" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="table table-boredred">
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 13px">(1) Bill and Challans should be sent in triplicate,</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(2) Payment will be made </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" value="Through Bank" id="txtPayment" name="txtPayment" tabindex="9" />
                                                    </td>
                                                    <td colspan="1" rowspan="6" valign="top">
                                                        <span style="font-size: 18px">This purchase is made under the
                                <br />
                                                            <br />
                                                            powers vested in me under the
                                <br />
                                                            <br />
                                                            B.P.M.C. Act, 1994 Chapter V,
                                <br />
                                                            <br />
                                                            Section(1)(i)(2) Exection
                                <br />
                                                            <br />
                                                            of contract waived.</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(3) Discount</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtDescount" name="txtDescount" tabindex="10" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(4) Freight will be borne by</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtFright" name="txtFright" tabindex="11" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(5) Bank charges/commission will be borne by</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtBankCharges" name="txtBankCharges" tabindex="11" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(6) Good to be sent by</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtGoodsent" name="txtGoodsent" tabindex="12" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(7) Delivert should be completed by</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtDelivery" name="txtDelivery" tabindex="13" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">(8) Validity Period</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtValidityPeriod" name="txtValidityPeriod" tabindex="14" />
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td>
                                                        <span style="font-size: 14px">Total Commitment Rs.............year</span>
                                                    </td>
                                                    <td>
                                                        <input class="form-control" type="text" id="txtYear" name="txtYear" tabindex="15" />
                                                    </td>
                                                    <td colspan="2" style="width: 50%">
                                                        <span style="font-size: 14px">Rate sanctioned by TC/Transport Manager</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">Entd in B/C Regr</span>
                                                        <input class="form-control" type="text" id="txtBCReg" name="txtBCReg" tabindex="16" />
                                                    </td>
                                                    <td>
                                                        <span style="font-size: 14px">Sr.No</span>
                                                        <input class="form-control" type="text" id="txtSrNo" name="txtSrNo" tabindex="17" />
                                                    </td>
                                                    <td colspan="1"> <span style="font-size: 14px">Res.No.</span>
                                                        <input class="form-control" type="text" id="txtResNo" name="txtResNo" tabindex="22" /> </div>
                                                </tr>
                                                <tr>
                                                  
                                                    <td colspan="2">
                                                        <span style="font-size: 14px">Purchase Authorised by </span>
                                                        <input class="form-control" type="text" id="txtPurchase" name="txtPurchase" tabindex="24" />
                                                    </td>

                                                    <td colspan="2">
                                                        
                                                        <span style="font-size: 14px">Trans.ManagDt.</span>
                                                    
                                                           <asp:TextBox ID="Date2" Width="350px" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="Date2"
                                                    PopupButtonID="Date2" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-size: 14px">Audited by</span>
                                                        <input class="form-control" type="text" id="txtAudited" name="txtAudited" tabindex="18" />
                                                    </td>
                                                    <td>
                                                        <span style="font-size: 14px">Cl.</span>
                                                        <input class="form-control" type="text" id="txtCl" size="15px" name="txtCl" tabindex="19" />
                                                        
                                                    </td>
                                                    <td> <span style="font-size: 14px">Dt.</span>
                                                     
                                                           <asp:TextBox ID="Date1" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="Date1"
                                                    PopupButtonID="Date1" Format="dd-MMM-yyyy">
                                                </asp:CalendarExtender> </td>

                                                    <td align="left">
                                                        <span style="font-size: 14px">Budegt Account Hd</span>
                                                        <input class="form-control" type="text" id="txtBudgetAccount" name="txtBudgetAccount" onclick="return txtBudgetAccount_onclick()"
                                                            tabindex="25" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">  <span style="font-size: 14px">Prepared by</span>
                                                        <input class="form-control" type="text" id="txtPreparedby" name="txtPreparedby" tabindex="26" /></td>
                                                    <td colspan="2">
                                                       
                                                        <span style="font-size: 14px">Checked by</span>
                                                        <input class="form-control" type="text" id="txtCheckedBy" name="txtCheckedBy" tabindex="28" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <span style="font-size: 14px">Audited Officer</span>  <input class="form-control" type="text" id="txtAudit_officer" name="txtAudit_officer" tabindex="21" />
                                                    </td>
                                                    
                                                    <td colspan="2">
                                                        <span style="font-size: 14px">Indent Ref No .</span>
                                                        <input class="form-control" type="text" id="txtIndentRefNo" name="txtIndentRefNo" tabindex="29" onblur="setfocus()" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <asp:Button ID="Button1" runat="server" Text="Save" />
                                                        <asp:Button ID="btn_print" Text="Print" runat="server" />
                                                        <a href="po_master.aspx">Reset</a>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--form body ends-->
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- END PAGE BASE CONTENT -->
        </div>
        <script language="javascript" type="text/javascript">
            var Optype = 0
            var Fuel
            var ID = 0;
            var rowcnt = 1;
            var rowcntSave = 1;
            var rowcntother = 1;
            var rowcntothersave = 1;
            function addPODetails() {
                if (document.getElementById('hdnsrno').value == '') {
                    document.getElementById('hdnsrno').value = 0;
                }
                var srno = 0;
                var lblsrno = document.getElementById('lblsrno');
                var txtlfNo = document.getElementById('txtlfno');
                var txtCodeNo = document.getElementById('txtCodeNo');
                var txtNomenclature = document.getElementById('txtNomenclature');
                var txtbaserate = document.getElementById('txtbaserate');
                var txtbaseqty = document.getElementById('txtbaseqty');
                var txtQuantity = document.getElementById('txtQuantity');
                var txtRate = document.getElementById('txtRate');
                var txtAmount = document.getElementById('txtAmount');
                var tbody = document.getElementById('tbodyIndent');
                var row = tbody.insertRow(rowcnt);
                row.setAttribute('id', 'trPO_' + rowcnt);
                var cells1 = row.insertCell(0);
                cells1.setAttribute('id', 'tdsrno_' + rowcnt);
                var cells2 = row.insertCell(1);
                cells2.setAttribute('id', 'tdlfno_' + rowcnt);
                var cells3 = row.insertCell(2);
                cells3.setAttribute('id', 'tdCodeNo_' + rowcnt);
                var cells4 = row.insertCell(3);
                cells4.setAttribute('id', 'tdNomenclature_' + rowcnt);
                var cells5 = row.insertCell(4);
                cells5.setAttribute('id', 'tdbaserate_' + rowcnt);
                var cells6 = row.insertCell(5);
                cells6.setAttribute('id', 'tdbaseqty_' + rowcnt);
                var cells7 = row.insertCell(6);
                cells7.setAttribute('id', 'tdQuantity_' + rowcnt);
                var cells8 = row.insertCell(7);
                cells8.setAttribute('id', 'tdRate_' + rowcnt);
                var cells9 = row.insertCell(8);
                cells9.setAttribute('id', 'tdAmount_' + rowcnt);
                var cells10 = row.insertCell(9);
                cells1.innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1;
                document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
                cells2.innerHTML = txtlfNo.value;
                cells3.innerHTML = txtCodeNo.value;
                cells4.innerHTML = txtNomenclature.value;
                cells5.innerHTML = txtbaserate.value;
                cells6.innerHTML = txtbaseqty.value;
                cells7.innerHTML = txtRate.value;
                cells8.innerHTML = txtQuantity.value;
                cells9.innerHTML = txtAmount.value;
                cells10.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRow(\'trPO_' + rowcnt + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
                rowcnt = rowcnt + 1;
                lblsrno.value = '';
                txtlfNo.value = '';
                txtCodeNo.value = '';
                txtNomenclature.value = '';
                txtbaserate.value = '';
                txtbaseqty.value = '';
                txtQuantity.value = '';
                txtRate.value = '';
                txtAmount.value = '';
                txtlfNo.focus();
                document.getElementById('hdnrwcnt').value = rowcnt;
                // alert(document.getElementById('hdnrwcnt').value)
            }
            function addPODetailsother() {
                if (document.getElementById('hdnsrnoother').value == '') {
                    document.getElementById('hdnsrnoother').value = 0;
                }
                var srnoother = 0;
                var lblsrno = document.getElementById('lblsrnoother');
                var txtsrno1 = document.getElementById('txtsrno1');
                var txtQty1 = document.getElementById('txtmon1');
                var txtQty2 = document.getElementById('txtmon2');
                var txtQty3 = document.getElementById('txtmon3');
                var txtQty4 = document.getElementById('txtmon4');
                var txtQty5 = document.getElementById('txtmon5');
                var txtQty6 = document.getElementById('txtmon6');
                var txtQty7 = document.getElementById('txtmon7');
                var txtQty8 = document.getElementById('txtmon8');
                var txtQty9 = document.getElementById('txtmon9');
                var txtQty10 = document.getElementById('txtmon10');
                var txtQty11 = document.getElementById('txtmon11');
                var txtQty12 = document.getElementById('txtmon12');
                var tbody = document.getElementById('tbodyother');
                var row = tbody.insertRow(rowcntother);
                row.setAttribute('id', 'trPOother_' + rowcntothersave);
                var cells1 = row.insertCell(0);
                cells1.setAttribute('id', 'tdsrnoother_' + rowcntothersave);
                var cells2 = row.insertCell(1);
                cells2.setAttribute('id', 'tdsrno1_' + rowcntothersave);
                var cells3 = row.insertCell(2);
                cells3.setAttribute('id', 'tdQty1_' + rowcntothersave);
                var cells4 = row.insertCell(3);
                cells4.setAttribute('id', 'tdQty2_' + rowcntothersave);
                var cells5 = row.insertCell(4);
                cells5.setAttribute('id', 'tdQty3_' + rowcntothersave);
                var cells6 = row.insertCell(5);
                cells6.setAttribute('id', 'tdQty4_' + rowcntothersave);
                var cells7 = row.insertCell(6);
                cells7.setAttribute('id', 'tdQty5_' + rowcntothersave);
                var cells8 = row.insertCell(7);
                cells8.setAttribute('id', 'tdQty6_' + rowcntothersave);
                var cells9 = row.insertCell(8);
                cells9.setAttribute('id', 'tdQty7_' + rowcntothersave);
                var cells10 = row.insertCell(9);
                cells10.setAttribute('id', 'tdQty8_' + rowcntothersave);
                var cells11 = row.insertCell(10);
                cells11.setAttribute('id', 'tdQty9_' + rowcntothersave);
                var cells12 = row.insertCell(11);
                cells12.setAttribute('id', 'tdQty10_' + rowcntothersave);
                var cells13 = row.insertCell(12);
                cells13.setAttribute('id', 'tdQty11_' + rowcntothersave);
                var cells14 = row.insertCell(13);
                cells14.setAttribute('id', 'tdQty12_' + rowcntothersave);
                var cells15 = row.insertCell(14);
                cells1.innerHTML = parseInt(document.getElementById('hdnsrnoother').value) + 1;
                document.getElementById('hdnsrnoother').value = parseInt(document.getElementById('hdnsrnoother').value) + 1
                cells2.innerHTML = txtsrno1.value;
                cells3.innerHTML = txtQty1.value;
                cells4.innerHTML = txtQty2.value;
                cells5.innerHTML = txtQty3.value;
                cells6.innerHTML = txtQty4.value;
                cells7.innerHTML = txtQty5.value;
                cells8.innerHTML = txtQty6.value;
                cells9.innerHTML = txtQty7.value;
                cells10.innerHTML = txtQty8.value;
                cells11.innerHTML = txtQty9.value;
                cells12.innerHTML = txtQty10.value;
                cells13.innerHTML = txtQty11.value;
                cells14.innerHTML = txtQty12.value;
                cells15.innerHTML = '<a href="javascript:void(0)" OnClick= "deleteRowother(\'trPOother_' + rowcntothersave + '\')" ><IMG Type="Button" class="Button" src="../images/icon_delete.gif" Value="Delete" ></a>'
                rowcntother = rowcntother + 1;
                rowcntothersave = rowcntothersave + 1
                txtsrno1.value = '';
                txtQty1.value = '';
                txtQty2.value = '';
                txtQty3.value = '';
                txtQty4.value = '';
                txtQty5.value = '';
                txtQty6.value = '';
                txtQty7.value = '';
                txtQty8.value = '';
                txtQty9.value = '';
                txtQty10.value = '';
                txtQty11.value = '';
                txtQty12.value = '';
                // txtsrno1.focus();        
                document.getElementById('hdnrwcntother').value = rowcntothersave;
                // alert(document.getElementById('hdnrwcnt').value)
                txtsrno1.focus();
                ValidateSaveother();
            }
            function ValidateSaveother() {
                //debugger
                var detvaluesother = '';
                var i = 0;
                var hdnrwcntother = document.getElementById('hdnrwcntother').value;
                for (i = 1; i < hdnrwcntother ; i++) {
                    if (document.getElementById('tdsrno1_' + i) != null) {
                        var srno1 = document.getElementById('tdsrno1_' + i).innerHTML;
                        var mon1 = document.getElementById('tdQty1_' + i).innerHTML;//                
                        var mon2 = document.getElementById('tdQty2_' + i).innerHTML;
                        var mon3 = document.getElementById('tdQty3_' + i).innerHTML;
                        var mon4 = document.getElementById('tdQty4_' + i).innerHTML;
                        var mon5 = document.getElementById('tdQty5_' + i).innerHTML;
                        var mon6 = document.getElementById('tdQty6_' + i).innerHTML;
                        var mon7 = document.getElementById('tdQty7_' + i).innerHTML;
                        var mon8 = document.getElementById('tdQty8_' + i).innerHTML;
                        var mon9 = document.getElementById('tdQty9_' + i).innerHTML;
                        var mon10 = document.getElementById('tdQty10_' + i).innerHTML;
                        var mon11 = document.getElementById('tdQty11_' + i).innerHTML;
                        var mon12 = document.getElementById('tdQty12_' + i).innerHTML;
                        //                detvaluesother = detvaluesother + txtlfNo + '^' + CodeNo + '^' + Nomenclature + '^' + baserate + '^' + baseqty + '|';
                        detvaluesother = detvaluesother + srno1 + '^' + mon1 + '^' + mon2 + '^' + mon3 + '^' + mon4 + '^' + mon5 + '^' + mon6 + '^' + mon7 + '^' + mon8 + '^' + mon9 + '^' + mon10 + '^' + mon11 + '^' + mon12 + '|';
                    }
                }
                document.getElementById("hdndetailother").value = detvaluesother
            }
            function deleteRow(cnt) {
                var tr = document.getElementById(cnt);
                document.getElementById('tbodyIndent').removeChild(tr);
                var hdnrwcnt = document.getElementById('hdnrwcnt');
                //hdnrwcnt.value = hdnrwcnt.value -1;
                rowcnt = rowcnt - 1;
                document.getElementById('hdnsrno').value = 0;
                for (i = 1; i < hdnrwcnt.value  ; i++) {
                    if (document.getElementById('tdNomenclature_' + i) != null) {
                        document.getElementById('tdsrno_' + i).innerHTML = parseInt(document.getElementById('hdnsrno').value) + 1
                        document.getElementById('hdnsrno').value = parseInt(document.getElementById('hdnsrno').value) + 1
                    }
                }
            }
            function deleteRowother(cnt) {
                var tr = document.getElementById(cnt);
                document.getElementById('tbodyother').removeChild(tr);
                var hdnrowcntother = document.getElementById('hdnrwcntother');
                //hdnrwcnt.value = hdnrwcnt.value -1;
                rowcntother = rowcntother - 1;
                document.getElementById('hdnsrnoother').value = 0;
                for (i = 1; i < hdnrowcntother.value  ; i++) {
                    if (document.getElementById('tdQty1_' + i) != null) {
                        document.getElementById('tdsrnoother_' + i).innerHTML = parseInt(document.getElementById('hdnsrnoother').value) + 1
                        document.getElementById('hdnsrnoother').value = parseInt(document.getElementById('hdnsrnoother').value) + 1
                    }
                }
            }
            function Amount() {
                var Quantity = document.getElementById('txtQuantity');
                var Rate = document.getElementById('txtRate');
                var Amt = document.getElementById('txtAmount');
                if (Rate.value == '') {
                    alert('Enter the Rate');
                    setTimeout(function () { Rate.focus() }, 10);
                    return false;
                }
                if (isNaN(Rate.value)) {
                    alert('Enter numeric Rate');
                    setTimeout(function () { Rate.focus() }, 10);
                    Rate.value = '';
                    return false;
                }
                // return checkQuntity ();
                if (checkQuntity() == true) {
                    Amt.value = ((Rate.value) * (Quantity.value)).toFixed(2);
                    addPODetails();
                }
            }
            function DeleteUnitConfirm() {
                if (confirm("Are you sure you wan`t to delete.")) { return true }
                else { return false }
            }
            function poexists() {
                //debugger 
                var ddlPONo = document.getElementById('ddlPONo').value;
                var dtPODate = document.getElementById('dtPODate_TextBox').value;
                var txtpono = document.getElementById('txtPONo').value;
                var ddlCat = document.getElementById('ddlCategory').value;
                var url = "../tmtAjax/Common_ajax.aspx?action=checkpoexists&potype=" + ddlPONo + "&pono=" + txtpono + "&poCat=" + ddlCat + "&dtpoDate=" + dtPODate;
                sendRequest(url);
                return false;
            }
            function getDefect() {
                var url = '../tmtAjax/Common_ajax.aspx?action=getDefectDetails'
                sendRequest(url);
                return false;
            }
            function DeleteDefect(ID) {
                if (Optype == 1) {
                    alert('Please quit editing mode for deleting.');
                    return false;
                }
                if (DeleteUnitConfirm() == true) {
                    Optype = 2;
                    var url = "../tmtAjax/Master_ajax.aspx?action=DefectDetails&Id=" + ID + "&Optype=" + Optype;
                    sendRequest(url);
                    return false;
                }
            }
            function ddlSelection(tdvalue, ddl) {
                for (i = 0; i < ddl.length; i++) {
                    if (ddl.options[i].text == tdvalue) {
                        ddl.selectedIndex = i;
                    }
                }
            }
            function editDefect(id) {
                var ddlDefPriority = document.getElementById('ddlDefPriority');
                ddlSelection(document.getElementById('tdDefPriority_' + id).innerHTML, ddlDefPriority);
                document.getElementById('dtDefectDate_TextBox').value = document.getElementById('tdDefDate_' + id).innerHTML;
                document.getElementById('txtBusNo').value = document.getElementById('tdBusNo_' + id).innerHTML;
                document.getElementById('txtDriverNo').value = document.getElementById('tdDriverNo_' + id).innerHTML;
                document.getElementById('txtDefectTime').value = document.getElementById('tdDefectTime_' + id).innerHTML;
                document.getElementById('txtDescription').value = document.getElementById('tdDescription_' + id).innerHTML;
                document.getElementById('hdnID').value = id
                Optype = 1;
            }
            function validatedata() {
                ValidateSave();
                var ddlvendor = document.getElementById('ddlvendor');
                var ddlCategory = document.getElementById('ddlCategory');
                var ddlPONo = document.getElementById('ddlPONo');
                var txtpono = document.getElementById('txtPONo');
                var txtOurRefNo = document.getElementById('txtOurRefNo');
                var txtYourRefNo = document.getElementById('txtYourRefNo');
                var hdndetail = document.getElementById('hdndetail');
                if (ddlvendor.value == 0) {
                    alert('Select vendor name');
                    ddlvendor.focus();
                    return false;
                }
                var category = ddlCategory.options[ddlCategory.selectedIndex].text;
                if (category == 'Select') {
                    alert('Select Category');
                    ddlCategory.focus();
                    return false;
                }
                else if (ddlPONo.value == 0) {
                    alert('Select PO name');
                    ddlPONo.focus();
                    return false;
                }
                else if (txtpono.value == '') {
                    alert('Enter PONo.');
                    txtpono.focus();
                    return false;
                }
                else if (IsNumeric(txtpono.value) == false) {
                    alert('please Enter numbers Only.');
                    txtpono.focus();
                    return false;
                }
                else if (hdndetail.value == '') {
                    alert('please  enter item');
                    document.getElementById('txtlfno').focus();
                    return false;
                }
                ValidateSaveother();
            }
            function ValidateSave() {
                var detvalues = '';
                var i = 0;
                var hdnrwcnt = document.getElementById('hdnrwcnt').value;
                for (i = 1; i < hdnrwcnt ; i++) {
                    if (document.getElementById('tdNomenclature_' + i) != null) {
                        var txtlfNo = document.getElementById('tdlfno_' + i).innerHTML;
                        var CodeNo = document.getElementById('tdCodeNo_' + i).innerHTML;
                        var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                        var baserate = document.getElementById('tdbaserate_' + i).innerHTML;
                        var baseqty = document.getElementById('tdbaseqty_' + i).innerHTML;
                        var Quantity = document.getElementById('tdQuantity_' + i).innerHTML;
                        var Rate = document.getElementById('tdRate_' + i).innerHTML;
                        var Amount = document.getElementById('tdAmount_' + i).innerHTML;
                        detvalues = detvalues + txtlfNo + '^' + CodeNo + '^' + Nomenclature + '^' + baserate + '^' + baseqty + '^' + Quantity + '^' + Rate + '^' + Amount + '|';
                    }
                }
                document.getElementById("hdndetail").value = detvalues
            }
            function ValidateSave1() {
                var detvalues = '';
                var i = 0;
                //        var BusNo = document.getElementById('txtBusNo');        
                //        if (BusNo.value == ''){
                //            alert('Bus No. should not be empty')
                //            BusNo.focus();  ,
                //            return false;
                //        }
                var hdnrwcnt = document.getElementById('hdnrwcnt').value;
                var ddlvendor = document.getElementById('ddlvendor').value;
                var ddlPONo = document.getElementById('ddlPONo').value;
                var dtPODate = document.getElementById('dtPODate_TextBox').value;
                var txtOurRefNo = document.getElementById('txtOurRefNo').value;
                var dtOurRefNo = document.getElementById('dtOurRefNo_TextBox').value;
                var txtYourRefNo = document.getElementById('txtYourRefNo').value;
                var dtYourRefNo = document.getElementById('dtYourRefNo_TextBox').value;
                var txtpono = document.getElementById('txtPONo').value;
                var txtPayment = document.getElementById('txtPayment').value;
                var txtDescount = document.getElementById('txtDescount').value;
                var txtFright = document.getElementById('txtFright').value;
                var txtBankCharges = document.getElementById('txtBankCharges').value;
                var txtGoodsent = document.getElementById('txtGoodsent').value;
                var txtDelivery = document.getElementById('txtDelivery').value;
                var txtValidityPeriod = document.getElementById('txtValidityPeriod').value;
                var txtYear = document.getElementById('txtYear').value;
                var txtBCReg = document.getElementById('txtBCReg').value;
                var txtSrNo = document.getElementById('txtSrNo').value;
                var txtAudited = document.getElementById('txtAudited').value;
                var txtAudit_officer = document.getElementById('txtAudit_officer').value;
                var txtCl = document.getElementById('txtCl').value;
                var Date1_TextBox = document.getElementById('Date1_TextBox').value;
                var Date2_TextBox = document.getElementById('Date2_TextBox').value;
                var txtResNo = document.getElementById('txtResNo').value;
                var txtPurchase = document.getElementById('txtPurchase').value;
                var txtBudgetAccount = document.getElementById('txtBudgetAccount').value;
                var txtPreparedby = document.getElementById('txtPreparedby').value;
                var txtCheckedBy = document.getElementById('txtCheckedBy').value;
                var txtIndentRefNo = document.getElementById('txtIndentRefNo').value;
                var txtspdiscount = document.getElementById('txtspdisc').value;
                var txtvat = document.getElementById('txtvat').value;
                var txted = document.getElementById('txted').value;
                var ddlCategory = document.getElementById('ddlCategory').value;
                for (i = 1; i < hdnrwcnt ; i++) {
                    if (document.getElementById('tdNomenclature_' + i) != null) {
                        var txtlfNo = document.getElementById('tdlfno_' + i).innerHTML;
                        var CodeNo = document.getElementById('tdCodeNo_' + i).innerHTML;
                        var Nomenclature = document.getElementById('tdNomenclature_' + i).innerHTML;
                        var Quantity = document.getElementById('tdQuantity_' + i).innerHTML;
                        var Rate = document.getElementById('tdRate_' + i).innerHTML;
                        var Amount = document.getElementById('tdAmount_' + i).innerHTML;
                        detvalues = detvalues + txtlfNo + '^' + CodeNo + '^' + Nomenclature + '^' + Quantity + '^' + Rate + '^' + Amount + '|';
                    }
                }
                if (document.getElementById('hdnID').value != '') { ID = document.getElementById('hdnID').value }
                if (Optype == 0) {
                    //  var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo +  "&PONo=" + txtpono + "&PODate=" + dtPODate  + "&OurRefNo=" + txtOurRefNo + "&dtOurRefNo=" + dtOurRefNo  + "&YourRefNo=" + txtYourRefNo + "&dtYourRefNo=" + dtYourRefNo  +"&Indentdetails=" + detvalues  + "&Optype=" + Optype+"&txtPayment=" + txtPayment  +  "&txtDescount=" + txtDescount  + "&txtFright=" + txtFright   + "&txtBankCharges=" + txtBankCharges  + "&txtGoodsent=" + txtGoodsent   + "&txtDelivery=" + txtDelivery  + "&txtValidityPeriod=" + txtValidityPeriod  +"&txtYear=" + txtYear  + "&txtBCReg=" + txtBCReg  +"&txtSrNo=" + txtSrNo  + "&txtAudited=" + txtAudited  +"&txtCl=" + txtCl  + "&Date1_TextBox=" + Date1_TextBox  +"&Date2_TextBox=" + Date2_TextBox  + "&txtAudit_officer=" + txtAudit_officer  +"&txtResNo=" + txtResNo + "&txtPurchase=" + txtPurchase +"&txtBudgetAccount=" + txtBudgetAccount   + "&txtPreparedby=" + txtPreparedby   +"&txtCheckedBy=" + txtCheckedBy    + "&txtIndentRefNo=" + txtIndentRefNo  + "&txtspdiscount=" + txtspdiscount  + "&txtvat=" + txtvat  + "&txted=" + txted;                         
                    var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo + "&PONo=" + txtpono + "&PODate=" + dtPODate + "&OurRefNo=" + txtOurRefNo + "&dtOurRefNo=" + dtOurRefNo + "&YourRefNo=" + txtYourRefNo + "&dtYourRefNo=" + dtYourRefNo + "&Indentdetails=" + detvalues + "&Optype=" + Optype + "&txtPayment=" + txtPayment + "&txtDescount=" + txtDescount + "&txtFright=" + txtFright + "&txtBankCharges=" + txtBankCharges + "&txtGoodsent=" + txtGoodsent + "&txtDelivery=" + txtDelivery + "&txtValidityPeriod=" + txtValidityPeriod + "&txtYear=" + txtYear + "&txtBCReg=" + txtBCReg + "&txtSrNo=" + txtSrNo + "&txtAudited=" + txtAudited + "&txtCl=" + txtCl + "&Date1_TextBox=" + Date1_TextBox + "&Date2_TextBox=" + Date2_TextBox + "&txtAudit_officer=" + txtAudit_officer + "&txtResNo=" + txtResNo + "&txtPurchase=" + txtPurchase + "&txtBudgetAccount=" + txtBudgetAccount + "&txtPreparedby=" + txtPreparedby + "&txtCheckedBy=" + txtCheckedBy + "&txtIndentRefNo=" + txtIndentRefNo + "&txtspdiscount=" + txtspdiscount + "&txtvat=" + txtvat + "&txted=" + txted + "&ddlCategory=" + ddlCategory;
                }
                else {
                    var url = "../store/Ajaxstore.aspx?action=POMaster&Id=" + ID + "&vendorId=" + ddlvendor + "&PONoId=" + ddlPONo + "&PODate=" + dtPODate + "&OurRefNo=" + txtOurRefNo + "&OurRefNo=" + dtOurRefNo + "&YourRefNo=" + txtYourRefNo + "&YourRefNo=" + dtYourRefNo + "&Indentdetails=" + detvalues + "&Optype=" + Optype;
                    Optype = 0;
                }
                //         var defId  = '<%=request.querystring("IndNo") %>'     
            //        alert(defId);
            sendRequest(url);
        }
        function Clean() {
            window.location.href = "po_master.aspx";
        }
        function ajaxFunction() {
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = handleresponse
        }
        ajaxFunction();
        function sendRequest(url) {
            //debugger
            ajaxFunction();
            url = url + '&t=' + new Date();
            xmlHttp.open("GET", url);
            xmlHttp.send(null);
        }
        function handleresponse() {
            //debugger
            if (xmlHttp.readyState == 4) {
                resp = xmlHttp.responseText;
                if (resp.indexOf('Add') != -1) {
                    alert('Data Added Successfully.');
                    //getDefect();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Edit') != -1) {
                    alert('Data Updated Successfully.');
                    getDefect();
                    Clean();
                    return false;
                }
                else if (resp.indexOf('Duplicate') != -1) {
                    alert('This Po alredy entered');
                    setTimeout(function () { document.getElementById('txtPONo').focus() }, 10);
                    return false;
                }
            }
        }
        function addIndentReq() {
        }
        function getitemname() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    document.getElementById('txtNomenclature').value = resp;
                }
            }
            var txtCodeNo = document.getElementById('txtCodeNo').value;
            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=Nomunclature&CodeNo=" + txtCodeNo, true);
            xmlHttp.send(null);
        }
        function Select() {
            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtItemName');
                    objddl1.value = resultStr;
                    var x = document.getElementById('Select1');
                    x.style.display = "none";
                    document.getElementById('txtItemName').focus();
                    return false;
                    //alert(resultStr)
                }
            }
        }
        function emptytext() {
            if (document.getElementById('txtPartNo').value != '' && document.getElementById('txtItemName').value != '') {
                document.getElementById('txtPartNo').value = '';
                document.getElementById('txtItemName').value = '';
            }
        }
        function emptytextpart() {
            if (document.getElementById('txtsubrack').value != '' && document.getElementById('txtItemName').value != '') {
                document.getElementById('txtsubrack').value = '';
                document.getElementById('txtItemName').value = '';
            }
        }
        function display() {
            var x = document.getElementById('Select1');
            x.style.display = "none";
        }
        function Fromcombo2() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');
                    document.getElementById('txtPartNo').value = ele1[2];
                    document.getElementById('txtsubrack').value = ele1[3];
                }
            }
            var itemname = document.getElementById('txtItemName').value;
            var txtsubrack = document.getElementById('txtsubrack').value;
            var partno = document.getElementById('txtPartNo').value;
            xmlHttp.open("GET", "../store/AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&subrack=" + txtsubrack + "&partno=" + partno, true);
            xmlHttp.send(null);
        }
        ///////////   for removing blaak spaces 
        String.prototype.trim = function () {
            return this.replace(/^\s+|\s+$/g, "");
        }
        function IsNumeric(strString) {
            var ValidChars = "0123456789.";
            var Char;
            for (i = 0; i < strString.length; i++) {
                Char = strString.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    return false;
                }
            }
            return true;
        }
        function validateqty() {
            if (document.getElementById("txtReqQty").value.length > 0) {
                if (IsNumeric(document.getElementById("txtReqQty").value)) {
                    addEmpDetails();
                }
                else {
                    alert("Enter Proper Value");
                    document.getElementById("txtReqQty").focus();
                }
            }
            else {
                alert("Enter Proper Value");
                document.getElementById("txtReqQty").focus();
            }
        }
        ///////////////////  for filteration ///////////////////////////////////////
        function Select() {
            var resultStr = "";
            objddl2 = document.getElementById('Select1');
            for (var i = 0; i < objddl2.options.length; i++) {
                if (objddl2.options[i].selected) {
                    resultStr += (objddl2.options[i].text);
                    var objddl1 = document.getElementById('txtNomenclature');
                    objddl1.value = resultStr;
                    var x = document.getElementById('Select1');
                    x.style.display = "none";
                    document.getElementById('txtNomenclature').focus();
                    return false;
                    //alert(resultStr)
                }
            }
        }
        function itemsearch() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    resp = xmlHttp.responseText;
                    if (resp == 0) {
                        document.getElementById("Select1").style.display = 'none';
                        return false;
                    }
                    var ele = resp.split("!");
                    while (document.getElementById("Select1").options.length > 0)
                        document.getElementById("Select1").options.remove(document.getElementById("Select1").options.length - 1);
                    if (document.getElementById('txtNomenclature').value != "" || document.getElementById('txtlfno').value != "" || document.getElementById('txtCodeNo').value != "") {
                        for (var i = 0; i < ele.length; i++) {
                            var temp = document.getElementById("Select1")
                            temp.style.display = '';
                            temp.size = ele.length;
                            newOpt = document.createElement("option");
                            document.getElementById("Select1").options.add(newOpt);
                            newOpt.value = ele[i];
                            newOpt.text = ele[i];
                            if (document.getElementById('txtNomenclature').value == ele[i]) {
                                // temp.style.display="none";				               
                                // return false;
                            }
                            if (ele[i] == "0") {
                                //temp.style.display="none";				               
                                //  return false;
                            }
                        }
                    }
                    else {
                        var temp = document.getElementById("Select1")
                        temp.size = 0
                        //temp.style.display="none";
                        temp.style.display = '';
                    }
                }
            }
            var lfno = document.getElementById('txtlfno').value;
            var partno = document.getElementById('txtCodeNo').value;
            if (lfno == "" && partno == "") {
                if (document.getElementById('txtNomenclature').value.length >= 3) {
                    url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById('txtNomenclature').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                    xmlHttp.open("GET", url, true);
                    xmlHttp.send(null);
                }
                else {
                    // document.getElementById("<%= Select1.clientID %>").options.length = 0;
                    document.getElementById("<%= Select1.clientID %>").style.display = 'none'
                }
            }
            else {
                url = "../store/AjaxStore.aspx?Action=itemnamedeptwise&itemid=''&item=" + document.getElementById('txtNomenclature').value + "&lfno=" + lfno + "&partno=" + partno + '&t=' + new Date();
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
        }
        function emptytext() {
            if (document.getElementById('txtCodeNo').value != '' && document.getElementById('txtNomenclature').value != '') {
                document.getElementById('txtCodeNo').value = '';
                document.getElementById('txtNomenclature').value = '';
            }
        }
        function emptytextpart() {
            if (document.getElementById('txtlfno').value != '' && document.getElementById('txtNomenclature').value != '') {
                document.getElementById('txtlfno').value = '';
                document.getElementById('txtNomenclature').value = '';
            }
        }
        function fillitem() {
            objddl2 = document.getElementById('Select1');
            if (document.getElementById("txtNomenclature").value == '' && objddl2.options.length > 0) {
                document.getElementById("txtNomenclature").value = objddl2.options[0].text;
                document.getElementById('txtbaserate').focus();
                objddl2.style.display = 'none';
            }
        }
        function check1() {
            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() != '') {
                Fromcombo2();
            }
            else {
                setTimeout(function () { document.getElementById('txtNomenclature').focus() }, 10);
            }
            return false;
        }
        function checkQuntity() {
            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() == '') {
                setTimeout(function () { document.getElementById('txtNomenclature').focus() }, 10);
                return false;
            }
            else {
                var Quantity = document.getElementById('txtQuantity');
                if (Quantity.value == '') {
                    alert('Enter the Quntity');
                    setTimeout(function () { Quantity.focus() }, 10);
                    return false;
                }
                if (IsNumeric(Quantity.value) == false) {
                    alert('Enter numeric Quantity');
                    setTimeout(function () { Quantity.focus() }, 10);
                    Quantity.value = '';
                    return false;
                }
            }
            return true;
        }
        function calculate() {
            var str = document.getElementById('txtNomenclature').value;
            if (str.trim() == '') {
                setTimeout(function () { document.getElementById('txtNomenclature').focus() }, 10);
                return false;
            }
            else {
                var baserate = document.getElementById('txtbaserate');
                var baseQuantity = document.getElementById('txtbaseqty');
                if (baserate.value == '') {
                    alert('Enter the Base Rate');
                    setTimeout(function () { baserate.focus() }, 10);
                    return false;
                }
                if (IsNumeric(baserate.value) == false) {
                    alert('Enter Numbers Only');
                    setTimeout(function () { baserate.focus() }, 10);
                    baserate.value = '';
                    return false;
                }
                if (baseQuantity.value == '') {
                    alert('Enter the Quntity');
                    setTimeout(function () { baseQuantity.focus() }, 10);
                    return false;
                }
                if (IsNumeric(baseQuantity.value) == false) {
                    alert('Enter numeric Quantity');
                    setTimeout(function () { baseQuantity.focus() }, 10);
                    baseQuantity.value = '';
                    return false;
                }
                document.getElementById('txtRate').value = (parseFloat(baserate.value) / parseFloat(baseQuantity.value)).toFixed(2);
            }
        }
        function Fromcombo2() {
            var xmlHttp;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e) {
                // Internet Explorer
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    catch (e) {
                        alert("Your browser does not support AJAX!");
                        return false;
                    }
                }
            }
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4) {
                    resp = ""
                    resp = xmlHttp.responseText;
                    var ele1 = resp.split('|');
                    // document.getElementById('txtbqty').value =ele1[0];
                    //document.getElementById('txtRate').value =ele1[1];
                    document.getElementById('txtCodeNo').value = ele1[2];
                    document.getElementById('txtlfno').value = ele1[3];
                }
            }
            var itemname = document.getElementById('txtNomenclature').value;
            var lfno = document.getElementById('txtlfno').value;
            var partno = document.getElementById('txtCodeNo').value;
            xmlHttp.open("GET", "AjaxStore.aspx?Action=itemqty&itemid=" + itemname + "&lfno=" + lfno + "&partno=" + partno, true);
            //xmlHttp.open("GET","Ajaxstore.aspx?Action=itemqty&itemid="+itemname,true);
            xmlHttp.send(null);
        }
        function setfocus() {
            document.getElementById('txtlfno').focus();
        }
        </script>
        <script>
        
            $("#txtref_asrtu").autocomplete(
                   
		{
		  source: [<% =strref_asrtu  %>]
		}
	);
            $("#txtspdisc").autocomplete(
              
		{
		  source:  [<% =strspdisc  %>]
		}
	);
        $("#ddlvendor").autocomplete(
               
		{
		   source: [<% =strVendor  %>]
		}
	);
        </script>
</asp:Content>
