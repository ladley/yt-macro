#demo.py
import pyautogui as pag
import json
from time import sleep
# pag.moveTo(x=48, y=205, duration=0.5)
# pag.click(clicks=2)

pag.FAILSAFE = False

data = pag.prompt('추출데이터를 넣어주세요.')

datatojson = json.loads(data) 

print(datatojson)

target_id = datatojson['target_id']
target_time = datatojson['target_time']
source_searchword = datatojson['source_searchword']
order = 245+155*(int(datatojson['order'])+1)
repeat = datatojson['repeat']

print(target_id)
print(target_time)
print(source_searchword)
print(order)
print(repeat)

# 크롬실행
pag.press('win')
pag.typewrite('chrome', 0.1)
pag.press('enter')

sleep(2)

# 시크릿탭 열기
pag.hotkey('ctrl', 'shift', 'n')

sleep(0.5)

# 주소창 클릭후 유튜브 검색
pag.click(x=300, y=41)
pag.typewrite('youtube.com', 0.1)
pag.press('enter')

sleep(2)



# 한영 바꾸기
pag.hotkey('shift', 'space')

# 검색어 검색
pag.click(x=641, y=133)
pag.typewrite(source_searchword, interval=0.1)
pag.press('enter')

sleep(2)

# 영상클릭
pag.click(x=590, y=order)

# sleep(7)


# # 두번째 영상 검색
# pag.click(x=650, y=163)
# pag.hotkey('command', 'a')
# pag.typewrite(search_word, interval=0.1)
# pag.press('enter')

# sleep(1)
# # 첫번째 영상클릭
# pag.click(x=450, y=364)

# sleep(5)

# # 설정버튼
# pag.click(x=1064, y=848, interval=0.5)

# sleep(1)
# # 재생속도 버튼
# pag.click(x=1089, y=707)
# sleep(0.2)
# pag.press('down', presses=4, interval=0.1)
# pag.press('enter')
# pag.hotkey('ctrl', 'space')
