import React, { useState } from "react";
import Header from "../../../components/Header";
import Voltar from "../../../components/Voltar";
import endFetch from "../../../axios";  
import { useNavigate } from "react-router-dom";
import style from './cadastro.module.css';
import styles from '../../../css/input.module.css';
import Input from "../../../modelos/Inputcadastro";
import botao from '../../../css/botao.module.css';

const CadastroAnimachado = () => {
  const [nome, setNome] = useState("");
  const [especie, setEspecie] = useState("");
  const [idade, setIdade] = useState("");
  const [imagem, setImagem] = useState();  // Agora imagem é um arquivo (não uma URL)
  const [status, setStatus] = useState("ANALISE_SITUACAO");
  const [historia, setHistoria] = useState("");
  const [message, setMessage] = useState("");  
  const [imagemPreview, setImagemPreview] = useState("");  // Estado para armazenar o preview da imagem
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append("nome", nome);
    formData.append("especie", especie);
    formData.append("idade", idade);
    formData.append("status", status);
    formData.append("historia", historia);
    if (imagem) formData.append("imagem", imagem);  // Envia o arquivo da imagem

    try {
      const response = await endFetch.post("/animachado", formData);
      setMessage(`Animal cadastrado com sucesso: ${response.data.nome}`);
      navigate("/AnimalAchado");
    } catch (error) {
      console.error("Erro do servidor:", error.response?.data || error.message);
      setMessage("Erro ao cadastrar o animal. Tente novamente.");
    }
  };

  // Manipulando a mudança da imagem para preview
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setImagem(file);
      const preview = URL.createObjectURL(file);
      setImagemPreview(preview);  // Atualiza o preview da imagem
    }
  };

  return (
    <>
      <Header />
      <div className={style.cadastro}>
        <form onSubmit={handleSubmit}>
          <Voltar />

          <Input 
            id={"Nome"} 
            dado={"Nome"} 
            legenda={"Digite o Nome:"} 
            tipo={"text"} 
            valor={nome} 
            change={(e) => setNome(e.target.value)} 
          />

          <Input 
            id={"Especie"} 
            dado={"Especie"} 
            legenda={"Digite a Especie:"} 
            tipo={"text"} 
            valor={especie} 
            change={(e) => setEspecie(e.target.value)} 
          />

          <Input 
            id={"Idade"} 
            dado={"Idade"} 
            legenda={"Digite a Idade:"} 
            tipo={"number"} 
            valor={idade} 
            change={(e) => setIdade(e.target.value)} 
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
              <option value="ANALISE_SITUACAO">Analisando situação</option>
              <option value="APTO_PARA_ADOCAO">Apto para adoção</option>
              <option value="AGUARDANDO_PROTESE">Aguardando prótese</option>
              <option value="FALECIDO">Falecido</option>
            </select>
          </div>

          <Input 
            id={"História"} 
            dado={"História"} 
            legenda={"Digite a História do animal:"} 
            tipo={"textarea"} 
            valor={historia} 
            change={(e) => setHistoria(e.target.value)} 
          />

          <div className={styles.input}>
            <label htmlFor="imagem">Imagem do Animal</label>
            <input 
              id="imagem"
              type="file" 
              accept="image/*" 
              onChange={handleImageChange} 
              required // Atualizando o estado de imagem e preview
            />
            {imagemPreview && (
              <div className={styles.preview}>
                <img className={styles.imagem}src={imagemPreview} alt="Pré-visualização" style={{ maxWidth: '200px', marginTop: '10px' }} />
              </div>
            )}
          </div>

          {message && <p className={style.errocadastro}>{message}</p>}

          <button className={botao.bgreen} type="submit">Cadastrar</button>
        </form>
      </div>
    </>
  );
};

export default CadastroAnimachado;
