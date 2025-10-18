import React, { useState, useEffect } from "react";
import Header from "../../../components/Header";
import Voltar from "../../../components/Voltar";
import endFetch from "../../../axios";  
import { useNavigate } from "react-router-dom";
import style from './cadastro.module.css';
import input from '../../../css/input.module.css';
import botao from '../../../css/botao.module.css';
import Input from "../../../modelos/Inputcadastro";

export default function CadastroProtese() {
  const [nome, setNome] = useState("");
  const [fabricante, setFabricante] = useState("");
  const [custo, setCusto] = useState("");
  const [tipo, setTipo] = useState("");
  const [descricao, setDescricao] = useState("");
  const [animalId, setAnimalId] = useState("");
  const [animais, setAnimais] = useState([]);
  const [message, setMessage] = useState("");  
  const navigate = useNavigate();

  useEffect(() => {
    const fetchAnimais = async () => {
      try {
        const response = await endFetch.get("/animadotado"); // lista de animais disponíveis
        setAnimais(response.data);
      } catch (error) {
        console.error("Erro ao carregar animais:", error);
      }
    };
    fetchAnimais();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const novaProtese = { nome, fabricante, custo, tipo, descricao, animalId };
    try {
      const response = await endFetch.post("/protese", novaProtese);
      setMessage(`Prótese cadastrada com sucesso: ${response.data.nome}`);
      navigate('/Protese');
    } catch (error) {
      console.error("Erro do servidor:", error.response?.data || error.message);
      setMessage("Erro ao cadastrar a prótese. Tente novamente.");
    }
  };

  return (
    <>
      <Header />
      <div className={style.cadastro}>
        <form onSubmit={handleSubmit}>
          <Voltar />

          <Input dado={"Nome"} legenda={"Digite o nome da prótese:"} tipo={"text"} valor={nome} change={e => setNome(e.target.value)} />
          <Input dado={"Fabricante"} legenda={"Digite o fabricante:"} tipo={"text"} valor={fabricante} change={e => setFabricante(e.target.value)} />
          <Input dado={"Custo"} legenda={"Digite o custo:"} tipo={"number"} valor={custo} change={e => setCusto(e.target.value)} />
          <Input dado={"Tipo"} legenda={"Digite o tipo da prótese:"} tipo={"text"} valor={tipo} change={e => setTipo(e.target.value)} />
          <Input dado={"Descrição"} legenda={"Digite a descrição:"} tipo={"textarea"} valor={descricao} change={e => setDescricao(e.target.value)} />

          <div className={input.input}>
            <label htmlFor="animal" className="form-label">Animal</label>
            <select id="animal" value={animalId} onChange={e => setAnimalId(e.target.value)} required>
              <option value="">Selecione um animal</option>
              {animais.map(animal => (
                <option key={animal.id} value={animal.id}>
                  {animal.nome} ({animal.especie})
                </option>
              ))}
            </select>
          </div>

          {message && <p className={style.errocadastro}>{message}</p>}
          <button className={botao.bgreen} type="submit">Cadastrar</button>
        </form>
      </div>
    </>
  );
}
