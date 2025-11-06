import style from './adocao.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';  
import botao from '../../../css/botao.module.css'
import { useNavigate } from 'react-router-dom';
import { FcBinoculars } from 'react-icons/fc';

export default function Adocao() {
    const [adocao, setAdocao] = useState([]);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState(null);
    const navigate = useNavigate();

    // Busca as solicitações de adoção
    const getAdocao = async () => {
        try {
            const response = await endFetch.get("/solicitacao-adocao");
            const aguardando = response.data.filter(
                item => item.status?.toUpperCase() === 'SOLICITACAO_EM_ANDAMENTO'
            );
          setAdocao(aguardando);
        } catch (error) {
            console.error("Erro ao carregar os dados:", error);
            setErro('Erro ao carregar os dados');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        getAdocao();
    }, []);

    const navTelaAdoacao = (id) => {
        navigate(`/TelaAdocao/${id}`);
    };
    
    const navRejeitado = () => {
        navigate(`/AdocaoRejeitadas`);
    };

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {adocao.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Sem solicitações pendentes.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Solicitante</th>
                                <th>Data</th>
                                <th>Animal</th>
                                <th>Status</th>
                                <th className={style.visualizar}>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {adocao.map((item) => (
                                <tr key={item.id}>
                                    <td>{item.id}</td>
                                    <td>{item.proprietario ? item.proprietario.nome : 'Não informado'}</td>
                                    <td>{item.dataSolicitacao ? new Date(item.dataSolicitacao).toLocaleDateString() : 'Não informado'}</td>
                                    <td>{item.animachado ? item.animachado.nome : 'Não informado'}</td>
                                    <td>{item.status}</td>
                                    <td className={table.icon} onClick={() => navTelaAdoacao(item.id)}>
                                        <FcBinoculars size="2rem" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
                <button type="button" className={botao.bred} onClick={navRejeitado}>
                    Rejeitados
                </button>
            </div>
        </>
    );
}
