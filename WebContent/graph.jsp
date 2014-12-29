<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trend Analysis Tool</title>
<style>

body { font: 12px Arial;}

path { 
	stroke: steelblue;
	stroke-width: 2;
	fill: none;
}

.axis path,
.axis line {
	fill: none;
	stroke: grey;
	stroke-width: 1;
	shape-rendering: crispEdges;
}

</style>
</head>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>

<script>

var	margin = {top: 30, right: 40, bottom: 30, left: 50},
	width = 600 - margin.left - margin.right,
	height = 270 - margin.top - margin.bottom;

var	parseDate = d3.time.format("%Y-%m-%d").parse;

var	x = d3.time.scale().range([0, width]);
var	y = d3.scale.linear().range([height, 0]);

var	xAxis = d3.svg.axis().scale(x)
	.orient("bottom").ticks(5);

var	yAxis = d3.svg.axis().scale(y)
	.orient("left").ticks(5);

var	valueline = d3.svg.line()
	.x(function(d) { return x(d.date); })
	.y(function(d) { return y(d.hits); });
	
var	valueline2 = d3.svg.line()
	.x(function(d) { return x(d.date); })
	.y(function(d) { return y(d.hits); });
  
var	svg = d3.select("body")
	.append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
	.append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// Get the data
d3.csv("Summary1.csv", function(error, data) {
	data.forEach(function(d) {
		d.date = parseDate(d.date);
		d.hits = +d.hits;
		
	});

	// Scale the range of the data
	x.domain(d3.extent(data, function(d) { return d.date; }));
	y.domain([0, d3.max(data, function(d) { return Math.max(d.hits); })]);

	svg.append("path")		// Add the valueline path.
		.attr("class", "line")
		.attr("d", valueline(data));

	
	svg.append("g")			// Add the X Axis
		.attr("class", "x axis")
		.attr("transform", "translate(0," + height + ")")
		.call(xAxis);

	svg.append("g")			// Add the Y Axis
		.attr("class", "y axis")
		.call(yAxis);

	
	svg.append("text")
		.attr("transform", "translate(" + (width+3) + "," + y(data[0].hits) + ")")
		.attr("dy", ".35em")
		.attr("text-anchor", "start")
		.style("fill", "steelblue")
		.text("hits");


});

d3.csv("Summary2.csv", function(error, data) {
	data.forEach(function(d) {
		d.date = parseDate(d.date);
	    d.hits = +d.hits;
	});

	// Scale the range of the data
	x.domain(d3.extent(data, function(d) { return d.date; }));
	//y.domain([0, d3.max(data, function(d) { return Math.max(d.hits); })]);

	svg.append("path")		// Add the valueline2 path.
		.attr("class", "line")
		.style("stroke", "red")
		.attr("d", valueline2(data));

	svg.append("g")			// Add the X Axis
		.attr("class", "x axis")
		.attr("transform", "translate(0," + height + ")")
		.call(xAxis);

	
	svg.append("text")
		.attr("transform", "translate(" + (width+3) + "," + y(data[0].hits) + ")")
		.attr("dy", ".35em")
		.attr("text-anchor", "start")
		.style("fill", "red")
		.text("hits");


});
</script>
</body>
</html>