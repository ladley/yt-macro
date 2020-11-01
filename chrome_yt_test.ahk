; Generated by AutoGUI 2.6.2
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
; CoordMode, Mouse, Screen
#Include %A_ScriptDir%\Lib\ControlColor.ahk
#Include %A_ScriptDir%\Lib\Chrome\Chrome.ahk

Gui +hWndhMainWnd
Gui Color, White
ControlColor(hTxt, hMainWnd, 0xFFFFFF)
Gui Add, Button, x059 y90 w250 h28 gBtnF vbtnFile, CallChrome
Gui Add, Text, x059 y15 w55 h23 +0x200 vtxt1, StartURL
Gui Add, Text, x059 y40 w55 h23 +0x200 vtxt2, 검색어
Gui Add, Text, x059 y65 w55 h23 +0x200 vtxt3, 반복횟수

Gui Add, Edit, x120 y15 w175 h21 vinput1 
Gui Add, Edit, x120 y40 w175 h21 vinput2  
Gui Add, Edit, x120 y65 w175 h21 vinput3 
Gui Show, w392 h150, BJcreen

global pring := false
global SelectedFile := ""
global mode := 0
global process_run := true

return 



timeExtracting(PageInst) {
	;영상의 시간 추출
	ytp_time := PageInst.Evaluate("$('.ytp-time-duration').innerHTML").value
	PageInst.Evaluate("console.log($('.ytp-time-duration').innerHTML)")
	ytp_time := StrSplit(ytp_time, ":")
	Loop % ytp_time.MaxIndex(){
		now_time := ytp_time[A_Index]
		timecnt++
	} 
	
	;시간을 초단위 환산
	if(timecnt == 2){
		ytp_time[1] := ytp_time[1] * 60
		totalcnt := ytp_time[1] + ytp_time[2]
	} else if(timecnt == 3){
		ytp_time[2] := ytp_time[2] * 60
		ytp_time[1] := ytp_time[1] * 3600
		totalcnt := ytp_time[1] + ytp_time[2] + ytp_time[3]
	} else {
		totalcnt := ytp_time[1]
	}
	totalcnt := totalcnt * 1000
	totalcnt := totalcnt / 2
	; MsgBox, %totalcnt%

	return totalcnt
}


BtnF:
	GuiControlGet, input1
	GuiControlGet, input2
	GuiControlGet, input3

	Loop %input3%
		MsgBox, %A_Index%
		ChromeInst := new Chrome("ChromeProfile", "--app=" path, "--window-size=1200,1000")
		
		if !(PageInst := ChromeInst.GetPage()) {
			MsgBox, Could not retrieve page!
			ChromeInst.Kill()
		} else {	

			;입력받은 url 호출하며 크롬 실행
			PageInst.Call("Page.navigate", {"url": input1})
			PageInst.Evaluate("console.log('start')")
			;최상단 노드 추출
			RootNode := PageInst.Call("DOM.getDocument").root
			Sleep, 1000
			;해당 크롬과 바이저의 스테이터스값 가져옴
			WinGet, ChromeStatus, MinMax, ahk_exe chrome.exe
			WinGet, VysorStatus, MinMax, ahk_exe chrome.exe
			Sleep, 1000
			
			;스테이터스가 존재하면 지정 위치로 이동
			if (ChromeStatus != 0 && VysorStatus != 0) {
				WinRestore, ahk_exe chrome.exe
				WinMove, ahk_exe chrome.exe,, 0, 0, 1200, %A_ScreenHeight%
				WinMove, ahk_exe Vysor.exe,, 1200, 0, , %A_ScreenHeight%
				Sleep, 1000
			}
			if (%A_Index% == 1){
				
			}
			
			Sleep, 500
			
			;속도 조절
			PageInst.Evaluate("$('.ytp-button.ytp-settings-button').click()")
			Sleep, 300
			PageInst.Evaluate("$('.ytp-panel-menu').children[1].click()")
			Sleep, 300
			PageInst.Evaluate("$('.ytp-panel-menu').lastElementChild.click()")
			; Send, {Down}{Down}{Down}{Down}{Enter}

			;영상 시간만큼 대기
			totalcnt := timeExtracting(PageInst)
			Sleep, %totalcnt%
			
			;2번째 영상 검색
			MouseClick, Left, 407, 109
			Send, %input2%{Enter}
			Sleep, 1000
			
			;영상 재생
			MouseClick, Left, 265, 302
			Sleep, 1000

			;영상 시간만큼 대기
			totalcnt := timeExtracting(PageInst)
			Sleep, %totalcnt%
			PageInst.kill()

			;비행기모드 끄기
			MouseClick, Left, 1266, 468
			Sleep, 5000
			
			;비행기모드 켜기
			MouseClick, Left, 70, 468
			Sleep, 1000
			ChromeInst.Kill()
		}
	return
   
log_up(msg){
   
    log_path := A_ScriptDir "\log2.txt" 
    FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%msg%]`n, %log_path%
    return
}
   

return 
      