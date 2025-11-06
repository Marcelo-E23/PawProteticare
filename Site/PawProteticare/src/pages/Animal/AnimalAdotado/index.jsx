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
  const [error, setError] = useState('');
  const navigate = useNavigate();

  // Função que busca os registros de animais adotados
  const getAnimadotado = async () => {
    const token = localStorage.getItem('access_token');
    try {
      setLoading(true);
      setError('');
      
      // Busca todos os animais adotados (o backend deve retornar os dados completos)
      const response = await endFetch.get("/animadotado", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      
      console.log('Dados recebidos:', response.data);
      setAnimadotado(response.data);
      
    } catch (error) {
      console.error("Erro ao carregar os dados:", error);
      setError('Erro ao carregar animais adotados');
    } finally {
      setLoading(false);
    }
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

  if (error) {
    return (
      <>
        <Header />
        <Voltar/>
        <div className={style.erro}>{error}</div>
      </>
    );
  }

  return (
    <>
      <Header />
      <Voltar/>
      <div className={table.tabela}>
        {animadotado.length === 0 ? (
          <div className={style.semcadastro}>
            <p>Nenhum animal adotado encontrado.</p>
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
                <th>Necessidade de Prótese</th>
                <th className={style.visualizar}><p>Visualizar</p></th>
              </tr>
            </thead>
            <tbody>
              {animadotado.map((item) => (
                <tr key={item.id}>
                  <td>{item.id}</td>
                  <td>{item.animachado?.nome || item.nome || '-'}</td>
                  <td>{item.animachado?.especie || item.especie || '-'}</td>
                  <td>{item.animachado?.idade || item.idade || '-'} anos</td>
                  <td>{item.animachado?.status || item.status || 'Adotado'}</td>
                  <td>{item.animachado?.protese || item.protese || 'Não'}</td>
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