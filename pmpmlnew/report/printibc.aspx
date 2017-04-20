<%@ Page Language="VB" AutoEventWireup="false" CodeFile="printibc.aspx.vb" Inherits="KDMT.printibc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <style media="Print" type="text/css">
        .ctrl
        {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Literal ID="htmlchallan" runat="server"></asp:Literal>
    <div>
        <table align="center">
            <tr>
                <td colspan="2" align="center">
                    <span><b>IBC - INTIMATION</b> </span>
                </td>
            </tr>
            <tr style="height: 100px">
                <td>
                    &nbsp;
                </td>
                <td>
                    <span>PMPML
                        <br />
                        office of the controller of the stores,<br />
                        swargate,pune 411 037</span>
                </td>
            </tr>
            <tr>
                <td>
                    <span>(1) Chief Accounts & Finance Officer</span>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <span>Sub : <b>Negotiating of retiring documents through bank - essential details
                        <br />
                        required by accountants Department</b></span>
                </td>
            </tr>
            <br />
            <br />
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <span>(1) Name of the Bank/Branch</span>
                            </td>
                            <td>
                                <asp:Label ID="lblbank" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(2) Intimation No & Date</span>
                            </td>
                            <td>
                                <asp:Label ID="lblintimationno" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(3) Intimation received on</span>
                            </td>
                            <td>
                                <asp:Label ID="lblintrecon" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(4) Amount involved </span>
                            </td>
                            <td>
                                <asp:Label ID="lblamtinvolved" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(5) Last date Of payment </span>
                            </td>
                            <td>
                                <asp:Label ID="lbllastdate" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(6) Details regarding material</span>
                            </td>
                            <td>
                                <asp:Label ID="lblmaterial_detail" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(a) Sender Name</span>
                            </td>
                            <td>
                                <asp:Label ID="lblsender" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(b) Invoice No /Date,Amount</span>
                            </td>
                            <td>
                                <asp:Label ID="lblinvoice" runat="server"></asp:Label>
                            </td>
                        </tr>
                        
                         <tr>
                            <td>
                                <span>(c) LR No / LR Date</span>
                            </td>
                            <td>
                                <asp:Label ID="lblLrnoLrdate" runat="server"></asp:Label>
                            </td>
                        </tr>
                       <tr>
                            <td>
                                <span>(d) Amount to be released as per terms
                                    <br />
                                    by bank.</span>
                            </td>
                            <td>
                                <asp:Label ID="lblreleaseamt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(e) Terms of payment accepted by PMPML</span>
                            </td>
                            <td>
                                <asp:Label ID="lblpaymentterms" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(f) Bank commission charge to be
                                    <br />
                                    borne by - </span>
                            </td>
                            <td>
                                <asp:Label ID="lblbccharges" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(g) Other details if any </span>
                            </td>
                            <td>
                                <asp:Label ID="lblothers" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                                <span>(h) Rates as per purchase order </span>
                            </td>
                            <td>
                                <asp:Label ID="lblratespurordr" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(i) Change in Rates </span>
                            </td>
                            <td>
                                <asp:Label ID="lblchngrate" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(j) Quantity Demand </span>
                            </td>
                            <td>
                                <asp:Label ID="lblqtydmnd" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>(k) Total Qty Received </span>
                            </td>
                            <td>
                                <asp:Label ID="lbltotreceived" runat="server"></asp:Label>
                            </td>
                        </tr> --%>
                    </table>
                </td>
            </tr>
            <br />
            <br />
            <tr style="height: 100px">
                <td colspan="2">
                    <span>You are requested to please do the further needful urgently </span>
                </td>
            </tr>
            <tr style="height: 150px">
                <td>
                </td>
                <td>
                    <span>STORES OFFICER
                        <br />
                        PMPML</span>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
