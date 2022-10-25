//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 30/09/22, 13:31:44
// ----------------------------------------------------
// Method: MGRAPH_Post_Send_Mail
// Description
// 
//
// Parameters
// $0 - Object - Response
// $1 - Object - params { clientId?: string, authParams?: object, userId: string, body: object / string, type: string }
// ----------------------------------------------------

var $0; $vo_response; $1; $vo_params : Object

var $vt_endpoint : Text
var $vc_headers : Collection

$vo_response:=New object:C1471

If (Count parameters:C259>0)
	$vo_params:=$1
	
	If ((OB Is defined:C1231($vo_params; "clientId")) | (OB Is defined:C1231($vo_params; "authParams")))
		
		$vt_message:=UTIL_Check_Mandatory_Props($vo_params; New collection:C1472("body"; "type"))
		
		If ($vt_message="")
			
			If (OB Is defined:C1231($vo_params; "userId"))
				$vt_endpoint:="users/"+$vo_params.userId+"/sendMail"
			Else 
				$vt_endpoint:="me/sendMail"
			End if 
			
			$vc_headers:=New collection:C1472
			$vc_headers.push(New object:C1471("name"; "Content-Type"; "value"; $vo_params.type))
			
			If (OB Is defined:C1231($vo_params; "clientId"))
				$vo_response:=MGRAPH_Make_Request($vo_params.clientId; $vt_endpoint; HTTP POST method:K71:2; New collection:C1472; $vc_headers; $vo_params.body)
			Else 
				$vo_response:=MGRAPH_Make_Request($vo_params.authParams; $vt_endpoint; HTTP POST method:K71:2; New collection:C1472; $vc_headers; $vo_params.body)
			End if 
			
		Else 
			$vo_response.status:=0
			$vo_response.error:=$vt_message
		End if 
	Else 
		$vo_response.status:=0
		$vo_response.error:="You must provide either clientId or authParams"
	End if 
Else 
	$vo_response.status:=0
	$vo_response.error:="Mandatory parameter $1 not passed"
End if 

$0:=$vo_response
