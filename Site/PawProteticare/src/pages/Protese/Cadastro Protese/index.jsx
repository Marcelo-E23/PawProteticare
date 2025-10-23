import React, { useState, useEffect } from "react";
import Header from "../../../components/Header";
import Voltar from "../../../components/Voltar";
import endFetch from "../../../axios";  
import { useNavigate,Link } from "react-router-dom";
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
  const [animalInfo, setAnimalInfo] = useState(null);
  const [animaisAchados, setAnimaisAchados] = useState([]);
  const [message, setMessage] = useState("");  
  const navigate = useNavigate();

  // Função para buscar animal pelo ID
useEffect(() => {
  const fetchAnimal = async () => {
    const token = localStorage.getItem('access_token');
    try {
      const token = sessionStorage.getItem('token'); // pega o token da sessão

      const response = await endFetch.get(`/animachado`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      setAnimaisAchados(response.data);
    } catch (error) {
      setAnimalInfo(null);
      console.error("Animal não encontrado", error);
    }
  };

  fetchAnimal();
}, [animalId]);


  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!animalInfo) {
      setMessage("Informe um ID de animal válido.");
      return;
    }

    const novaProtese = { nome, fabricante, custo, tipo, descricao, animalId };

    try {
      // Verifica se já existe prótese para esse animal
      const check = await endFetch.get(`/protese?animalId=${animalId}`);
      if (check.data.length > 0) {
        setMessage("Este animal já possui uma prótese cadastrada.");
        return;
      }

      const response = await endFetch.post("/protese", novaProtese);
      setMessage(`Prótese cadastrada com sucesso: ${response.data.nome}`);
      navigate('/Protese');
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
          <Link to={'/Protese'}><Voltar /></Link>

          <Input dado="Nome" legenda="Digite o nome da prótese:" tipo="text" valor={nome} change={e => setNome(e.target.value)} />
          <Input dado="Fabricante" legenda="Digite o fabricante:" tipo="text" valor={fabricante} change={e => setFabricante(e.target.value)} />
          <Input dado="Custo" legenda="Digite o custo:" tipo="number" valor={custo} change={e => setCusto(e.target.value)} />
          <Input dado="Tipo" legenda="Digite o tipo da prótese:" tipo="text" valor={tipo} change={e => setTipo(e.target.value)} />
          <Input dado="Descrição" legenda="Digite a descrição:" tipo="textarea" valor={descricao} change={e => setDescricao(e.target.value)} />

      <div className={input.input}>
  <label htmlFor="animalId">ID do Animal</label>
  <select
    id="animalId"
    value={animalId}
    onChange={e => setAnimalId(e.target.value)}
    required
  >
    <option value="" disabled>
      Selecione o animal
    </option>
    {animaisAchados.map(animal => (
      <option key={animal.id} value={animal.id}>
        {animal.nome} {/* ou outra propriedade que faça sentido */}
      </option>
    ))}
  </select>
</div>


          {animalInfo && (
            <div className={style.animalInfo}>
              <p><strong>Nome:</strong> {animalInfo.nome}</p>
              <p><strong>Espécie:</strong> {animalInfo.especie}</p>
            </div>
          )}

          {message && <p className={style.errocadastro}>{message}</p>}
          <button className={botao.bgreen} type="submit">Cadastrar</button>
        </form>
      </div>
    </>
  );
}
