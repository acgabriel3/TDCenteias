
import kivy
import requests
import pandas as pd

kivy.require('1.11.1')

from kivy.app import App
from kivy.uix.gridlayout import GridLayout
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput

class LoginScreen(GridLayout):

    def __init__(self, **kwargs):
        
        receiver = requests.get('http://localhost:8000/df/dataframe')
        data = pd.read_json(receiver.content)
        
        super(LoginScreen, self).__init__(**kwargs)
        self.cols = 2
        self.add_widget(Label(text=str(data.CS_SEXO)))
        self.username = TextInput(multiline=False)
        self.add_widget(self.username)
        self.add_widget(Label(text=str(data.CS_SEXO)))
        self.password = TextInput(password= True, multiline = False)
        self.add_widget(self.password)

class MyApp(App):

    def build(self):
        
        return LoginScreen()

if __name__ == '__main__':
    MyApp().run()