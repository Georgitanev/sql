
//Raboti s DTS i DTR
// ostavat units i da include - Category, subcat, 
// Frozen something etc.

function countOnlyCapitalLetters (str) { 
  let newStr = "";
  let count = 0;

  for (let i = 0; i < str.length; i++) {
      if (str[i].match(/[A-Z]/)) {
          newStr += str[i];
		  count += 1;
      }
   }
   return count;
}

function countOnlySmallLetters (str) { 
  let newStr = "";
  let count = 0;

  for (let i = 0; i < str.length; i++) {
      if (str[i].match(/[a-z]/)) {
          newStr += str[i];
		  count += 1;
      }
   }
   return count;
}

const s = "[ECTRT_001]"
// console.log(countOnlyCapitalLetters(s)); // should get AM


function hasBracket(s) {
  return s.indexOf('[') >= 0;
}

function contBrackets(s) {
  return s.indexOf('[');
}

function dontHaveWhiteSpace(s) {
  return s.indexOf(' ') == -1;
}

function dontHaveColuns(s) {
  return s.indexOf(':') == -1;
}

function dontHaveRightSlash(s) {
  return s.indexOf('/') == -1;
}

function dateCheck(s) {
  return s.indexOf('(DD/MM') > 0;
}



// RABOTI
let input = document.querySelector('input');
let textarea = document.querySelector("textarea[name='generator']");

// let textarea_test = document.querySelector("textarea[name='test']");



var myStandartArray1 = ["EC001_URL","STUDYNAME","SITECOUNTRY","SITEMNEMONIC","SUBJECTNUMBERSTR","VISITREFNAME","DOV","FORMREFNAME"];

var myStandartArray2 = ["X_DS_STAT_001","X_DS_DAT_001","X_DS_DAT_001_DTS"];


var stringOne = ["EC001_URL","STUDYNAME","SITECOUNTRY","SITEMNEMONIC","SUBJECTNUMBERSTR","VISITREFNAME","DOV","FORMREFNAME"];

function itemExactCheck(s) {
	
	var myStringArray = s.split(' ');
	var arrayLength = myStringArray.length;
	for (var i = 0; i < arrayLength; i++) {
		//Do something
		if (dontHaveColuns(myStringArray[i]) && dontHaveRightSlash(myStringArray[i]) && hasBracket(myStringArray[i]))  {
			return myStringArray[i];
		}
	}
	return 'None';
}


input.addEventListener('change', () => {
    let files = input.files;
	console.log(input);
    if(files.length == 0) return;
    const file = files[0];
    let reader = new FileReader();
    reader.onload = (e) => {
        const file = e.target.result;
        const lines = file.split(/\r\n|\n/);
        textarea.value = lines.join('\n');
		// console.log(textarea.value);
		// lines[0]
		console.log(lines + 'liiiines' + '\n\n\n\n' + Array.from(lines) + ' aaaray I hope');
		var myFormStringArray = Array.from(lines);
		function variableTrue(myFormStringArray) {
		  return countOnlySmallLetters(myFormStringArray[i]) == 0  && hasBracket(myFormStringArray[i]) ;
		}
		function OnlyItemBracket(myFormStringArray) {
		  return dontHaveColuns(myFormStringArray[i]) == true  && dontHaveRightSlash(myFormStringArray[i]) ;
		}
		
		console.log(myFormStringArray);
		var arrayLength = myFormStringArray.length; // text columns
		
		// var newArray = arrayA.concat(arrayB);
		var myStandartArraySum = myStandartArray1.concat(myStandartArray2);
		var arrayLength1 = myStandartArraySum.length; // standart columns
		let standartColumns = '<b>' + 'standart columns' + '</b><br>';
		// new standart columns first
		
		var stringTwo2 = ["X_DS_STAT_001","X_DS_DAT_001","X_DS_DAT_001_DTS"];
		stringOne = stringOne.concat(stringTwo2);
		console.log(stringOne + 'string oneeee');
		///
		for (var i = 0; i < arrayLength1; i++) {
			// console.log(myFormStringArray[i] + ' T');
			// let aaa = '1. Treatment Name'

			standartColumns += myStandartArraySum[i] + '<br>'
				
			}
		document.getElementById("standart_columns").innerHTML = standartColumns;
		//------------------------------------------------------------------

		let textarea_test2 = document.querySelector("textarea[name='test2']");
		let myStringPrintVars = '' //'<b>' + 'category/subcategory' + '</b>' + '<br>';
		myStringPrintVars +=  '<br>'; //textarea_test2 +
		
		myStringPrintVars += '<b>' + 'pdf_extracted' + '</b>' + '<br>';
		for (var i = 0; i < arrayLength; i++) {
			// console.log(myFormStringArray[i] + ' T');
			// let aaa = '1. Treatment Name'
			if (Number.isInteger(parseInt(myFormStringArray[i][0]))) {
				console.log((myFormStringArray[i]));
			}
			// if (countOnlyCapitalLetters(myFormStringArray[i]) >= 2 && hasBracket(myFormStringArray[i]) && dontHaveWhiteSpace(myFormStringArray[i])) {
				
			if (myFormStringArray[i].substring(0, 5) == 'Req /') {
				myStringPrintVars += '_DTS <br>';
				
			}
			if (myFormStringArray[i].substring(0, 7) == 'Req/Unk') {
				myStringPrintVars += '_DTS <br>_DTR <br>';
			}			
			if (variableTrue(myFormStringArray) || dateCheck(myFormStringArray[i])) {
				if (itemExactCheck(myFormStringArray[i]) != 'None') {
				myStringPrintVars += itemExactCheck(myFormStringArray[i]) + '<br>';					
				}

			}
			document.getElementById("demo").innerHTML = myStringPrintVars;
			//Do something
		}

    };
    reader.onerror = (e) => alert(e.target.error.name);
    reader.readAsText(file); 

    
});

var myStringArray = ["Hello","World"];


// var myStandartArray1 = [" ", "EC001_URL","STUDYNAME","SITECOUNTRY","SITEMNEMONIC","SUBJECTNUMBERSTR","VISITREFNAME","DOV","FORMREFNAME",];

// var myStandartArray2 = [" ", "X_DS_STAT_001","X_DS_DAT_001","X_DS_DAT_001_DTS"];

// standart
// EC001_URL
// STUDYNAME
// SITECOUNTRY
// SITEMNEMONIC
// SUBJECTNUMBERSTR
// VISITREFNAME
// DOV
// FORMREFNAME

// standart slopd
// X_DS_STAT_001
// X_DS_DAT_001
// X_DS_DAT_001_DTS

// console.log(Array.from(lines));

var arrayLength = myStringArray.length;
for (var i = 0; i < arrayLength; i++) {
    console.log(myStringArray[i]);
    //Do something
}

// const a = ["a", "b", "c"];

// for (i in a) {
    // console.log(i);
// }

// var myFormStringArray = Array.from(lines);
// var arrayLength = myFormStringArray.length;
// for (var i = 0; i < arrayLength; i++) {
	// console.log(myFormStringArray[i]);		

// if (countOnlyCapitalLetters(s) >= 2 && hasBracket(s) && dontHaveWhiteSpace(s)) {
	// console.log((lines[0] + 'GOGOGO'));
// }

// let input2 = "new_accurate_txt_ec001.txt";
// let textarea_classic = document.querySelector("textarea[name='test']");
// input2.addEventListener('change', () => {
    // let files = input2.files;
    // if(files.length == 0) return;
    // const file = files[0];
    // let reader = new FileReader();
    // reader.onload = (e) => {
        // const file = e.target.result;
        // const lines = file.split(/\r\n|\n/);
        // textarea.value = lines.join('\n');
    // };
    // reader.onerror = (e) => alert(e.target.error.name);
    // reader.readAsText(file); 
    
// });


// function readTextFile(file)
// {
    // var rawFile = new XMLHttpRequest();
    // rawFile.open("GET", file, false);
    // rawFile.onreadystatechange = function ()
    // {
        // if(rawFile.readyState === 4)
        // {
            // if(rawFile.status === 200 || rawFile.status == 0)
            // {
                // var allText = rawFile.responseText;
                // alert(allText);
				// console.log(allText);
            // }
        // }
    // }
    // rawFile.send(null);
// }

// readTextFile("file:///C:\Users\gtanev\Desktop\notepad++\web_page\read_text_file\new_accurate_txt_ec001.txt");

// "new_accurate_txt_ec001.txt"