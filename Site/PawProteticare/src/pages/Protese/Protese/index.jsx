import Header from '../../../components/Header';
import table from '../../../css/table.module.css';
import style from './protese.module.css';
import endFetch from '../../../axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from 'react';
import botao from '../../../css/botao.module.css';
import { useNavigate } from 'react-router-dom';
import { FcBinoculars } from 'react-icons/fc';

export default function Protese() {
    const [proteses, setProteses] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

useEffect(() => {
  const fetchProteses = async () => {
    try {
      const token = sessionStorage.getItem('access_token'); // ou localStorage.getItem('token')

      const response = await endFetch.get("/protese", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      setProteses(response.data);
    } catch (error) {
      console.error(error);
    } finally {
      setLoading(false);
    }
  };
  fetchProteses();
}, []);

    const navCadastro = () => navigate('/CadastroProtese');
    const navVisualizar = (id) => navigate(`/VisualizarProtese/${id}`);
    const navAlterar = (id) => navigate(`/AlterarProtese/${id}`);

    if (loading) return <div className={style.carregando}>Carregando...</div>;

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {proteses.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Sem próteses cadastradas.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Tipo</th>
                                <th>Fabricante</th>
                                <th>Custo</th>
                                <th>Alterar</th>
                                <th>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {proteses.map(p => (
                                <tr key={p.id}>
                                    <td>{p.id}</td>
                                    <td>{p.nome}</td>
                                    <td>{p.tipo}</td>
                                    <td>{p.fabricante}</td>
                                    <td>{p.custo}</td>
                                    <td className={table.icon} onClick={() => navAlterar(p.id)}>✏️</td>
                                    <td className={table.icon} onClick={() => navVisualizar(p.id)}>
                                        <FcBinoculars size="2rem" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
                <button type="button" className={botao.bgreen} onClick={navCadastro}>Cadastrar Prótese</button>
            </div>
        </>
    );
}
