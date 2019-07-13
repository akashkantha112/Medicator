const express = require('express');
const bodyParser = require('body-parser');
const spawn = require("child_process").spawn;
const data = require('./data');


const portNumber = 3000;
const app = express();


Array.prototype.unique = function() {
    var a = this.concat();
    for(var i=0; i<a.length; ++i) {
        for(var j=i+1; j<a.length; ++j) {
            if(a[i] === a[j])
                a.splice(j--, 1);
        }
    }

    return a;
};


function getAllSymptoms(){

	var all = [];

	for(var diseaseName in data){
		all = all.concat(data[diseaseName]);
	}
	return all.unique();

}


function getDetails(diseaseName){

	if(diseaseName in data)
	{
		return {
			status: 200,
			name: diseaseName,
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pretium lectus quam id leo in vitae turpis. Blandit massa enim nec dui nunc mattis enim ut. Aliquet risus feugiat in ante metus dictum at tempor. Gravida cum sociis natoque penatibus et magnis.",
			symptoms: data[diseaseName],
			causes: ["Cause 0","Cause 1","Cause 2","Cause 3","Cause 4","Cause 5"],
			remedies: ["Remedy 0","Remedy 1","Remedy 2","Remedy 3","Remedy 4","Remedy 5"],
			medication: ["Medication 1","Medication 2","Medication 3","Medication 4"],
		};
	}
	else{
		return {
			status: 400,
			message: "Disease name not found in database"
		};
	}

}



app.use(bodyParser.json());



app.post("/searchSymptom",async function (req,res){ 

	var query = req.body.query;

	console.log(query);

	var symptoms = getAllSymptoms();
	console.log(symptoms);
	var result = [];
	for(var name=0;name<symptoms.length;name++){
		console.log(symptoms[name]);
		if(symptoms[name].includes(query)){
			console.log(symptoms[name]);
			result.push(symptoms[name]);
		}
	}

	console.log(result);

	res.send({status: 200,res: result});

 });


app.post("/search",async function (req,res){ 

	var query = req.body.query;

	console.log(query);

	var names = Object.keys(data);

	var result = [];
	for(var dname in names){
		console.log(names[dname]);
		if(typeof(names[dname])==typeof("HI") && names[dname].includes(query)){
			result.push(names[dname]);
		}
	}

	console.log(result);

	res.send({status: 200,res: result});

 });


app.post('/getDisease',async function (req,res) {
		
	var symptoms = req.body.symptoms;

	console.log(symptoms);

	var process = spawn('python3',["logic.py"]);

	var output = "";

	process.stdout.on("data",function(chunk){
		output += chunk.toString("utf8");
	});

	process.stdout.on("end",function(){
		response = output;

		res.send(response);
	});

	process.stdin.write(symptoms.length.toString()+"\n");

	for(var i=0;i<symptoms.length;i++){
		process.stdin.write(symptoms[i]+"\n");
	}
});

app.post('/getDetails',async function (req,res) {
		
	var name = req.body.name;
	console.log(name);
	var details = getDetails(name);
	console.log(details);
	res.send(details);
});




app.listen(portNumber,function(){
	console.log("Server started");
});
