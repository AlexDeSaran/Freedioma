package projeto;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class DAO {
    private Connection connection = null;
    private PreparedStatement pstdados = null;
    private ResultSet rsdados = null;
    private String login;
    private static final String path = System.getProperty("user.dir");
    private static final File config_file = new File(path + "/src/projeto/configuracaobd.properties");
    private static final String sqlinserir = "INSERT INTO usuario (idUsuario, nomeUsuario) VALUES (?, ?)";
    private static final String sqlinserirprogresso = "INSERT INTO progresso (idUsuario, idFase, idIdioma, idCategoria) VALUES (?, ?, ?, ?)";
    

    public DAO() {

    }

    public boolean CriaConexao() {
        try {
            JDBCUtil.init(config_file);
            connection = JDBCUtil.getConnection();
            connection.setAutoCommit(false);

            DatabaseMetaData dbmt = connection.getMetaData();
            System.out.println("Nome do BD: " + dbmt.getDatabaseProductName());
            System.out.println("Versao do BD: " + dbmt.getDatabaseProductVersion());
            System.out.println("URL: " + dbmt.getURL());
            System.out.println("Driver: " + dbmt.getDriverName());
            System.out.println("Versao Driver: " + dbmt.getDriverVersion());
            System.out.println("Usuario: " + dbmt.getUserName());

            return true;
        } catch (ClassNotFoundException erro) {
            System.out.println("Falha ao carregar o driver JDBC." + erro);
        } catch (IOException erro) {
            System.out.println("Falha ao carregar o arquivo de configuração." + erro);
        } catch (SQLException erro) {
            System.out.println("Falha na conexao, comando sql = " + erro);
        }
        return false;
    }

    public boolean FechaConexao() {
        if (connection != null) {
            try {
                connection.close();
                return true;
            } catch (SQLException erro) {
                System.err.println("Erro ao fechar a conexão = " + erro);
                return false;
            }
        } else {
            return false;
        }
    }

    public boolean Cadastrar(Cadastro cad) {
        try {
            int tipo = ResultSet.TYPE_SCROLL_SENSITIVE;
            int concorrencia = ResultSet.CONCUR_UPDATABLE;
            pstdados = connection.prepareStatement(sqlinserir, tipo, concorrencia);
            pstdados.setString(1, cad.getId());
            pstdados.setString(2, cad.getSenha());
            int resposta = pstdados.executeUpdate();
            System.out.println("Resposta da inserção = " + resposta);
            if (resposta == 1) {
                connection.commit();
                try {
                    pstdados = connection.prepareStatement(sqlinserirprogresso, tipo, concorrencia);
                    for(int x = 1; x <= 5; x++){
                        for(int y = 1; y <= 5; y++){
                                pstdados.setString(1, cad.getId());
                                pstdados.setInt(2, 1);
                                pstdados.setInt(3, y);
                                pstdados.setInt(4, x);
                                resposta = pstdados.executeUpdate();
                        }
                    }
                    System.out.println("Resposta da inserção = " + resposta);
                    if (resposta == 1) {
                        connection.commit();
                        return true;
                    } else {
                        connection.rollback();
                        return false;
                    }
                } catch (SQLException erro) {
                    //tela de erro ao criar
                    System.out.println("Erro na execução da inserção = " + erro);
                }
                return true;
            } else {
                connection.rollback();
                return false;
            }
        } catch (SQLException erro) {
            JOptionPane.showMessageDialog(JFrameLogin.JButtonCadastrar,"Login ja existente! Altere seu nome de usuario", "Erro", JOptionPane.ERROR_MESSAGE);
        }
        return false;
    }
    
    public boolean ConsultarLogin(String nome, String senha) {
        try {
            int tipo = ResultSet.TYPE_SCROLL_SENSITIVE;
            int concorrencia = ResultSet.CONCUR_UPDATABLE;
            String sqlconsultalogin = "Select * from usuario where idUsuario='" + nome + "' and nomeUsuario= '" + senha + "';";
            pstdados = connection.prepareStatement(sqlconsultalogin, tipo, concorrencia);
            rsdados = pstdados.executeQuery();
            if(rsdados.next()){
                login = nome;
                return true;
            }else{
                JOptionPane.showMessageDialog(JFrameLogin.jButtonEntrar,"Credenciais incorretas! Verifique seus dados", "Erro", JOptionPane.ERROR_MESSAGE);
                return false;
            }
            
        } catch (SQLException erro) {
            System.out.println("Erro ao executar consulta = " + erro);
        }
        return false;
    }
    
    public ResultSet getRsdados() {
        return rsdados;
    }
    
    public boolean ConsultarResposta(String palpite, int idFase, int idCategoria, int idIdioma) {
        try {
            int tipo = ResultSet.TYPE_SCROLL_SENSITIVE;
            int concorrencia = ResultSet.CONCUR_UPDATABLE;
            String sqlconsultaresposta = "Select * from fase where resposta='"+ palpite +"' and idFase=" + idFase + " and  idCategoria= " + idCategoria + " and idIdioma = " + idIdioma +";";
            pstdados = connection.prepareStatement(sqlconsultaresposta, tipo, concorrencia);
            rsdados = pstdados.executeQuery();
            if(rsdados.next()){
                //correto
                JOptionPane.showMessageDialog(JFramePalpite.jButton1,"Resposta Correta!", "Parabéns!", JOptionPane.INFORMATION_MESSAGE);
                atualizaProgresso(login, idFase, idCategoria, idIdioma);
                return true;
            }else{
                JOptionPane.showMessageDialog(JFramePalpite.jButton1,"Resposta errada, tente novamente!", "Erro", JOptionPane.ERROR_MESSAGE);
                return false;
            }
            
        } catch (SQLException erro) {
            System.out.println("Erro ao executar consulta = " + erro);
        }
        return false;
    }
    
    public String GerarDica(int idFase, int idCategoria, int idIdioma) {
        try {
            int tipo = ResultSet.TYPE_SCROLL_SENSITIVE;
            int concorrencia = ResultSet.CONCUR_UPDATABLE;
            String sqlconsultaresposta = "Select * from fase where idFase=" + idFase + " and  idCategoria= " + idCategoria + " and idIdioma = " + idIdioma +";";
            pstdados = connection.prepareStatement(sqlconsultaresposta, tipo, concorrencia);
            rsdados = pstdados.executeQuery();
            if(rsdados.next()){
                char dica = rsdados.getString("resposta").charAt(0);
                String retorno = Character.toString(dica);
                for (int x = 0; x < rsdados.getString("resposta").length()-1; x++){
                    retorno = retorno.concat(" _");
                }
                return retorno;
            }else{
                
            }
            
        } catch (SQLException erro) {
            System.out.println("Erro ao executar consulta = " + erro);
        }
        return null;
    }
    
    public boolean verificaProgresso(int idFaseDes, int idCategoria, int idIdioma) {
        try {
            int tipo = ResultSet.TYPE_SCROLL_SENSITIVE;
            int concorrencia = ResultSet.CONCUR_UPDATABLE;
            String sqlconsultaprog = "Select * from progresso where idUsuario='" + login + "' and idCategoria=" + idCategoria + " and idIdioma=" + idIdioma+";";
            pstdados = connection.prepareStatement(sqlconsultaprog, tipo, concorrencia);
            rsdados = pstdados.executeQuery();
            if(rsdados.next()){
                if(rsdados.getInt("idFase") >= idFaseDes){
                    return true;
                }else{
                    JOptionPane.showMessageDialog(null,"Voce ainda nao pode acessar essa fase. Termine as anteriores!", "Erro", JOptionPane.ERROR_MESSAGE);
                    return false;
                }
            }else{
                return false;
            }
            
        } catch (SQLException erro) {
            System.out.println("Erro ao executar consulta = " + erro);
        }
        return false;
    }
    
    public boolean atualizaProgresso(String idUsuario, int idFaseDes, int idCategoria, int idIdioma){
        try {
            int tipo = ResultSet.TYPE_SCROLL_SENSITIVE;
            int concorrencia = ResultSet.CONCUR_UPDATABLE;
            String sqlatualizarprogresso = "UPDATE progresso SET idFase = idFase+1 WHERE idIdioma="+ idIdioma +" and idCategoria="+ idCategoria +" and idUsuario='"+ idUsuario +"';";
            pstdados = connection.prepareStatement(sqlatualizarprogresso, tipo, concorrencia);
            int resposta = pstdados.executeUpdate();
            System.out.println("Resposta da inserção = " + resposta);
            if (resposta == 1) {
                connection.commit();
                return true;
            } else {
                connection.rollback();
                return false;
            }
        } catch (SQLException erro) {
            //tela de erro ao criar
            System.out.println("Erro na execução da inserção = " + erro);
        }
        return false;
        
    }
    
    
}
