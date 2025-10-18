import style from './animal.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { Link } from 'react-router-dom';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';  
import { useNavigate } from 'react-router-dom';
import { FcSynchronize, FcBinoculars } from 'react-icons/fc';
import Voltar from '../../../components/Voltar';

export default function Animadotado() {
  const [animadotado, setAnimadotado] = useState([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  // Função que busca os registros e depois os dados completos do animal
  const getAnimadotado = async () => {
    try {
      // 1️⃣ Pega todos os registros de animadotado
      const response = await endFetch.get("/animadotado");
      const adotados = response.data;

      // 2️⃣ Para cada registro, busca o animachado correspondente
      const completos = await Promise.all(
        adotados.map(async (item) => {
          if (item.animachado_id) {
            const animalRes = await endFetch.get(`/animachado/${item.animachado_id}`);
            return { ...item, animachado: animalRes.data };
          }
          return item;
        })
      );

      // 3️⃣ Atualiza o estado
      setAnimadotado(completos);
    } catch (error) {
      console.error("Erro ao carregar os dados:", error);
    } finally {
      setLoading(false);
    }
  };

  const navAlterar = (id) => {
    navigate(`/AlterarAnimalAdotado/${id}`);
  };

  const navVisualizar = (id) => {
    navigate(`/VisualizarAnimalAdotado/${id}`);
  };

  useEffect(() => {
    getAnimadotado();
  }, []);

  if (loading) {
    return <div className={style.carregando}>Carregando...</div>;
  }

  return (
    <>
      <Header />
      <Link to={'/AnimalAchado'}><Voltar/></Link>
      <div className={table.tabela}>
        {animadotado.length === 0 ? (
          <div className={style.semcadastro}>
            <p>Sem animais adotados.</p>
          </div>
        ) : (
          <table className="table table-success table-striped-columns">
            <thead>
              <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Espécie</th>
                <th>Idade</th>
                <th>Status</th>
                <th>Necessidade de Protése</th>
                <th className={style.alterar}><p>Alterar</p></th>
                <th className={style.visualizar}><p>Visualizar</p></th>
              </tr>
            </thead>
            <tbody>
              {animadotado.map((item) => (
                <tr key={item.id}>
                  <td>{item.id}</td>
                  <td>{item.animachado?.nome || '-'}</td>
                  <td>{item.animachado?.especie || '-'}</td>
                  <td>{item.animachado?.idade || '-'} anos</td>
                  <td>{item.animachado?.status || '-'}</td>
                  <td>{item.animachado?.protese || '-'}</td>
                  <td className={table.icon} onClick={() => navAlterar(item.id)}>
                    <FcSynchronize size="3rem" />
                  </td>
                  <td className={table.icon} onClick={() => navVisualizar(item.id)}>
                    <FcBinoculars size="3rem" />
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </>
  );
}
