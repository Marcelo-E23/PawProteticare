import React, { useState } from "react";
import Header from "../../../components/Header";
import Voltar from "../../../components/Voltar";
import endFetch from "../../../axios";  
import { useNavigate } from "react-router-dom";
import style from './cadastro.module.css';
import styles from '../../../css/input.module.css';
import { Link } from "react-router-dom";
import Input from "../../../modelos/Inputcadastro";
import botao from '../../../css/botao.module.css';

const CadastroProtese = () => {
  const [nome, setNome] = useState("");
  const [fabricante, setFabricante] = useState("");
  const [custo, setCusto] = useState("");
  const [tipo, setTipo] = useState("");
  const [descricao, setDescricao] = useState("");
  const [message, setMessage] = useState("");  
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Define valor de "doado" com base no statu

    const novoAnimachado = {
    nome,
    fabricante,
    custo,
    tipo,
    descricao,
    };

    try {
      const response = await endFetch.post("/protese", novoAnimachado);
      console.log(novaProtese);

      setMessage(`Protese cadastrada com sucesso: ${response.data.nome}`);
      navigate('/Protese');

    } catch (error) {
      console.error("Erro do servidor:", error.response?.data || error.message);
      setMessage("Erro ao cadastrar o protese. Tente novamente.");
    }
  };

  return (
    <>
      <Header />
      <div className={style.cadastro}>
        <form onSubmit={handleSubmit}>
          <Link to={'/Protese'}><Voltar /></Link>

          <Input 
            dado={"Nome"} 
            legenda={"Digite o Nome:"} 
            tipo={"text"} 
            valor={nome} 
            change={(e) => setNome(e.target.value)} 
          />

          <Input 
            dado={"Fabricante"} 
            legenda={"Digite a Fabricante:"} 
            tipo={"text"} 
            valor={fabricante} 
            change={(e) => setFabricante(e.target.value)} 
          />

          <Input 
            dado={"Custo"} 
            legenda={"Digite a Custo:"} 
            tipo={"number"} 
            valor={custo} 
            change={(e) => setCusto(e.target.value)} 
          />

          <Input 
            dado={"Tipo"} 
            legenda={"Digite a Necessidade de Tipo do animal:"} 
            tipo={"text"} 
            valor={tipo} 
            change={(e) => setTipo(e.target.value)} 
          />

          <Input 
            dado={"Descrição"} 
            legenda={"Digite a Descrição do animal:"} 
            tipo={"textarea"} 
            valor={descricao} 
            change={(e) => setDescricao(e.target.value)} 
          />

          {message && <p className={style.errocadastro}>{message}</p>}

          <button className={botao.bgreen} type="submit">Cadastrar</button>
        </form>
      </div>
    </>
  );
};

export default CadastroProtese;
