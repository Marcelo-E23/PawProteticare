import React, { useState, useEffect } from "react";
import Header from "../../../components/Header";
import Voltar from "../../../components/Voltar";
import endFetch from "../../../axios";  
import { useNavigate, Link } from "react-router-dom";
import style from './cadastrodoacao.module.css';
import styles from '../../../css/input.module.css';
import Input from "../../../modelos/Inputcadastro";
import botao from '../../../css/botao.module.css';

const CadastroDoador = () => {
  const [tipodoacao, setTipodoacao] = useState("");
  const [valor, setValor] = useState("");
  const [data, setData] = useState("");
  const [message, setMessage] = useState(""); // ✅ criado estado para mensagem
  const navigate = useNavigate();

  // ✅ useEffect deve ficar aqui, fora do handleSubmit
  useEffect(() => {
    const token = localStorage.getItem('access_token');
    const hoje = new Date();
    const dataFormatada = hoje.toLocaleDateString("pt-BR");
    setData(dataFormatada);
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();

    const novaDoacao = { // nome ajustado
      tipodoacao,
      valor,
      data,
    };

    try {
      const response = await endFetch.post("/doacao", novaDoacao,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
      console.log(novaDoacao);

      setMessage(`Doação cadastrada com sucesso: ${response.data.nome}`);
      navigate('/Doador');

    } catch (error) {
      console.error("Erro do servidor:", error.response?.data || error.message);
      setMessage("Erro ao cadastrar doação. Tente novamente.");
    }
  };

  return (
    <>
      <Header />
      <div className={style.cadastro}>
        <form onSubmit={handleSubmit}>
          <Link to={'/Doador'}><Voltar /></Link>

          <Input 
            dado={"Tipo"} 
            legenda={"Digite o Tipo da doação:"} 
            tipo={"text"} 
            valor={tipodoacao} 
            change={(e) => setTipodoacao(e.target.value)} 
          />

          <Input 
            dado={"Valor"} 
            legenda={"Digite o Valor da doação:"} 
            tipo={"text"} 
            valor={valor} 
            change={(e) => setValor(e.target.value)} 
          />

          <div className={styles.input}>
            <label>Data de Cadastro:</label>
            <input type="text" value={data} readOnly />
          </div>

          {message && <p className={style.errocadastro}>{message}</p>}

          <button className={botao.bgreen} type="submit">Cadastrar</button>
        </form>
      </div>
    </>
  );
};

export default CadastroDoador;
