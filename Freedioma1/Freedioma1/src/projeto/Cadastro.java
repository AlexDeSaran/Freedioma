package projeto;

public class Cadastro {

    private String idUsuario;
    private String nomeUsuario;

    public Cadastro() {
    }

    public Cadastro(String idUsuario, String nomeUsuario) {
        this.idUsuario = idUsuario;
        this.nomeUsuario = nomeUsuario;
    }

    @Override
    public String toString() {
        String resposta = this.getId() + "\n";
        resposta += this.getSenha() + "\n";
        return resposta;
    }

    public String getId() {
        return idUsuario;
    }

    public void setId(String id) {
        this.idUsuario = id;
    }

    public String getSenha() {
        return nomeUsuario;
    }

    public void setSenha(String senha) {
        this.nomeUsuario = senha;
    }

}
