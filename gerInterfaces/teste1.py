------------------------------------------------------------
Front:

class Window: 
    width
    height
    pagenum
    Button[] buttons
    Box[] boxes

    show(rota):
        data = app.get(rota)


class WindowController:
    janelas = []
    counter
    janela_atual

    switchTo(pagenum):
        self.janela_atual = self.janelas[pagenum]

    add(tab)
        push(janelas, tab)

------------------------------------------------------------
Back no Python:

class RoutesController:
    app: HTTP
    create():
        visualizador = new Visualizador()
        app.registerRequest.get('/visualizador/list', visualizador.list)

    run():
        app.run()

class DfController:
    send(rota, data):
        # manda pro R o caminho do arquivo
        app.post(rota, body = json(data))

    get(rota, params = {}):
        # pega do output ou sla como depende da lib
        return app.get(rota, params)

class Plugin:
    DfController dtframe_ctrl
    Window window

class Visualizador extends Plugin:
    list():
        json_data = self.dtframe_ctrl.get('/listarArquivos')
        window.show('/visualizador/list')
    