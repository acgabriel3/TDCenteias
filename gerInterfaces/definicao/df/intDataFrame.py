import json
import requests
class dataFrame:

    def __init__(self):
        self.linkServico = None   

    def setLink(self, linkServico):
        self.linkServico = linkServico

    def on_get(self, req, resp):

        # respostaPadrao = {
        #         'col1' : ['a', 'b', 'c'],
        #         'col2' : ['1', '2', '3']
        # }

        #Ainda nao consegui setar o linkServico corretamente
        respostaPadrao = requests.get(url = 'http://localhost:8001/dataframe')

        resp.body = json.dumps(respostaPadrao.json())

class coluna:

    def __init__(self):
        self.linkServico = None   

    def setLink(self, linkServico):
        self.linkServico = linkServico 

    def on_get(self, req, resp):

        respostaPadrao = {
                'col1' : ['a', 'b', 'c']
        }

        resp.body = json.dumps(respostaPadrao)


class celula:

    def __init__(self):
        self.linkServico = None   

    def setLink(self, link):
        self.linkServico = linkServico 

    def on_get(self, req, resp):

        respostaPadrao = {
                'col1' : 'a'      
        }

        resp.body = json.dumps(respostaPadrao)


#***
#Seria mesmo necessario degenerar o dataFrame para as interfaces? (Talvez seja melhor para tratamento futuro)
#serah caule
# class interfaceDataFrame():
#     def dataFrame(self):
#     def coluna(self):
#     def celula(self):
