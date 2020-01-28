
import kivy
import requests
import pandas as pd

kivy.require('1.11.1')

#Padrao
from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.uix.textinput import TextInput
from kivy.uix.popup import Popup

#desejo usar
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.properties import ObjectProperty
from kivy.uix.tabbedpanel import TabbedPanel
from kivy.lang import Builder
from kivy.uix.popup import Popup

import os
import json

#Definicao do centro kv da aplicacao
Builder.load_string("""
<construtorTelas>:
    pos_hint: {'center_x': .5, 'center_y': .5}
    do_default_tab: False
""")

#importacao de modulos, posteriormente deve responder a interface
Builder.load_file('templates/visualizador.kv')
Builder.load_file('templates/extrator.kv')

class LoadDialog(FloatLayout):
    load = ObjectProperty(None)
    cancel = ObjectProperty(None)

class construtorTelas(TabbedPanel):
#     def load_template_files(filenames, page_num):
#         filenames.each(file Builder
#                           .load_file('templates/' + file + '.kv'))
    diretorio = ''
    arquivos = ObjectProperty(None)
    loadfile = ObjectProperty(None)

    def dismiss_popup(self):
        self._popup.dismiss()

    def show_load(self):
        content = LoadDialog(load=self.load, cancel=self.dismiss_popup)
        self._popup = Popup(title="Load file", content=content,
                            size_hint=(0.9, 0.9))
        self._popup.open()

    def load(self, path):
        self.diretorio = os.path.join(path)

        PARAMS = {
            'servico' : 'mapearDiretorio',
            'path' : ('"' + self.diretorio.replace('\\', '/') + '"')
        }


        self.arquivos.text = str(requests.get('http://localhost:8000/df/dataframe',   params = PARAMS).content)
        # self.arquivos.text = PARAMS['path']
        self.dismiss_popup()

    # def mapeia(diretorio):


class TabbedPanelApp(App):
    def build(self):
        return construtorTelas()

if __name__ == '__main__':
    TabbedPanelApp().run()
