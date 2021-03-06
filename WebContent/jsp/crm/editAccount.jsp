<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<link rel="stylesheet" type="text/css"
	href="../../themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../../themes/icon.css" />
<link rel="stylesheet" type="text/css" href="../../css/global.css" />

<script type="text/javascript" src="../../js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/global.js"></script>
<script type="text/javascript" src="../../js/locale/easyui-lang-<%=(String)session.getAttribute("locale")%>.js"></script>

<script type="text/javascript">
	function save() {
      baseSave("Account");
	}

	function saveClose() {
		baseSaveClose("Account");
	}
	
	function cancel() {
		baseCancel("Account");
	}

	function billMap() {
	    address = $("input[name='account.bill_country']").val() + " "
				+ $("input[name='account.bill_state']").val() + " "
				+ $("input[name='account.bill_city']").val() + " "
				+ $("input[name='account.bill_street']").val();
	    locale = '<%=(String)session.getAttribute("locale")%>'
	    if (locale == "zh_CN"){
		    window.open("http://ditu.google.com/?ie=UTF8&hl=zh-CN&q=" + address,
				"_blank");
	    } else {
			window.open("https://maps.google.com/maps?q=" + address,
				"_blank");	    	
	    }
	}

	function shipMap() {
	    address = $("input[name='account.ship_country']").val() + " "
				+ $("input[name='account.ship_state']").val() + " "
				+ $("input[name='account.ship_city']").val() + " "
				+ $("input[name='account.ship_street']").val();
	    locale = '<%=(String)session.getAttribute("locale")%>'
	    if (locale == "zh_CN"){
		    window.open("http://ditu.google.com/?ie=UTF8&hl=zh-CN&q=" + address,
				"_blank");
	    } else {
			window.open("https://maps.google.com/maps?q=" + address,
				"_blank");	    	
	    }
	}
	
	function copyAddress() {
		if ($('#copy_checkbox').attr('checked')) {
			$("input[name='account.ship_street']").attr("value",
					$("input[name='account.bill_street']").val());
			$("input[name='account.ship_street']").attr("disabled", "disabled");
			$("input[name='account.ship_city']").attr("value",
					$("input[name='account.bill_city']").val());
			$("input[name='account.ship_city']").attr("disabled", "disabled");
			$("input[name='account.ship_state']").attr("value",
					$("input[name='account.bill_state']").val());
			$("input[name='account.ship_state']").attr("disabled", "disabled");
			$("input[name='account.ship_postal_code']").attr("value",
					$("input[name='account.bill_postal_code']").val());
			$("input[name='account.ship_postal_code']").attr("disabled",
					"disabled");
			$("input[name='account.ship_country']").attr("value",
					$("input[name='account.bill_country']").val());
			$("input[name='account.ship_country']")
					.attr("disabled", "disabled");
		} else {
			$("input[name='account.ship_street']").removeAttr("disabled");
			$("input[name='account.ship_city']").removeAttr("disabled");
			$("input[name='account.ship_state']").removeAttr("disabled");
			$("input[name='account.ship_postal_code']").removeAttr("disabled");
			$("input[name='account.ship_country']").removeAttr("disabled");
		}
	}

	$(document).ready(
			function() {
				$('#assignedToID').combogrid('setValue',
						'<s:property value="assignedToID"/>');
				$('#assignedToID').combogrid('setText',
						'<s:property value="assignedToText"/>');
				$('#managerID').combogrid('setValue',
						'<s:property value="managerID"/>');
				$('#managerID').combogrid('setText',
						'<s:property value="managerText"/>');
				$('#ownerID').combogrid('setValue',
						'<s:property value="ownerID"/>');
				$('#ownerID').combogrid('setText',
						'<s:property value="ownerText"/>');
				if ($("#seleteIDs").val() != "") {
					$("input:checkbox[name=massUpdate]")
							.css("display", 'block');
					$('#tt').tabs('close', '<s:text name='tab.relations'/>');
				}
				if ($("#id").val() == "") {
					$('#tt').tabs('close', '<s:text name='tab.relations'/>');
					if ($("#seleteIDs").val() == "") {
						$("#addObjectForm").form('validate');
					}
				}
				if ($("#saveFlag").val() == "true") {
					$.messager.show({
						title : '<s:text name="message.title" />',
						msg : '<s:text name="message.save" />',
						timeout : 5000,
						showType : 'slide'
					});
					$("#saveFlag").val("");
				}
			})
</script>
</head>

<body>
	<div id="page-wrap">
		<s:include value="../header.jsp" />
		<s:include value="../menu.jsp" />	
		<div id="feature">
		    <s:include value="../navigation.jsp" />
			<div id="shortcuts" class="headerList">
			    <b style="white-space: nowrap; color: #444;"><s:text name="title.action" />:&nbsp;&nbsp;</b> 
				<span> <span style="white-space: nowrap;"> <a id="save_accept_btn" href="#"
						class="easyui-linkbutton" iconCls="icon-save-accept" onclick="save()"
						plain="true"><s:text name="button.save" /></a>
				</span>			
				<span> <span style="white-space: nowrap;"> <a id="save_go_btn" href="#"
						class="easyui-linkbutton" iconCls="icon-save-go" onclick="saveClose()"
						plain="true"><s:text name="button.saveClose" /></a>
				</span> <span style="white-space: nowrap;"> <a id="cancel_btn" href="#"
						class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()"
						plain="true"><s:text name="button.cancel" /></a>
				</span>
				<s:if test="account!=null && account.id!=null">
				    <span style="white-space: nowrap;"><a
						href="javascript:void(0)" id="mtmt" class="easyui-menubutton"
						data-options="menu:'#mtm1',iconCls:'icon-more'"><s:text
								name='menu.toolbar.more.title' /></a>
						<div id="mtm1" style="width: 150px;">
						  <div data-options="iconCls:'icon-import'" onClick="openwindow2('/crm/showChangeLogPage.action?entity=Account&recordID=' + '<s:property value="account.id" />',750,500)">
							<s:text name='menu.item.changeLog.title' />
						  </div>
						</div>
					  </span>
				 </s:if> 				
				</span>
			</div>

			<div id="feature-title">
				<s:if test="account!=null && account.id!=null">
					<h2>
						<s:text name="title.updateAccount" />
					</h2>
				</s:if>
				<s:else>
				  <s:if test="seleteIDs!=null && seleteIDs!= ''">
					<h2>
						<s:text name="title.massUpdateAccount" />
					</h2>
				  </s:if>
				  <s:else>				    
					<h2>
						<s:text name="title.createAccount" />
					</h2>
				  </s:else>	
				</s:else>
			</div>

			<div id="feature-content">
				<s:form id="addObjectForm" validate="true" namespace="/jsp/crm"
					method="post">
					<s:hidden id="id" name="account.id" value="%{account.id}" />
					<s:hidden id="saveFlag" name="saveFlag"/>
			        <s:hidden name="relationKey" id="relationKey" value="%{relationKey}" />	
			        <s:hidden name="relationValue" id="relationValue" value="%{relationValue}" />
			        <s:hidden id="seleteIDs" name="seleteIDs" value="%{seleteIDs}" />
			        					
					<table style="" cellspacing="10" cellpadding="0" width="100%">
						<s:actionerror />
						<s:if test="hasFieldErrors()">
							<tr>
								<td align="left" colspan="4"><s:actionerror /> <s:iterator
										value="fieldErrors" status="st">
										<s:if test="#st.index  == 0">
											<s:iterator value="value">
												<font color="red"> <s:property escape="false" /></font>
											</s:iterator>
										</s:if>
									</s:iterator></td>
							</tr>
						</s:if>
					</table>

					<table style="padding: 10px;" cellspacing="10" cellpadding="0"
						width="100%">
						<tr>
						    <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="name"/></td>
							<td class="td-label"><label class="record-label"><s:text
										name="entity.name.label"></s:text>：</label></td>
							<td class="td-value"><input name="account.name"
								class="easyui-validatebox record-value"
								data-options="required:true"
								value="<s:property value="account.name" />" /></td>
				            <td class="td-mass-update"><input id="massUpdate"
								name="massUpdate" type="checkbox" class="massUpdate" value="owner"/></td>
							<td class="td-label"><label class="record-label"><s:text
										name="entity.owner.label"></s:text>：</label></td>
							<td class="td-value"><select id="ownerID"
								class="easyui-combogrid record-value" name="ownerID"
								style="width: 180px;"
								data-options="  
					            panelWidth:520,  
					            idField:'id',  
					            textField:'name',  
					            url:'<s:url action="listUser" namespace="/jsp/system"/>',
		                        loadMsg: '<s:text name="datagrid.loading" />',
		                        pagination : true,
		                        pageSize: 10,
		                        pageList: [10,30,50],
				                fit: true,
					            mode:'remote',
					            columns:[[  
					                {field:'id',title:'<s:text name="entity.id.label" />',width:60},  
					                {field:'name',title:'<s:text name="entity.name.label" />',width:100},  
					                {field:'title',title:'<s:text name="entity.title.label" />',width:120},  
					                {field:'department',title:'<s:text name="entity.department.label" />',width:100},
					                {field:'status.name',title:'<s:text name="entity.status.label" />',width:100}   
					            ]]  
					        ">
							</select></td>
						</tr>
					</table>

					<div id="tt" class="easyui-tabs">
						<div title="<s:text name='tab.overview'/>" style="padding: 10px;">
							<div class="section-header">
								<span><s:text name="span.contact" /></span>
							</div>
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="email"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.email.label"></s:text>：</label></td>
									<td class="td-value"><input name="account.email"
										class="easyui-validatebox record-value"
										data-options="validType:'email'"
										value="<s:property value="account.email" />" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="office_phone.label"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.office_phone.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.office_phone" cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="website"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.website.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.website"
											cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="fax"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.fax.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.fax"
											cssClass="record-value" /></td>
								</tr>
							</table>

							<div class="section-header">
								<span><s:text name="span.billing_address" /> (<a href="#" onclick="billMap()"><s:text name="link.map" /></a>)</span>
							</div>
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="bill_street"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.street.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.bill_street" cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="bill_city"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.city.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.bill_city"
											cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="bill_state"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.state.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.bill_state" cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="bill_postal_code"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.postal_code.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.bill_postal_code" cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="bill_country"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.country.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.bill_country" cssClass="record-value" /></td>
						            <td class="td-mass-update"></td>
									<td class="td-label"></td>
									<td class="td-value"></td>
								</tr>
							</table>

							<div class="section-header">
								<span><s:text name="span.shipping_address" /> (<a href="#" onclick="shipMap()"><s:text name="link.map" /></a>)</span>
							</div>
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ship_street"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.street.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.ship_street" cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ship_city"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.city.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.ship_city"
											cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ship_state"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.state.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.ship_state" cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ship_postal_code"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.postal_code.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.ship_postal_code" cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ship_country"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.country.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.ship_country" cssClass="record-value" /></td>
						            <td class="td-mass-update"></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.copyAddress.label" />：</label></td>
									<td class="td-value"><input id="copy_checkbox"
										name="copy_checkbox" type="checkbox" onclick="copyAddress();" />
									</td>
								</tr>
							</table>

							<div class="section-header">
								<span><s:text name="span.other_info" /></span>
							</div>
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="account_type"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.type.label"></s:text>：</label></td>
									<td class="td-value"><s:select name="typeID" list="types"
											listKey="id" listValue="label" cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="industry"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="menu.industry.title"></s:text>：</label></td>
									<td class="td-value"><s:select name="industryID"
											list="industries" listKey="id" listValue="label"
											cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="annual_revenue"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.annual_revenue.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.annual_revenue" cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="market_value"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.market_value.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.market_value"
											cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="sic_code"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.sic_code.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.sic_code"
											cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ticket_symbol"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.ticket_symbol.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield
											name="account.ticket_symbol" cssClass="record-value" /></td>
								</tr>
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="manager"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.manager.label"></s:text>：</label></td>
									<td class="td-value">
									<select id="managerID"
										class="easyui-combogrid record-value" name="managerID"
										style="width: 180px;"
										data-options="  
							            panelWidth:520,  
							            idField:'id',  
							            textField:'name',  
							            url:'listAccount.action',
				                        loadMsg: '<s:text name="datagrid.loading" />',
				                        pagination : true,
				                        pageSize: 10,
				                        pageList: [10,30,50],
						                fit: true,
							            mode:'remote',
							            columns:[[  
							                {field:'id',title:'<s:text name="entity.id.label" />',width:60},  
							                {field:'name',title:'<s:text name="entity.name.label" />',width:100},  
							                {field:'office_phone',title:'<s:text name="entity.office_phone.label" />',width:120},  
							                {field:'email',title:'<s:text name="entity.email.label" />',width:100},
							                {field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:100}  
							            ]]  
							        ">
									</select></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="ownship"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.ownship.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.ownship"
											cssClass="record-value" /></td>
								</tr>

								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="rating"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.rating.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.rating"
											cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="employees"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="account.employees.label"></s:text>：</label></td>
									<td class="td-value"><s:textfield name="account.employees"
											cssClass="record-value" /></td>											
								</tr>	
								
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="assigned_to"/></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.assigned_to.label"></s:text>：</label></td>
									<td class="td-value"><select id="assignedToID"
										class="easyui-combogrid record-value" name="assignedToID"
										style="width: 180px;"
										data-options="  
							            panelWidth:520,  
							            idField:'id',  
							            textField:'name',  
							            url:'<s:url action="listUser" namespace="/jsp/system"/>',
				                        loadMsg: '<s:text name="datagrid.loading" />',
				                        pagination : true,
				                        pageSize: 10,
				                        pageList: [10,30,50],
						                fit: true,
							            mode:'remote',
							            columns:[[  
							                {field:'id',title:'<s:text name="entity.id.label" />',width:60},  
							                {field:'name',title:'<s:text name="entity.name.label" />',width:100},  
							                {field:'title',title:'<s:text name="entity.title.label" />',width:120},  
							                {field:'department',title:'<s:text name="entity.department.label" />',width:100},
							                {field:'status.name',title:'<s:text name="entity.status.label" />',width:100}   
							            ]]  
							        ">
									</select></td>
						            <td class="td-mass-update"></td>
									<td class="td-label"></td>
									<td class="td-value"></td>
								</tr>															
							</table>
						</div>
						
						<div title="<s:text name='tab.details'/>" style="padding: 10px;">
							<div class="section-header">
								<span><s:text name="span.description" /></span>
							</div>						
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="description"/></td>
									<td class="td-label" valign="top"><label
										class="record-label"><s:text
												name="entity.description.label"></s:text>：</label></td>
									<td class="td-value" valign="top"><s:textarea
											name="account.description" rows="20" cssStyle="width:450px;"
											cssClass="record-value" /></td>
						            <td class="td-mass-update"><input id="massUpdate"
										name="massUpdate" type="checkbox" class="massUpdate" value="notes"/></td>
									<td class="td-label" valign="top"><label
										class="record-label"><s:text
												name="entity.notes.label"></s:text>：</label></td>
									<td class="td-value" valign="top"><s:textarea
											name="account.notes" rows="20" cssStyle="width:450px;"
											cssClass="record-value" /></td>
								</tr>
							</table>

							<div class="section-header">
								<span><s:text name="span.system_info" /></span>
							</div>
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
						            <td class="td-mass-update"></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.createdBy.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="createdBy" /></label></td>
						            <td class="td-mass-update"></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.createdOn.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="createdOn" /></label></td>
								</tr>
								<tr>
						            <td class="td-mass-update"></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.updatedBy.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="updatedBy" /></label></td>
						            <td class="td-mass-update"></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.updatedOn.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="updatedOn" /></label></td>
								</tr>
								<tr>
						            <td class="td-mass-update"></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.id.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="id" /></label></td>
						            <td class="td-mass-update"></td>
									<td class="td-label"></td>
									<td class="td-value"></td>
								</tr>
							</table>
						</div>

						<div title="<s:text name='tab.relations'/>" id="relations" style="padding: 10px;">
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
									<td width="20%" valign="top">
										<div class="easyui-accordion" style="width: 200px;">
											<div title="<s:text name="menu.sales.title"/>" style="overflow: auto; padding: 10px;"
												selected="true">
												<a
													href="filterContactPage.action?filter_key=account.id&id=<s:property value="account.id" />&createKey=accountID&removeKey=Account"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.contacts.title" /></label></a><br /> <a
													href="filterOpportunityPage.action?filter_key=account.id&id=<s:property value="account.id" />&createKey=accountID&removeKey=Account"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.opportunities.title" /></label></a><br /> <a
													href="filterLeadPage.action?filter_key=account.id&id=<s:property value="account.id" />&createKey=accountID&removeKey=Account"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.leads.title" /></label></a><br /> <a
													href="filterAccountPage.action?filter_key=manager.id&id=<s:property value="account.id" />&createKey=managerID&removeKey=Account"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.members.title" /></label></a><br /> <a
													href="relateAccountDocumentPage.action?id=<s:property value="account.id" />"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.documents.title" /></label></a>
											</div>
											<div title="<s:text name="menu.support.title"/>" style="overflow: auto; padding: 10px;">
												<a
													href="filterCasePage.action?filter_key=account.id&id=<s:property value="account.id" />&createKey=accountID&removeKey=Account"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.cases.title" /></label></a>														
											</div>
											<div title="<s:text name="menu.activities.title"/>" style="overflow: auto; padding: 10px;">
												<a
													href="filterTaskPage.action?filter_key=related_record&id=<s:property value="account.id" />&moreFilterKey=relationKey&moreFilterValue=Account&createKey=relationValue&removeKey=Account"
													target="contentFrame"><label
													class="record-value menuLink"><s:text
															name="menu.tasks.title" /></label></a>														
											</div>											
										</div>
									</td>
									<td width="80%" valign="top"><Iframe name="contentFrame"
											id="contentFrame" scrolling="no" frameborder="0" width="100%"
											height="390"></iframe></td>
								</tr>
							</table>
						</div>

					</div>

				</s:form>
			</div>
		</div>
		<s:include value="../footer.jsp" />
	</div>
</body>
</html>



