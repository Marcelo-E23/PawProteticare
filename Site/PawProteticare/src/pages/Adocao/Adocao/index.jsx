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
            const response = await endFetch.get("/solicitacaoadocao"); 
            setAdocao(response.data);
        } catch (error) {
            console.error("Erro ao carregar os dados:", error);
            setAdocao([]);
            setErro('Erro ao carregar os dados');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        getAdocao();
    }, []);

    const navCadastro = () => {
        navigate('/CadastroAdocao');
    };

    const navAlterar = (id) => {
        navigate(`/AlterarAdocao/${id}`);
    };

    const navVisualizar = (id) => {
        navigate(`/VisualizarAdocao/${id}`);
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
                                <th className={style.visualizar}>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {adocao.map((item) => (
                                <tr key={item.id}>
                                    <td>{item.id}</td>
                                    <td>{item.proprietario ? item.proprietario.nome : 'Não informado'}</td>
                                    <td>{new Date(item.data_solicitacao).toLocaleDateString()}</td>
                                    <td>{item.animal ? `${item.animal.nome} (${item.animal.idade} anos)` : 'Não informado'}</td>
                                    <td className={table.icon} onClick={() => navVisualizar(item.id)}>
                                        <FcBinoculars size="3rem" />
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
