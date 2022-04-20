


// Just return the same code
function getTextAbove() {//"Get Text"
    let text = document.getElementById("textareabox_sql").value; // first text area - all sql code
	$("#pdf_sql_types_above").html("<div class='code'>" + '<pre><code class="language-sql">' + text + '</code></pre>' + "</div>");
	// FormObject.elements["name_result"].value = 'Some Value';
}

// It should not have empty row at the end of list of words!!!!!!!!!! It Throws length error

function getTextNewAbove() {//"Get Text"
    let text = document.getElementById("textareabox_sql").value; // first text area - all sql code
	let text_excel = document.getElementById("textareabox_sql2").value;
	text = text.replace(/[{()}]/g, ' '); // remove all brackets
	
	text = text.replace(',', ''); // remove all commas
	const lines = text.trim().split(/\s+/); // split on space
	console.log('lines',lines); // takes all
	var output = '';
	var list_matches = [];
	console.log('text_excel',text_excel);
	let matches = text_excel.split(/\r\n|\n/);
	matches =  matches.filter(e =>  e); 					// remove empty string from array.
	matches = matches.sort((a,b) => b.length - a.length);	// sorting matches by length desc to color first big words, then the small ones. 
															// If there is category, and category_id (to not color 'category' only from 'category_id')						
	let lastElement = matches[matches.length - 1];
	console.log('lastElement',lastElement, lastElement.length);
	
	/// Unique values - words from requirements who are not put yet into SQL code.
	// let unique1 = lines.filter((o) => matches.indexOf(o) === -1);
	// let unique2 = matches.filter((o) => lines.indexOf(o) === -1);

	// const unique = unique1.concat(unique2);

	///	
	// name_result

	if (lastElement.length < 1) {
			$("#pdf_sql_types").html('Please, remove empty rows from text area');
		}
	
	var str = $("#textareabox_sql").val();
	var re = new RegExp(matches.join("|"), "g"); // create a a | b | c regex
	console.log('re',re);
	
	// to replace it with exact match
	str.match(re).forEach(function(match, i) { // loop over the matches
	  str = str.replaceAll(match, function replaceAll(match) { // wrap the found strings
		return '<em>' + match + '</em>';
		// return hljs.highlightElement('<em>' + match + '</em>');
	  });
	});

	
	// console.log(str);
	str = str.replace(/(?:\r\n|\r|\n)/g, '<br>');
	str = str.replace(/\t/g, '    ');
	// console.log('BR',str);
	$("#pdf_sql_types_above").html("<div class='code'>" + '<pre><code class="language-sql">' + str + '</code></pre>' + "</div>");
	// $("#pdf_sql_types_above").html(str);	
	// FormObject.elements["name_result"].value = 'Some Value';
}



	let list_ckecks = 0


function getTextNewAboveUnique() {//"Get Text"
	list_ckecks += 1;
    let text = document.getElementById("textareabox_sql").value; // first text area - all sql code
	let text_excel = document.getElementById("textareabox_sql2").value;
	text = text.replace(/[{()}]/g, ' '); // remove all brackets
	
	text = text.replace(',', ''); // remove all commas
	const lines = text.trim().split(/\s+/); // split on space
	console.log('lines',lines); // takes all
	var output = '';
	var list_matches = [];
	
	// if (text_excel.length == 0) {
		// return 'pleace put some words in text area'
	// }
	
	console.log('text_excel',text_excel);
	let matches = text_excel.split(/\r\n|\n/);
	matches =  matches.filter(e =>  e); 					// remove empty string from array.
	// matches = matches.sort((a,b) => b.length - a.length);	// sorting matches by length desc to color first big words, then the small ones. 
															// // If there is category, and category_id (to not color 'category' only from 'category_id')						
	// let lastElement = matches[matches.length - 1];
	// console.log('lastElement',lastElement, lastElement.length);
	
	

	
	/// Unique values - words from requirements who are not put yet into SQL code.
	// let unique1 = lines.filter((o) => matches.indexOf(o) === -1);
	// let unique2 = matches.filter((o) => lines.indexOf(o) === -1);

	// const unique = unique1.concat(unique2);

	///	
	// name_result
	
	function get_number_zero_if_list_is_over(matches, list_ckecks) {
		if (matches.length == list_ckecks) {
	return 0;
    }
          else {
            return list_ckecks;
          }
	} 

		
// function myFunction(a, b) {
  // // Return the product of a and b
  // return a * b;
// }

	list_ckecks = get_number_zero_if_list_is_over(matches, list_ckecks);
	console.log('after function list_ckecks',list_ckecks);
	
	var str = $("#textareabox_sql").val();
	
	var matches_one_by_one = []; 		//creating list of one element
	matches_one_by_one.push(matches[list_ckecks]);
	
	var re = new RegExp(matches_one_by_one.join("|"), "g"); // create a a | b | c regex
	console.log('re',re);
	
	// to replace it with exact match
	str = str + '\nKeywords from text area list:\n' + text_excel; // combining two text areas, to check which word is in sql code and whick is checking right now but not in SQL code.
	str.match(re).forEach(function(match, i) { // loop over the matches
	  str = str.replaceAll(match, function replaceAll(match) { // wrap the found strings
		return '<em>' + match + '</em>';
		// return hljs.highlightElement('<em>' + match + '</em>');
	  });
	});

	
	// console.log(str);
	str = str.replace(/(?:\r\n|\r|\n)/g, '<br>');
	str = str.replace(/\t/g, '    ');
	// console.log('BR',str);
	$("#pdf_sql_types_above").html("<div class='code'>" + '<pre><code class="language-sql">' + str + '<br><br>Keywords:<br>' + '</code></pre>' + "</div>");
	// $("#pdf_sql_types_above").html(str);	
	// FormObject.elements["name_result"].value = 'Some Value';
}








// function getTextBelow() {//"Get Text"
    // let text = document.getElementById("textareabox_sql").value; // first text area - all sql code
	// $("#pdf_sql_types_below").html("<div class='code'>" + '<pre><code class="language-sql">' + text + '</code></pre>' + "</div>");
// }

