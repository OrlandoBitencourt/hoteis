import MySQLdb


"""
criar funcao para db
criar crud
"""


class BancoDeDados:

    def conectar_db(self):
        try:
            self.conn = MySQLdb.connect(db="hoteis", host="localhost", port=3306, user="root")
        except:
            print("Não foi possivel conectar ao banco de dados!")
            return False
        print("Conectado ao banco!")

        self.cursor = self.conn.cursor()
        return True

    def executar_select(self, sql):
        self.cursor.execute(sql)
        return self.cursor.description, self.cursor.fetchall()

    def executar_insert(self, sql):
        try:
            self.cursor.execute(sql)
            self.conn.commit()
        except:
            print("erro ao executar insert")
            return False
        print("insert executado")
        return True

    def executar_update(self, sql):
        try:
            self.cursor.execute(sql)
            self.conn.commit()
        except:
            print("erro ao executar update")
            return False
        print("update executado")
        return True

    def executar_delete(self, sql):
        try:
            self.cursor.execute(sql)
            self.conn.commit()
        except:
            print("erro ao executar delete")
            return False
        print("delete executado")
        return True
