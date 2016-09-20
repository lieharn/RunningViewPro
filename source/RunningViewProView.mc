using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class RunningViewProView extends Ui.DataField {

    hidden const CENTER = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;
    hidden const HEADER_FONT = Graphics.FONT_XTINY;
    
	//header	
	hidden var headerAvgPace;
	hidden var headerHr;
	hidden var headerPace;
	hidden var headerDist;
	hidden var headerTimer;

	//values
	hidden var avgPace = 0;
    hidden var hr = 0;
    hidden var pace = 0;
    hidden var dist = 0;
    hidden var elapsedTime = 0;

    function initialize() {
        DataField.initialize();
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
        headerAvgPace = Ui.loadResource(Rez.Strings.headerAvgPace);
        headerHr = Ui.loadResource(Rez.Strings.headerHr);
        headerPace = Ui.loadResource(Rez.Strings.headerPace);
        headerDist = Ui.loadResource(Rez.Strings.headerDist);
        headerTimer = Ui.loadResource(Rez.Strings.headerTimer);
    }

    // The given info object contains all the current workout
    // information. Calculate a value and save it locally in this method.
    function compute(info) {
		
		avgPace = info.averageSpeed != null ? info.averageSpeed : 0;
        hr = info.currentHeartRate != null ? info.currentHeartRate : 0;
        pace = 0; //= info.speed != null ? info.speed : 0;
        dist = 0; //info.distance != null ? info.distance : 0;
        elapsedTime = info.elapsedTime != null ? info.elapsedTime : 0;
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {              

      	drawAvgPace(dc);
      	drawHr(dc);
      	drawPace(dc);
      	drawDist(dc);
      	drawTimer(dc);
        
        createGrid(dc);
    }
    
    function drawAvgPace(dc) {
	    //header
    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(57, 140, HEADER_FONT, headerAvgPace, CENTER);
      	
      	//value
      	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(57, 165, Graphics.FONT_SYSTEM_NUMBER_MEDIUM, avgPace, CENTER);
    }
    
    function drawHr(dc) {
	    //header
      	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(109, 55, HEADER_FONT, headerHr, CENTER);
      	
      	//value
      	dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(109, 90, Graphics.FONT_SYSTEM_NUMBER_HOT, hr, CENTER);
    }
    
    function drawPace(dc) {
	    //header
    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(40, 70, HEADER_FONT, headerPace, CENTER);
      	
      	//value
      	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(40, 100, Graphics.FONT_SYSTEM_NUMBER_MEDIUM, pace, CENTER);
    }
    
    function drawDist(dc) {
	    //header
    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(160, 140, HEADER_FONT, headerDist, CENTER);
      	
      	//value
      	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(160, 165, Graphics.FONT_SYSTEM_NUMBER_MEDIUM, pace, CENTER);
    }
    
    function drawTimer(dc) {
    
    	var duration = "0:00";
        if (elapsedTime != null && elapsedTime > 0) {
            var hours = null;
            var minutes = elapsedTime / 1000 / 60;
            var seconds = elapsedTime / 1000 % 60;
            
            if (minutes >= 60) {
                hours = minutes / 60;
                minutes = minutes % 60;
            }
            
            if (hours == null) {
                duration = minutes.format("%d") + ":" + seconds.format("%02d");
            } else {
                duration = hours.format("%d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d");
            }
        } 
        
        //header
    	//dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
      	//dc.drawText(109, 200, HEADER_FONT, headerTimer, CENTER);
      	
      	//value
      	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      	dc.drawText(109, 200, Graphics.FONT_TINY, duration, CENTER);
    }
    
    function createGrid(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, 45, dc.getWidth(), 45);
        dc.drawLine(0, 130, dc.getWidth(), 130);        
        dc.drawLine(0, 190, dc.getWidth(), 190);
        dc.drawLine(109, 130, 109, 190);
    }

}
