<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<CFQUERY NAME="qTest" DATASOURCE="sim_assess">
select name, sum(value) as value
from new_goal_alignment2
group by name
</CFQUERY>

<cfoutput>
<!--- <cfloop query="qTest">
#qTest.name# - -#qTest.value#<br>
</cfloop>
<cfgraph type = "line"
  query = "qTest"
  valueColumn = "value"
  itemColumn = "name"
  scaleFrom = 1
  scaleTo = 100
  showItemLabel = "yes"
  itemLabelFont = "Arial"
  itemLabelSize = "5"
  itemLabelOrientation = "horizontal"
  title = "title text"
  titleFont = "Arial"
  fileFormat = "jpg" 
  lineColor = "##66ccff"
  lineWidth = "5"
  fill = "no"
  graphHeight = "500"
  graphWidth = "1000"
  backgroundColor = "##f2f2f2"
  borderWidth = "5"
  depth = "2"
  gridLines = "2">
</cfgraph>  --->
<cfset Q1income=7600000>
<cfset Q2income=870000>
<cfset Q3income=930000>
<cfset Q4income=860000>

<cfgraph type="Line" 
  title="Quarterly Income"
  backgroundColor = "##f2f2f2">
  <cfgraphdata item="Q1" value=#Q1income#>
  <cfgraphdata item="Q1" value=9600000>
  <cfgraphdata item="Q2" value=#Q2income#>
  <cfgraphdata item="Q3" value=#Q3income#>
  <cfgraphdata item="Q4" value=#Q4income#>
  
</cfgraph>
<cfgraph type="Line" 
  title="Quarterly Income"
  backgroundColor = "##f2f2f2">
  <cfgraphdata item="Q1" value=#Q1income#>
  <cfgraphdata item="Q1" value=9600000>
  <cfgraphdata item="Q2" value=#Q2income#>
  <cfgraphdata item="Q3" value=#Q3income#>
  <cfgraphdata item="Q4" value=#Q4income#>
  
</cfgraph>

</cfoutput>





</body>
</html>
