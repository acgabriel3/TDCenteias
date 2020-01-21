import json
from main import api
import definicao.df.intDataFrame as df


class smoke:
    def on_get(self, req, resp):

        respostaPadrao = {}

        resp.body = json.dumps(respostaPadrao)


#***
#Como setar o link nas definicoes? Onde declarar os objetos??? (tem que ser uma
# especie de ponteiro)

api.add_route('/df/dataframe', df.dataFrame())
api.add_route('/df/coluna', df.coluna())
api.add_route('/df/celula', df.celula())





