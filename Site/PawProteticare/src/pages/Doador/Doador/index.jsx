import Header from '../../../components/Header';
import table from '../../../css/table.module.css';
import style from './doador.module.css';
import endFetch from '../../../axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { FcBinoculars } from 'react-icons/fc';
import botao from '../../../css/botao.module.css';

export default function Doacao() {
    const [doacoes, setDoacoes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState(null);
    const navigate = useNavigate();

    const getDoacoes = async () => {
        try {
            const response = await endFetch.get("/doacao");
            setDoacoes(response.data);
        } catch (error) {
            console.error("Erro ao carregar doações:", error);
            setErro("Erro ao carregar os dados");
        } finally {
            setLoading(false);
        }
    };

    const navVisualizar = (id) => navigate(`/VisualizarDoacao/${id}`);
    const navCadastro = () => navigate('/CadastroDoacao');

    useEffect(() => {
        getDoacoes();
    }, []);

    return (
        <>
            <Header />
            <div className={table.tabela}>
                <div className={style.topo}>
                    <h2>Doações</h2>
                </div>

                {loading ? (
                    <div className={style.carregando}>
                        <div className="spinner-border text-success" role="status">
                            <span className="visually-hidden">Carregando...</span>
                        </div>
                    </div>
                ) : erro ? (
                    <div className={style.semcadastro}><p>{erro}</p></div>
                ) : doacoes.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Sem doações registradas.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Doador</th>
                                <th>Data</th>
                                <th>Valor</th>
                                <th className={style.visualizar}>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {doacoes.map((item) => (
                                <tr key={item.id}>
                                    <td>{item.id}</td>
                                    <td>{item.doador?.nome || 'Não informado'}</td>
                                    <td>{new Date(item.data).toLocaleDateString('pt-BR')}</td>
                                    <td>{item.valor.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })}</td>
                                    <td className={table.icon} onClick={() => navVisualizar(item.id)}>
                                        <FcBinoculars size="2rem" />
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
