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

const CadastroAnimachado = () => {
  const [nome, setNome] = useState("");
  const [protese, setProtese] = useState("");
  const [especie, setEspecie] = useState("");
  const [idade, setIdade] = useState("");
  const [imagem, setImagem] = useState("");
  const [status, setStatus] = useState("ANALISE_SITUAÇÃO");
  const [historia, setHistoria] = useState("");
  const [message, setMessage] = useState("");  
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Define valor de "doado" com base no status
    const doado = status === "Adotado";

    const novoAnimachado = {
      nome,
      protese,
      especie,
      idade: Number(idade),
      status,
      historia,
      imagem,
      doado,
    };

    try {
      const token = localStorage.getItem('access_token');
      const response = await endFetch.post("/animachado", novoAnimachado,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
      console.log(novoAnimachado);

      setMessage(`Animal cadastrado com sucesso: ${response.data.nome}`);
      navigate('/AnimalAchado');

    } catch (error) {
      console.error("Erro do servidor:", error.response?.data || error.message);
      setMessage("Erro ao cadastrar o animal. Tente novamente.");
    }
  };

  return (
    <>
      <Header />
      <div className={style.cadastro}>
        <form onSubmit={handleSubmit}>
          <Link to={'/AnimalAchado'}><Voltar /></Link>

          <Input 
            dado={"Nome"} 
            legenda={"Digite o Nome:"} 
            tipo={"text"} 
            valor={nome} 
            change={(e) => setNome(e.target.value)} 
          />

          <Input 
            dado={"Especie"} 
            legenda={"Digite a Especie:"} 
            tipo={"text"} 
            valor={especie} 
            change={(e) => setEspecie(e.target.value)} 
          />

          <Input 
            dado={"Idade"} 
            legenda={"Digite a Idade:"} 
            tipo={"number"} 
            valor={idade} 
            change={(e) => setIdade(e.target.value)} 
          />

          <Input 
            dado={"Protése"} 
            legenda={"Digite a Necessidade de Protése do animal:"} 
            tipo={"text"} 
            valor={protese} 
            change={(e) => setProtese(e.target.value)} 
          />

          <div className={styles.input}>
            <label htmlFor="status" className="form-label">Status:</label>
            <select 
              id="status" 
              name="status" 
              value={status} 
              onChange={(e) => setStatus(e.target.value)}
              required
            >   
              <option value="APTO_PARA_ADOCAO">Apto para adoção</option>
              <option value="AGUARDANDO_PROTESE">Aguardando protése</option>
              <option value="ADOTADO">Adotado</option>
              <option value="ANALISE_SITUACAO">Analisando situação</option>
              <option value="FALECIDO">Falecido</option>
            </select>
          </div>

          <Input 
            dado={"História"} 
            legenda={"Digite a História do animal:"} 
            tipo={"textarea"} 
            valor={historia} 
            change={(e) => setHistoria(e.target.value)} 
          />

          <div className={styles.input}>
            <label>Imagem do Animal</label>
            <input 
              type="file" 
              accept="image/*" 
              onChange={(e) => {
                const file = e.target.files[0];
                const reader = new FileReader();
                reader.onloadend = () => {
                  setImagem(reader.result); 
                };
                if (file) {
                  reader.readAsDataURL(file);
                }
              }}
            />
          </div>

          {message && <p className={style.errocadastro}>{message}</p>}

          <button className={botao.bgreen} type="submit">Cadastrar</button>
        </form>
      </div>
    </>
  );
};

export default CadastroAnimachado;
//