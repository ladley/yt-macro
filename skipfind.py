import pyautogui as pag

pag.click(x=366, y=174)
pos = pag.locateCenterOnScreen('images/skipBtn.png')
pag.moveTo(pos)

print(pos)