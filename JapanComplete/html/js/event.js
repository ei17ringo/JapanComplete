
const DEFAULT_COLOR = '#c6d3db';
const VISIT_COLOR = '#a7c2ee';
const TRAVEL_COLOR = '#618eda';
const STAY_COLOR = '#3b4faf';

function fill_path(newpath){

	//newpath.addEventListener("click", function(){

	var colorcode = newpath.getAttribute("fill");
	var area_id = newpath.getAttribute("id");
	var changecolorcode = DEFAULT_COLOR;
	var code = 0;

    //alert(colorcode);
    
    switch (colorcode) {
        case DEFAULT_COLOR:
            changecolorcode = VISIT_COLOR;
            code = 1;
            break;
        case VISIT_COLOR:
            changecolorcode = TRAVEL_COLOR;
            code = 2;
            break;
        case TRAVEL_COLOR:
            changecolorcode = STAY_COLOR;
            code = 3;
            break;
        case STAY_COLOR:
            changecolorcode = DEFAULT_COLOR;
            code = 0;
            break;
        default:
            changecolorcode = DEFAULT_COLOR;
            code = 0;
            break;
    
    }
    newpath.setAttribute("fill", changecolorcode);

    
//    /* デフォルト -> 立ち寄った */
//    if (colorcode == DEFAULT_COLOR){
//        changecolorcode = VISIT_COLOR;
//        code = 1;
//        newpath.setAttribute("fill", changecolorcode);
//    }
//    
//    /* 立ち寄った -> 旅行した */
//    if (colorcode == VISIT_COLOR){
//        changecolorcode = TRAVEL_COLOR;
//        code = 2;
//        newpath.setAttribute("fill", changecolorcode);
//    }
//                             
//    /* 旅行した -> 住んだ */
//    if (colorcode == TRAVEL_COLOR){
//        changecolorcode = STAY_COLOR;
//        code = 3;
//        newpath.setAttribute("fill", changecolorcode);
//    }
//	
//    /* 住んだ -> デフォルト */
//    if (colorcode == STAY_COLOR){
//        changecolorcode = DEFAULT_COLOR;
//        code = 0;
//        newpath.setAttribute("fill", changecolorcode);
//    }

	var strForObjectiveC = new String();　
	strForObjectiveC += 'webview://saveFunc?color=';
	strForObjectiveC += code;
	strForObjectiveC += '&id=';
	strForObjectiveC += area_id;

	window.location = strForObjectiveC;


//});

}

function setcolor(code,area_id){
    
    
    //alert(area_id+code);
    newpath = document.getElementById(area_id);
    //alert(newpath);
    //newpath.addEventListener("load", function(){

    switch (code) {
        case '0':
  			changecolorcode = DEFAULT_COLOR;
  			break;
		case '1':
			changecolorcode = VISIT_COLOR;
			break;
		case '2':
			changecolorcode = TRAVEL_COLOR;
			break;
        case '3':
            changecolorcode = STAY_COLOR;
            code = 0;
            break;
		default :
			changecolorcode = DEFAULT_COLOR;
			break;
    }
    
    newpath.setAttribute("fill", changecolorcode);
    
    return true;
//});
}

