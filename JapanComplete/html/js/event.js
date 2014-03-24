

function fill_path(newpath){

	newpath.addEventListener("click", function(){

	var colorcode = newpath.getAttribute("fill");
	var area_id = newpath.getAttribute("id");
	var changecolorcode = '#FFFFFF';
	var code = 0;

    //alert(colorcode);
    
                             
    /* 白 */
    if (colorcode == '#FFFFFF'){
        changecolorcode = '#FFFF00';
        code = 1;
        newpath.setAttribute("fill", changecolorcode);
    }
    
    /* 黄色 */
    if (colorcode == '#FFFF00'){
        changecolorcode = '#00BFFF';
        code = 2;
        newpath.setAttribute("fill", changecolorcode);
    }
                             
    /* 水色 */
    if (colorcode == '#00BFFF'){
        changecolorcode = '#4169e1';
        code = 3;
        newpath.setAttribute("fill", changecolorcode);
    }
	
    /* 青 */
    if (colorcode == '#4169e1'){
        changecolorcode = '#FFFFFF';
        code = 0;
        newpath.setAttribute("fill", changecolorcode);
    }

	var strForObjectiveC = new String();　
	strForObjectiveC += 'webview://saveFunc?color=';
	strForObjectiveC += code;
	strForObjectiveC += '&id=';
	strForObjectiveC += area_id;

	window.location = strForObjectiveC;


});

}

function setcolor(code,area_id){
    
    
    //alert(area_id+code);
    newpath = document.getElementById(area_id);
    //alert(newpath);
    //newpath.addEventListener("load", function(){

    switch (code) {
        case '0':
  			changecolorcode = '#FFFFFF';
  			break;
		case '1':
			changecolorcode = '#FFFF00';
			break;
		case '2':
			changecolorcode = '#00BFFF';
			break;
        case '3':
            changecolorcode = '#4169e1';
            code = 0;
            break;
		default :
			changecolorcode = '#FFFFFF';
			break;
    }
    
    newpath.setAttribute("fill", changecolorcode);
    
    return true;
//});
}

