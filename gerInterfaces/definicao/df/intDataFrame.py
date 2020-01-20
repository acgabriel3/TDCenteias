import json

class dataFrame:

    def on_get(self, req, resp):

        respostaPadrao =

        {
            'col1' = ['a', 'b', 'c'],
            'col2' = ['1', '2', '3']
        }

        resp.body = json.dumps(respostaPadrao)


#***
#Seria mesmo necessario degenerar o dataFrame para as interfaces? (Talvez seja melhor para tratamento futuro)
#serah caule
# class interfaceDataFrame():
#     def dataFrame(self):
#     def coluna(self):
#     def celula(self):
