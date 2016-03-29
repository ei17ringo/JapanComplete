
const DEFAULT_COLOR = '#c6d3db';
const VISIT_COLOR = '#a7c2ee';
const TRAVEL_COLOR = '#618eda';
const STAY_COLOR = '#3b4faf';

window.addEventListener("touchend", function() {
                          init();
                          }, false);

function init(){
    // ページの幅 ÷ 表示されている幅（この行だけでいいかな）
    var zoomer = document.body.clientWidth / window.innerWidth;
    
    // 以下で拡大率を目視できるでしょう
    if (zoomer > 0.8){
        document.getElementById("Hokkaido_name").style.display="block";
        document.getElementById("Aomori_name").style.display="block";
        document.getElementById("Akita_name").style.display="block";
        document.getElementById("Iwate_name").style.display="block";
        document.getElementById("Yamagata_name").style.display="block";
        document.getElementById("Miyagi_name").style.display="block";
        document.getElementById("Fukushima_name").style.display="block";
        
        document.getElementById("Nigata_name").style.display="block";
        document.getElementById("Ibaraki_name").style.display="block";
        document.getElementById("Tochigi_name").style.display="block";
        document.getElementById("Gunma_name").style.display="block";
        document.getElementById("Chiba_name").style.display="block";
        document.getElementById("Saitama_name").style.display="block";
        document.getElementById("Tokyo_name").style.display="block";
        document.getElementById("Kanagawa_name").style.display="block";
        
        document.getElementById("Yamanashi_name").style.display="block";
        document.getElementById("Shizuoka_name").style.display="block";
        document.getElementById("Gifu_name").style.display="block";
        document.getElementById("Nagano_name").style.display="block";
        document.getElementById("Toyama_name").style.display="block";
        document.getElementById("Aichi_name").style.display="block";
        document.getElementById("Fukui_name").style.display="block";
        document.getElementById("Kanazawa_name").style.display="block";

        document.getElementById("Shimane_name").style.display="block";
        document.getElementById("Tottori_name").style.display="block";
        document.getElementById("Okayama_name").style.display="block";
        document.getElementById("Hiroshima_name").style.display="block";
        document.getElementById("Yamaguchi_name").style.display="block";
        
        
        document.getElementById("Kagawa_name").style.display="block";
        document.getElementById("Ehime_name").style.display="block";
        document.getElementById("Tokushima_name").style.display="block";
        document.getElementById("Kouchi_name").style.display="block";
        
        document.getElementById("Fukuoka_name").style.display="block";
        document.getElementById("Saga_name").style.display="block";
        document.getElementById("Nagasaki_name").style.display="block";
        document.getElementById("Kumamoto_name").style.display="block";
        document.getElementById("Ohita_name").style.display="block";
        document.getElementById("Miyazaki_name").style.display="block";
        document.getElementById("Kagoshima_name").style.display="block";
        document.getElementById("Okinawa_name").style.display="block";

        
    }else{
        document.getElementById("Hokkaido_name").style.display="none";
        document.getElementById("Aomori_name").style.display="none";
        document.getElementById("Akita_name").style.display="none";
        document.getElementById("Iwate_name").style.display="none";
        document.getElementById("Yamagata_name").style.display="none";
        document.getElementById("Miyagi_name").style.display="none";
        document.getElementById("Fukushima_name").style.display="none";
        
        document.getElementById("Nigata_name").style.display="none";
        document.getElementById("Ibaraki_name").style.display="none";
        document.getElementById("Tochigi_name").style.display="none";
        document.getElementById("Gunma_name").style.display="none";
        document.getElementById("Chiba_name").style.display="none";
        document.getElementById("Saitama_name").style.display="none";
        document.getElementById("Tokyo_name").style.display="none";
        document.getElementById("Kanagawa_name").style.display="none";
        
        document.getElementById("Yamanashi_name").style.display="none";
        document.getElementById("Shizuoka_name").style.display="none";
        document.getElementById("Gifu_name").style.display="none";
        document.getElementById("Nagano_name").style.display="none";
        document.getElementById("Toyama_name").style.display="none";
        document.getElementById("Aichi_name").style.display="none";
        document.getElementById("Fukui_name").style.display="none";
        document.getElementById("Kanazawa_name").style.display="none";
        
        document.getElementById("Shimane_name").style.display="none";
        document.getElementById("Tottori_name").style.display="none";
        document.getElementById("Okayama_name").style.display="none";
        document.getElementById("Hiroshima_name").style.display="none";
        document.getElementById("Yamaguchi_name").style.display="none";

        document.getElementById("Kagawa_name").style.display="none";
        document.getElementById("Ehime_name").style.display="none";
        document.getElementById("Tokushima_name").style.display="none";
        document.getElementById("Kouchi_name").style.display="none";
        
        
        document.getElementById("Fukuoka_name").style.display="none";
        document.getElementById("Saga_name").style.display="none";
        document.getElementById("Nagasaki_name").style.display="none";
        document.getElementById("Kumamoto_name").style.display="none";
        document.getElementById("Ohita_name").style.display="none";
        document.getElementById("Miyazaki_name").style.display="none";
        document.getElementById("Kagoshima_name").style.display="none";
        document.getElementById("Okinawa_name").style.display="none";
    }
    
    if (zoomer > 1.5){
        //alert( document.body.clientWidth );
        //var test = window.getElementById("Hokkaido_name").getAttribute("display");
        //alert(test);
    
        
        document.getElementById("Shiga_name").style.display="block";
        document.getElementById("Hyogo_name").style.display="block";
        document.getElementById("Kyoto_name").style.display="block";
        document.getElementById("Osaka_name").style.display="block";
        document.getElementById("Wakayama_name").style.display="block";
        document.getElementById("Nara_name").style.display="block";
        document.getElementById("Mie_name").style.display="block";
        
    }else{
    
        
    document.getElementById("Shiga_name").style.display="none";
    document.getElementById("Hyogo_name").style.display="none";
    document.getElementById("Kyoto_name").style.display="none";
    document.getElementById("Osaka_name").style.display="none";
    document.getElementById("Wakayama_name").style.display="none";
    document.getElementById("Nara_name").style.display="none";
    document.getElementById("Mie_name").style.display="none";
        
    }
    
}

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

