var top_level = document.getElementsByClassName('APIITEM_cont');
var top_level_length = top_level.length;
var heading_format = ":";

for (var x = 0; x < top_level_length; x++) {
  var heading = top_level[x].getElementsByTagName('h1')[0].innerHTML;
  var formated_heading = heading.concat(heading_format);
  console.log(formated_heading);
  var b_tag = document.getElementsByClassName('APIITEM_cont')[0].getElementsByClassName('name');
  var b_tag_length = b_tag.length
  var str1 = "function:     ";
  for (var i = 0; i < b_tag_length; i++) {
    //function
    console.log(document.getElementsByClassName('APIITEM_cont')[0].getElementsByClassName('name')[i].firstChild.innerHTML);
    //method
    console.log(document.getElementsByClassName('APIITEM_cont')[0].getElementsByClassName('type')[i].getElementsByTagName('b')[0].innerHTML);
  };
};

#Login_Function
gettoken:
  
