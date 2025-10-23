import { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './alterar.module.css';
import input from '../../../css/input.module.css';
import botao from '../../../css/botao.module.css';

export default function AlterarAnimadotado() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [animadotado, setAnimadotado] = useState({
    animachado: {
      nome: '',
      especie: '',
      idade: '',
      status: '',
      historia: '',
      protese: '',
      imagem: ''
    },
    proprietario: {
      nome: '',
      cpf: '',
      email: '',
      telefone: '',
      logradouro: '',
      complemento: '',
      cep: ''
    }
  });

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Puxar dados do animadotado, animachado e proprietario
  const getAnimadotado = async () => {
    const token = localStorage.getItem('access_token');
    try {
      const response = await endFetch.get(`/animadotado/${id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
      let data = response.data;

      // Puxar animachado se necessário
      if (data.animachado_id && !data.animachado) {
        const animalRes = await endFetch.get(`/animachado/${data.animachado_id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
        data.animachado = animalRes.data;
      }

      // Puxar proprietario se necessário
      if (data.proprietario_id && !data.proprietario) {
        const propRes = await endFetch.get(`/usuario/${data.proprietario_id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
        data.proprietario = propRes.data;
      }

      setAnimadotado(data);
    } catch (err) {
      console.log(err);
      setError('Erro ao carregar os dados do animadotado');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getAnimadotado();
  }, [id]);

  // Alterar dados do animal (animachado)
  const handleChange = (e) => {
    const { name, value } = e.target;
    setAnimadotado((prevState) => ({
      ...prevState,
      animachado: {
        ...prevState.animachado,
        [name]: value
      }
    }));
  };

  // Alterar imagem do animal
  const handleImagemChange = (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();
    reader.onloadend = () => {
      setAnimadotado((prevState) => ({
        ...prevState,
        animachado: {
          ...prevState.animachado,
          imagem: reader.result
        }
      }));
    };
    if (file) reader.readAsDataURL(file);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      // Apenas atualiza o animachado vinculado ao animadotado
      await endFetch.put(`/animachado/${animadotado.animachado.id}`, animadotado.animachado,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
      navigate('/AnimalAdotado');
    } catch (err) {
      console.log(err);
      setError('Erro ao salvar as alterações');
    }
  };

  if (loading) return <div>Carregando...</div>;

  const { animachado } = animadotado;

  return (
    <>
      <Header />
      <div className={style.login}>
        <form onSubmit={handleSubmit}>
          <Link to={'/AnimalAdotado'}><Voltar /></Link>

          <div className={input.input}>
            <label htmlFor="nome" className="form-label">Nome</label>
            <input
              type="text"
              id="nome"
              name="nome"
              className="form-control"
              value={animachado.nome}
              onChange={handleChange}
              required
            />
          </div>

          <div className={input.input}>
            <label htmlFor="especie" className="form-label">Espécie</label>
            <input
              type="text"
              id="especie"
              name="especie"
              className="form-control"
              value={animachado.especie}
              onChange={handleChange}
              required
            />
          </div>

          <div className={input.input}>
            <label htmlFor="idade" className="form-label">Idade</label>
            <input
              type="number"
              id="idade"
              name="idade"
              className="form-control"
              value={animachado.idade}
              onChange={handleChange}
              required
            />
          </div>

          <div className={input.input}>
            <label htmlFor="status" className="form-label">Status</label>
            <select
              id="status"
              name="status"
              className="form-control"
              value={animachado.status}
              onChange={handleChange}
              required
            >
              <option value="APTO_PARA_ADOCAO">Apto para adoção</option>
              <option value="AGUARDANDO_PROTESE">Aguardando protése</option>
              <option value="ADOTADO">Adotado</option>
              <option value="ANALISE_SITUACAO">Analisando situação</option>
              <option value="FALECIDO">Falecido</option>
            </select>
          </div>

          <div className={input.input}>
            <label htmlFor="protese" className="form-label">N.Prótese</label>
            <input
              type="text"
              id="protese"
              name="protese"
              className="form-control"
              value={animachado.protese}
              onChange={handleChange}
            />
          </div>

          <div className={input.input}>
            <label htmlFor="historia" className="form-label">História</label>
            <textarea
              id="historia"
              name="historia"
              className="form-control"
              value={animachado.historia}
              onChange={handleChange}
            />
          </div>

          <div className={input.input}>
            <label htmlFor="imagem" className="form-label">Imagem do Animal</label>
            <input
              type="file"
              accept="image/*"
              onChange={handleImagemChange}
            />
          </div>

          {error && <div className={style.erroalterar}>{error}</div>}
          <button type="submit" className={botao.bgreen}>Salvar Alterações</button>
        </form>
      </div>
    </>
  );
}
