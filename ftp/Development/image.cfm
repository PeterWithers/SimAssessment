<CFHEADER NAME="Pragma" VALUE="no-cache">
<CFIF #ParameterExists(CGI.HTTP_REFERER)# AND #ParameterExists(IMG_FILE)#>
	<CFIF #CGI.HTTP_REFERER# contains #CGI.HTTP_HOST# AND
		  #REFind("(.tmp|.gif|.jpg|.jpeg|.png|.bmp)",IMG_FILE)#>
		<CFCONTENT TYPE="image/gif" DELETEFILE="YES" FILE="#IMG_FILE#">
	</CFIF>
</CFIF>