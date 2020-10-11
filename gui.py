import sys
from PyQt5.QtWidgets import QApplication, QWidget, QToolTip, QPushButton
from PyQt5.QtGui import QFont


class Example(QWidget):
  def __init__(self):
    super().__init__()
    self.initUI()

  def initUI(self):
    QToolTip.setFont(QFont('SansSerif', 10))
    self.setToolTip('YT Macro - jjy')
    btn = QPushButton('Button', self)
    btn.setToolTip('버튼입니다.')
    btn.resize(btn.sizeHint())
    btn.move(50, 50)

    self.setGeometry(300, 300, 300, 300)
    self.setWindowTitle('YT Macro')
    self.show

app = QApplication(sys.argv)
ex = Example()
sys.exit(app.exec_())