<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
	<script language="javascript">
                var status = 1;

                function showStatus() {
                        if (status > 3)
                                return false;

                        var newText1='Starting up. Please wait...';
                        var newText2='Configuring server. Please wait...';
                        var newText3='Loading application. Please wait...';

                        var outputText=eval('newText'+status);

                        if (document.layers){
                                name='outputStatus';
                                document.layers[name].document.open();
                                document.layers[name].document.write(outputText);
                                document.layers[name].document.close();
                        }
                        else
                                document.all.outputStatus.innerHTML = 
outputText;

                        status++;
                        setInterval("showStatus()",700)
                }

                window.onload = showStatus;

        </script>

</head>

<body>
<H1>Your Magic numbers</H1>
<P>It will take us a little while to calculate your ten magic numbers. 
It takes a lot of work to find numbers that truly fit your 
personality. So relax for a minute or so while we do the hard 
work for you.</P>
<H2>We are sure you will agree it was worth the short wait!</H2>
<cfflush>

<cfflush interval=10>
<!--- Delay Loop to make is seem harder --->


<!--- Now slowly output 10 random numbers --->
<cfloop index="Myindex" from="1" to="10" step="1">
  <cfloop index="randomindex" from="1" to="1000" step="1">
    <cfset random=rand()>
  </cfloop>
  <cfoutput>
    Magic number number #Myindex# is:&nbsp;&nbsp;#RandRange( 
100000, 999999)#<br><br>
  </cfoutput>
</cfloop>

<strong>Status:</strong><br>

<DIV ID="outputStatus" style="position: absolute; ">
</DIV>
<br><Br>

<CFLOOP index="TEST" from="1" to="15">
	<CFSET TEST_RANDOM = RandRange(1,15)>
	<cfoutput>#TEST_RANDOM#</cfoutput><br>
</CFLOOP>

</body>
</html>
