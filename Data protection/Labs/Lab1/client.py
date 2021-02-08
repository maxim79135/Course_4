import requests
import pcid
from PyQt5.QtWidgets import *

SERVER_URL = 'http://135.181.233.195:5000'

id_ = pcid.pcid()
app = QApplication([])
label = QLabel()
app.exec_()


try:
    response = requests.get(f'{SERVER_URL}/check', params={
        'id': id_
    }).text
    
    if response == 'TRUE':
        label.setText("Программа активирована")
        print('Program is activated')
    else:
        label.setText("Нет доступа")
        print('Program is not activated')
    label.show()
except:
    print('Can not check activation status')
