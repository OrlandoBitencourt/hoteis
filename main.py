"""

    Criar um sistema de busca de hotéis

    O usuário colocará o nome de uma cidade e o sistema deverá listar os 10 melhores hotéis na região do estado.
    Ex: Blumenau -> lista os 10 melhores hotéis do Nordeste de SC

    Regras:
    1.	Cada estado será constituído por 5 regiões, sendo elas: Nordeste, Noroeste, Sudeste, Sudoeste e Centro.

    2.	Os hotéis serão classificados de melhor a pior com bases em estrelas, sendo 1 estrela o pior, e 5 estrelas o melhor.

    3.	O usuário poderá também filtrar os resultados (Ex: caso ele ative o filtro de ser necessária uma academia, devem ser listados novos 10 hotéis com academia).

    4.	Cada hotel deve conter as seguintes informações no DataBase: Nome, anos na ativa, Classificação (estrelas), Preço do quarto por noite, Tem academia, Tem piscina, Inclui (café da manhã, almoço e jantar) na tarifa, cidade, estado, vagas disponíveis.

    5.	 Na listagem dos hotéis, devem aparecer todas informações sobre cada hotel.

    6.	Caso o hotel não tenha vagas disponíveis, ele nem deve aparecer na listagem.


"""
import string

from banco_de_dados import BancoDeDados


bd = BancoDeDados()
bd.conectar_db()

def listar_valores(cabecalho_consulta, consulta):
    tamanho_tupla = 24
    lista = []

    for tupla in cabecalho_consulta:
        lista.append(tupla[0].capitalize() + " " * (tamanho_tupla - len(str(tupla[0]))))

    print("".join(lista))

    for tupla in consulta:
        lista = []
        for item in tupla:
            lista.append(str(item) + " " * (tamanho_tupla - len(str(item))))
        print("".join(lista))

while True:

    id_regiao = ""
    academia_digitada = ""
    piscina_digitada = ""
    all_inclusive_digitado = ""

    cidade_digitada = str(input("digite o nome da cidade: "))

    sql = f"select id_regioes from cidades where nome_cidades like '%{cidade_digitada}%' limit 1"

    colunas, id_regiao = bd.executar_select(sql)

    if id_regiao:

        academia_digitada = input("deseja listar apenas hoteis que tenham academia? Digite S para confirmar: ")

        piscina_digitada = input("deseja listar apenas hoteis que tenham piscina? Digite S para confirmar: ")

        all_inclusive_digitado = input("deseja listar apenas hoteis que tenham servico de all inclusive (cafe/almoço/jantar)? Digite S para confirmar: ")

        query = "select " \
                  "h.nome_hoteis, " \
                  "h.classificacao_hoteis, " \
                  "case when h.piscina_hoteis = 0 then 'Não possui piscina' " \
                  "else 'Possui piscina' " \
                  "end as piscina, " \
                  "case when h.academia_hoteis = 0 then 'Não possui academia' " \
                  "else 'Possui academia proria' " \
                  "end as academia, " \
                  "case when all_inclusive_hoteis = 0 then 'Não oferece' " \
                  "else 'café/almoço/jantar' " \
                  "end as all_inclusive, " \
                  "q.descricao_quartos, " \
                  "q.preco_quartos, " \
                  "c.nome_cidades, " \
                  "r.nome_regioes, " \
                  "e.nome_estados, " \
                  "e.uf_estados " \
                  "from hoteis h " \
                  "inner join quartos q on (h.id_hoteis = q.id_hoteis) " \
                  "inner join cidades c on (h.id_cidades = c.id_cidades) " \
                  "inner join regioes r on (c.id_regioes = r.id_regioes) " \
                  "inner join estados e on (r.id_estados = e.id_estados) " \
                  "where 1=1 " \
                  "and q.disponibilidade <> '0' "

        if academia_digitada == 'S' or academia_digitada == 's':
            query = query + "and h.academia_hoteis = 1 "

        if piscina_digitada == 'S' or piscina_digitada == 's':
            query = query + "and h.piscina_hoteis = 1 "

        if all_inclusive_digitado == 'S' or all_inclusive_digitado == 's':
            query = query + "and h.all_inclusive_hoteis = 1 "


        sql = query + f"and r.id_regioes = {id_regiao[0][0]} " \
                  "order by 2 desc, 1 " \
                  "limit 10"
        cabecalho_consulta, consulta = bd.executar_select(sql)

        listar_valores(cabecalho_consulta, consulta)
    else:
        print("Digite uma cidade válida.")



