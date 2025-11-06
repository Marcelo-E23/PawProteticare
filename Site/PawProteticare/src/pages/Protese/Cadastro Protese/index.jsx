import React, { useState} from "react";
import Header from "../../../components/Header";
import Voltar from "../../../components/Voltar";
import endFetch from "../../../axios";
import { useNavigate, Link } from "react-router-dom";
import style from "./cadastro.module.css";
import botao from "../../../css/botao.module.css";
import Input from "../../../modelos/Inputcadastro";

export default function CadastroProtese() {
  const [nome, setNome] = useState("");
  const [fabricante, setFabricante] = useState("");
  const [custo, setCusto] = useState("");
  const [codigo, setCodigo] = useState("");
  const [tipo, setTipo] = useState("");
  const [descricao, setDescricao] = useState("");
  const [message, setMessage] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    const novaProtese = { nome, fabricante, custo, tipo, descricao, codigo};

    try {
      const response = await endFetch.post("/protese", novaProtese);
      setMessage(`Prótese cadastrada com sucesso: ${response.data.nome}`);
      navigate("/Protese");
    } catch (error) {
      console.error(error);
      setMessage("Erro ao cadastrar a prótese. Tente novamente.");
    }
  };

  return (
    <>
      <Header />
      <div className={style.cadastro}>
        <form onSubmit={handleSubmit}>
          <Link to={"/Protese"}>
            <Voltar />
          </Link>

          <Input id="Nome" dado="Nome" legenda="Digite o nome da prótese:" tipo="text" valor={nome} change={(e) => setNome(e.target.value)} />
          <Input id="Codigo" dado="Codigo" legenda="Digite o Código da prótese:" tipo="text" valor={codigo} change={(e) => setCodigo(e.target.value)} />
          <Input id="Fabricante" dado="Fabricante" legenda="Digite o fabricante:" tipo="text" valor={fabricante} change={(e) => setFabricante(e.target.value)} />
          <Input id="Custo" dado="Custo" legenda="Digite o custo:" tipo="number" valor={custo} change={(e) => setCusto(e.target.value)} />
          <Input id="Tipo" dado="Tipo" legenda="Digite o tipo da prótese:" tipo="text" valor={tipo} change={(e) => setTipo(e.target.value)} />
          <Input id="Descricao" dado="Descrição" legenda="Digite a descrição:" tipo="textarea" valor={descricao} change={(e) => setDescricao(e.target.value)} />
          {message && <p className={style.errocadastro}>{message}</p>}

          <button className={botao.bgreen} type="submit">
            Cadastrar
          </button>
        </form>
      </div>
    </>
  );
}