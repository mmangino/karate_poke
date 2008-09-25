// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function update_count(str,message_id) {
	len=str.length;
  if (len < 200) {
	  $(message_id).setInnerXHTML("<span style='color: green'>"+
	    (200-len)+" remaining</span>");
  } else {
	  $(message_id).setInnerXHTML("<span style='color: red'>"+
	    "Comment too long. Only 200 characters allowed.</span>");
  }
}

function update_multiple(json) {
	for( var i=0; i<json["ids_to_update"].length; i++ ) {
		id=json["ids_to_update"][i];
		$(id).setInnerFBML(json["fbml_"+id]);
	}
}
